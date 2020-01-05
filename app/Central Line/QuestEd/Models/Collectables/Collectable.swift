//
//  Collectable.swift
//  QuestEd
//
//  Created by student on 9/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Collectable: SKSpriteNode {
    
    init(imgNamed: String, size: CGSize){
        let texture = SKTexture(imageNamed: imgNamed)
        super.init(texture: texture, color: UIColor(white: 1, alpha: 0), size: size)
        self.name = "NOT PLAYER"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width / 2)
        self.physicsBody?.restitution = 0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = BitMasks.collectableCategory
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory | FieldBitMasks.magnetCategory    }
    
    
    func getCollected(by player: Player) {
        preconditionFailure("This method must be overridden")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
