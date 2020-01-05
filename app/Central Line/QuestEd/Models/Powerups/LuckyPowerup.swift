//
//  LuckyPowerup.swift
//  QuestEd
//
//  Created by Irene Qiao on 12/4/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class LuckyPowerup: StoreItem, Powerup {
    init () {
        super.init(name: "Lucky Powerup", description: "Wow there are so many coins now! You're in luck!", price: 2000, row: 0, col: 0, imgNamed: "clover", size: CGSize(width: 50, height: 50))
    }
    
    func deploy(to scene: GameScene) {
        if let spawnNode = scene.spawnNode {
            spawnNode.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.wait(forDuration: Lucky.interval, withRange: 0.2),
                SKAction.run {scene.spawnCoin()}
                ])))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
