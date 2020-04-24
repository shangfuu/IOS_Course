//
//  GameViewController.swift
//  class05
//
//  Created by mac07 on 2020/4/1.
//  Copyright © 2020 mac07. All rights reserved.
//

import SpriteKit;

class GameViewController:UIViewController {
    override func viewDidLoad() {
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }
}
