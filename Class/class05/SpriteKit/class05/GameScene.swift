//
//  GameScene.swift
//  class05
//
//  Created by mac07 on 2020/4/1.
//  Copyright © 2020 mac07. All rights reserved.
//


import SpriteKit;

class GameScene: SKScene {
    let label = SKLabelNode(text: "Hello World!")
    var txtChange:Bool = false
    
    override func didMove(to view: SKView) {
        label.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        label.fontSize = 45
        label.fontColor = SKColor.red
        label.fontName = "Avenir"
        label.speed = 5
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap))
        view.addGestureRecognizer(tapRecognizer)
        
        let dTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        dTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(dTapRecognizer)
            
        addChild(label) // add the label as a child node to the scene's node tree
    }

    @objc func tap(recognizer: UIGestureRecognizer){
        let viewLocation = recognizer.location(in: view)
        let sceneLocation = convertPoint(fromView: viewLocation)
        let moveToAction = SKAction.move(to: sceneLocation, duration: 3)
        label.run(moveToAction)
    }
    
    
    @objc func doubleTap(recognizer: UIGestureRecognizer) {
        if txtChange == false{
            label.text = "I LV SpriteKit"
            txtChange = true
        }
        else {
            label.text = "Hello World!"
            txtChange = false
        }
    }
}
