//
//  TransferBoundary.swift
//  QuestEd
//
//  Created by student on 11/10/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit


class TransferBoundary: SKNode {
    var toField: UInt32
    var affectedBitmask: UInt32
    
    init(toField field:UInt32, affects bitmask:UInt32, size size:CGFloat) {
        toField = field
        affectedBitmask = 0
        super.init()
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: size)
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.linearDamping = 0
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = BitMasks.transferBoundaryCategory
        self.physicsBody?.fieldBitMask = 0
        self.physicsBody?.contactTestBitMask = BitMasks.magnetizableCategory
        affectedBitmask = bitmask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
