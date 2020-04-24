//
//  GameOverScene.swift
//  class5-02
//
//  Created by shungfu on 2020/4/23.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    override func didMove(to view: SKView) {
        createScene()
    }
    
    func createScene(){
        
        let bgd = SKSpriteNode(imageNamed: "hellobgd.jpg")
        bgd.size.width = self.size.width
        bgd.size.height = self.size.height
        bgd.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bgd.zPosition = -1
        
        let youLossLabel = SKLabelNode(text: "You Loss!")
        youLossLabel.name = "label"
        youLossLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 200)
        youLossLabel.fontName = "Avenir-Oblique"
        youLossLabel.fontSize = 80
        
        self.addChild(bgd)
        self.addChild(youLossLabel)
        
        // Alert
        let alertController = UIAlertController(title: "You Loss!", message: "Score: \(MainScene.score)", preferredStyle: .alert)
        let alert = UIAlertAction(title: "Try Again", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            let scene = MainScene(size: self.size)
            self.view?.presentScene(scene, transition: SKTransition.doorsCloseVertical(withDuration: 1))    
        })
        
        alertController.addAction(alert)
        view?.window?.rootViewController?.present(alertController, animated: true)
    }
    
}
