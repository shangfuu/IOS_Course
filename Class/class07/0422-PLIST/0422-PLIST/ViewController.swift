//
//  ViewController.swift
//  0422-PLIST
//
//  Created by mac07 on 2020/4/22.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var path:String = ""
    @IBOutlet weak var chgLabell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        path = NSHomeDirectory() + "/Documents/Property List.plist"
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            if let color = plist["Color"] {
                chgLabell.text = "The color is \(color)"
            }
        }
    }

    @IBAction func chgtoRed(_ sender: UIButton) {
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            plist["Color"] = "Red"
            if let color = plist["Color"] {
                if plist.write(toFile: path, atomically: true) {
                    chgLabell.text = "The color is changed to \(color)"
                }
            }
        }
    }
    
    @IBAction func chfgtoGreen(_ sender: UIButton) {
        if let plist = NSMutableDictionary(contentsOfFile: path) {
            plist["Color"] = "Green"
            if let color = plist["Color"] {
                if plist.write(toFile: path, atomically: true) {
                    chgLabell.text = "The color is changed to \(color)"
                }
            }
        }
    }
    
    
}

