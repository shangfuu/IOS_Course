//
//  ViewController.swift
//  HW4_B10615045
//
//  Created by shungfu on 2020/5/16.
//  Copyright © 2020 shungfu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    enum LOOP {
        case SINGLE
        case MULTI
        case RANDOM
    }
    
    var player = AVPlayer()
    var playerLayer: AVPlayerLayer!
    
    var count = 0
    var isplaying:Bool = true
    var source = [URL]()
    
    var Loop_Style = LOOP.MULTI
    
    @IBOutlet weak var videoView: UIView!
    
    @IBOutlet weak var progressSlider: UISlider!
    
    @IBOutlet weak var VideoName: UILabel!
    @IBOutlet weak var VolumeLable: UILabel!
    
    @IBOutlet weak var currentTime: UILabel!
    @IBOutlet weak var durationTime: UILabel!
    
    @IBOutlet weak var Loop: UIButton!
    @IBOutlet weak var PlayPause: UIButton!
    
    func play_music(){
        // Set Songs
        let playerItem = AVPlayerItem(url: source[count])
        player.replaceCurrentItem(with: playerItem)
        
        // Set Video Name
        VideoName.text = source[count].lastPathComponent
        
        // Set playpause
        isplaying = true
        PlayPause.setTitle("⏸", for: .normal)
        
        // Set Video Progress part
        let duration = playerItem.asset.duration
        let second = CMTimeGetSeconds(duration)
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = Float(second)
        
        // Set Loop Notification to every playing AVplayerItem
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        player.play()
    }
    
    func formatConversion(time: Float64) ->String {
        let songLength = Int(time)
        let hours = Int(songLength / 3600)
        let minutes = Int(songLength / 60) % 60
        let seconds = Int(songLength % 60)
        
        var time = ""
        if hours > 0 {
            time = String(format: "%i:%02i:%02i", arguments: [hours,minutes, seconds])
        }
        else {
            time = String(format: "%02i:%02i", arguments: [minutes, seconds])
        }
        return time
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        source.append(Bundle.main.url(forResource: "Jasmine", withExtension: "mp4")!)
        source.append(Bundle.main.url(forResource: "Brother", withExtension: "mp4")!)
        source.append(Bundle.main.url(forResource: "Spongebob", withExtension: "mp4")!)
        
        // Player Periodic Time Observer
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { (CMTime) in
            let currentTime = CMTimeGetSeconds(self.player.currentTime())
            self.progressSlider.value = Float(currentTime)
            self.currentTime.text = self.formatConversion(time: currentTime)
            
            let duration = self.player.currentItem?.asset.duration
            let second = CMTimeGetSeconds(duration!)
            self.durationTime.text = self.formatConversion(time: (second -  currentTime))
        }
        
        // LOOP init MULTI mode
        player.actionAtItemEnd = .none
        Loop_Style = LOOP.MULTI
        
        // Play Video
        play_music()
        
        // Video Layer
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resize
        
        videoView.layer.addSublayer(playerLayer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }
    
    @IBAction func playpause_btn(_ sender: UIButton) {
        if isplaying{
            sender.setTitle("▶️", for: .normal)
            player.pause()
            isplaying = false
        }
        else {
            sender.setTitle("⏸", for: .normal)
            player.play()
            isplaying = true
        }
    }
    
    @IBAction func prev_btn(_ sender: UIButton) {
        count -= 1
        if count < 0{
            count = source.count - 1
        }
        play_music()
    }
    
    @IBAction func next_btn(_ sender: UIButton) {
        count += 1
        if count >= source.count {
            count = 0
        }
        play_music()
    }
    
    @IBAction func forward_btn(_ sender: UIButton) {
        guard let duration = player.currentItem?.duration else {
            return
        }
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + 5.0
        
        // Only forward 5 second if more than 5 second left
        if newTime < (CMTimeGetSeconds(duration)) {
            let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
            player.seek(to: time)
        }
    }
    
    @IBAction func backward_btn(_ sender: UIButton) {
        let currentTime = CMTimeGetSeconds(player.currentTime())
        var newTime = currentTime - 5.0
        
        // When less than 5 seconds, backward to begining
        if newTime < 0 {
            newTime = 0
        }
        let time: CMTime = CMTimeMake(value: Int64(newTime * 1000), timescale: 1000)
        player.seek(to: time)
    }
    
    @IBAction func volumne(_ sender: UISlider) {
        player.volume = sender.value
        if player.volume == sender.maximumValue{
            VolumeLable.text = "🔊"
        }
        else if player.volume == sender.minimumValue {
            VolumeLable.text = "🔇"
        }
        else if player.volume >= sender.maximumValue/2 {
            VolumeLable.text = "🔉"
        }
        else {
            VolumeLable.text = "🔈"
        }
    }
    
    @IBAction func progress(_ sender: UISlider) {
        let seconds = Int64(progressSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
    
    @objc func playerItemDidReachEnd(notification: Notification){
        if let playerItem = notification.object as? AVPlayerItem{
            if Loop_Style == LOOP.MULTI {
                self.next_btn(UIButton.init())
            }
            else if Loop_Style == LOOP.SINGLE{
                playerItem.seek(to: CMTime.zero, completionHandler: nil)
            }
            else {
                // LOOP.RANDOM
                count = Int.random(in: 0...source.count)
                play_music()
            }
        }
    }
    
    @IBAction func loop_btn(_ sender: UIButton) {
        if Loop_Style == LOOP.SINGLE {
            Loop_Style = LOOP.RANDOM
            Loop.setTitle("🔀", for: .normal)
        }
        else if Loop_Style == LOOP.RANDOM{
            Loop_Style = LOOP.MULTI
            Loop.setTitle("🔄", for: .normal)
        }
        else if Loop_Style == LOOP.MULTI{
            Loop_Style = LOOP.SINGLE
            Loop.setTitle("🔂", for: .normal)
        }
    }
    
    
}

