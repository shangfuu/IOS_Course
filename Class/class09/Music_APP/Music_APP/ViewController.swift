//
//  ViewController.swift
//  Music_APP
//
//  Created by shungfu on 2020/5/13.
//  Copyright © 2020 shungfu. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let player = AVPlayer()
    var musics = [URL]()
    var count = 0
    
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var songLength: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    
    func play_music(){
        let playerItem = AVPlayerItem(url: musics[count])
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func formatConversion(time: Float64) ->String {
        let songLength = Int(time)
        let minutes = Int(songLength / 60)
        let seconds = Int(songLength % 60)
        
        var time = ""
        
        if minutes < 10 {
            time = "0\(minutes):"
        }
        else {
            time = "\(minutes):"
        }
        if seconds < 10 {
            time += "0\(seconds)"
        }
        else {
            time += "\(seconds)"
        }
        return time
    }
    
    @objc func playerItemDidReachEnd(notification: Notification){
        if let playerItem = notification.object as? AVPlayerItem{
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        musics.append(Bundle.main.url(forResource: "NEW DOPE - prototype", withExtension: "mp3")!)
        musics.append(Bundle.main.url(forResource: "drum", withExtension: "mp3")!)
        
        
        let playerItem = AVPlayerItem(url: musics[count])
        player.replaceCurrentItem(with: playerItem)
        
        let duration = playerItem.asset.duration
        let seconds = CMTimeGetSeconds(duration)
        songLength.text = formatConversion(time: 0)
        progressSlider.minimumValue = 0
        progressSlider.maximumValue = Float(seconds)
        
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main, using: { (CMTime) in let currentTime = CMTimeGetSeconds(self.player.currentTime())
            self.progressSlider.value = Float(currentTime)
            self.songLength.text = self.formatConversion(time: currentTime)
        })
        player.play()
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    @IBAction func play(_ sender: UIButton) {
        player.play()
    }
    
    @IBAction func pause(_ sender: UIButton) {
        player.pause()
    }
    
    @IBAction func previous(_ sender: UIButton) {
        count -= 1
        if count < 0{
            count = musics.count - 1
        }
        play_music()
    }
    
    @IBAction func next(_ sender: UIButton) {
        count += 1
        if count >= musics.count {
            count = 0
        }
        play_music()
    }
    
    @IBAction func volume(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @IBAction func changeCurrentTime(_ sender: UISlider) {
        let seconds = Int64(progressSlider.value)
        let targetTime: CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
    
    
}

