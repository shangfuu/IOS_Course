//
//  GameViewController.swift
//  spritekit_cat
//
//  Created by mac07 on 2020/4/15.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            
            let scene = GameScene(size: view.bounds.size)
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)
        }
    }

    
}
