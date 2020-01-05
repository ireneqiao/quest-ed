//
//  Obstacle.swift
//  QuestEd
//
//  Created by student on 9/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Obstacle: SKSpriteNode {
    var damage: Double = 0.0

    
    init(imgNamed: String, size: CGSize, damageDealt: Double){
        let texture = SKTexture(imageNamed: imgNamed)
        super.init(texture: texture, color: UIColor(white: 1, alpha: 0), size: texture.size())
        self.name = "NOT PLAYER"
        self.size = size
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = BitMasks.obstacleCategory
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMasks.playerCategory
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory
        self.damage = damageDealt
    }
    
    

    
    func damagePlayer(_ p: Player){
        var finalDamage = damage
        if (Tough.toughCount > 0) {
            finalDamage *= Tough.defenseMod
        }
        p.decreaseHealth(num: finalDamage)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
