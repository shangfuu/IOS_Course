//
//  ViewController.swift
//  class04-1
//
//  Created by mac07 on 2020/3/25.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var names = ["1","2","3","4","5"]
    var img = [UIImage(named: "fb_icon"),UIImage(named: "firefox_icon"),UIImage(named: "google_icon"),UIImage(named: "twitter_icon"),UIImage(named: "youtube_icon")]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        cell.imageView?.image = img[indexPath.row]
        return cell
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

