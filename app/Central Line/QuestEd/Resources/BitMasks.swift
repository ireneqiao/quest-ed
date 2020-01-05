//
//  BitMasks.swift
//  QuestEd
//
//  Created by student on 9/28/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation

struct BitMasks {
    static let playerCategory: UInt32 = 0x1 << 0
    static let invinciblePlayerCategory: UInt32 = 0x1 << 1
    static let obstacleCategory: UInt32 = 0x1 << 2
    static let collectableCategory: UInt32 = 0x1 << 3
    
    static let reflectorCategory: UInt32 = 0x1 << 4
    static let reflectedCategory: UInt32 = 0x1 << 5
    static let reflectableCategory: UInt32 = 0x1 << 6
    
    
    static let borderCategory: UInt32 = 0x1 << 29
    static let magnetizableCategory: UInt32 = 0x1 << 30
    static let transferBoundaryCategory: UInt32 = 0x1 << 31
}

struct FieldBitMasks {
    static let scrollCategory: UInt32 = 0x1 << 0
    static let magnetCategory: UInt32 = 0x1 << 1
}
