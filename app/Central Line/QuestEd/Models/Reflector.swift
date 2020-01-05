//
//  Reflector.swift
//  QuestEd
//
//  Created by student on 11/19/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Reflector: SKSpriteNode {
    
    init(size: CGSize) {
        let texture = SKTexture(imageNamed: "reflector")
        super.init(texture: texture, color: UIColor(white: 1, alpha: 0.3), size: size)
        self.colorBlendFactor = 0.5
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.pinned = true
        self.physicsBody?.mass = 0.000001
        self.physicsBody?.categoryBitMask = BitMasks.reflectorCategory
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.fieldBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMasks.reflectableCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
