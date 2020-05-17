//
//  HelloScene.swift
//  class5-02
//
//  Created by mac07 on 2020/4/1.
//  Copyright © 2020 mac07. All rights reserved.
//

import UIKit
import SpriteKit

class HelloScene: SKScene {
    
    override func didMove(to view: SKView) {
        createScene()
        createHelloShip()
    }
    
    func createScene(){
        let bgd = SKSpriteNode(imageNamed: "hellobgd2.png")
        bgd.size.width = self.size.width
        bgd.size.height = self.size.height
        bgd.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        bgd.zPosition = -1
        
        let hellolabel = SKLabelNode(text: "Space Adventure")
        hellolabel.name = "label"
        hellolabel.position = CGPoint(x: self.frame.midX, y: self.frame.maxY - 200)
        hellolabel.fontName = "Avenir-Oblique"
        hellolabel.fontSize = 28
        
        self.addChild(bgd)
        self.addChild(hellolabel)
    }
    
    func createHelloShip(){
        let spaceShip1 = SKSpriteNode(imageNamed: "spaceship.png")
        spaceShip1.name = "sp1"
        spaceShip1.size = CGSize(width: 75, height: 75)
        spaceShip1.position = CGPoint(x: self.frame.minX + 100, y: self.frame.minY - 100)
        
        self.addChild(spaceShip1)
        
        let spaceShip2 = SKSpriteNode(imageNamed: "spaceship.png")
        spaceShip2.name = "sp2"
        spaceShip2.size = CGSize(width: 75, height: 75)
        spaceShip2.position = CGPoint(x: self.frame.maxX - 100, y: self.frame.minY - 100)
        
        self.addChild(spaceShip2)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // Hello Label Node
        let labelNode = self.childNode(withName: "label")

        let zoomin = SKAction.scale(to: 2.0, duration: 0.5)
        let pause = SKAction.wait(forDuration: 0.35)
        let zoomout = SKAction.scale(to: 0.8, duration: 0.35)
        let fadeaway = SKAction.fadeOut(withDuration: 0.35)
        let remove = SKAction.removeFromParent()
        
        // Space Ship
        let spaceShip1 = self.childNode(withName: "sp1")
        let spaceShip2 = self.childNode(withName: "sp2")
        
        let moveup_sp = SKAction.moveTo(y: self.frame.midY, duration: 1)
        let pauseEnd = SKAction.wait(forDuration: 1)
        let rotate = SKAction.rotate(toAngle: CGFloat(M_PI*2), duration: 1)
        let group = SKAction.group([moveup_sp,rotate])
        
        // 動畫播放序列
        // Hello Space ship
        let movesequence_sp = SKAction.sequence([group,pauseEnd,fadeaway,remove])
        // Label
        let movesequence = SKAction.sequence([zoomin,pause,zoomout,pauseEnd,fadeaway,remove])
        
        // 轉場
        spaceShip1?.run(movesequence_sp)
        spaceShip2?.run(movesequence_sp)
        
        labelNode?.run(movesequence, completion: {
            let mainScene = MainScene(size: self.size)
            let doors = SKTransition.fade(withDuration: 0.5)
            self.view?.presentScene(mainScene, transition: doors)
        })
        
        
    }
}
