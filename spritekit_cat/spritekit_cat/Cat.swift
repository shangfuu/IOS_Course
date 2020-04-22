//
//  Cat.swift
//  spritekit_cat
//
//  Created by mac07 on 2020/4/15.
//  Copyright © 2020 mac07. All rights reserved.
//

import SpriteKit

class Cat: SKSpriteNode {
    // cat movement atlas database
    let textureAtlas = SKTextureAtlas(named: "db.atlas")
    var textureFrames = [SKTexture]()
    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        // 執行父類別的構造方法
        let texture = SKTexture(imageNamed: "db_02.png") // default pic 
        super.init(texture:texture, color:SKColor.clear, size:texture.size())
        
        // grab atlas from atlas set into array
        var tempName:String
        for i in 1...textureAtlas.textureNames.count {
            tempName = String(format: "db_%.2d", i)
            let dbTexture = textureAtlas.textureNamed(tempName)
            textureFrames.append(dbTexture)
        }
        anchorPoint = CGPoint(x:0.5, y:0.2)
        showAtlas()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implement")
    }
    
    func showAtlas(){
        self.run(SKAction.repeatForever(SKAction.animate(with: textureFrames, timePerFrame: 0.2)))
    }
    
}
