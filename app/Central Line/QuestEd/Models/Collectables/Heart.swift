//
//  Heart.swift
//  QuestEd
//
//  Created by student on 11/13/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Heart: Collectable, Powerup {
    
    static var healAmount: Double = 10
    
    init() {
        super.init(imgNamed: "heart", size: CGSize(width: 70, height: 70))
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory
    }
    
    override func getCollected(by player: Player) {
        if let scene = player.scene as? GameScene{
            if let emitter = SKEmitterNode(fileNamed: "GetHeart.sks") {
                emitter.position = player.position
                scene.addChild(emitter)
                scene.run(SKAction.wait(forDuration: 3)){
                    emitter.removeFromParent()
                }
            }
            let heartSound = SKAction.playSoundFileNamed("heart.aac", waitForCompletion: true)
            scene.run(heartSound)
            self.deploy(to: scene)
        }
    }
    
    func deploy(to scene: GameScene) {
        
        if let player = scene.player {
            player.health = min(player.health + Heart.healAmount, player.maxHealth)
            if let healthBar = scene.healthBar {
                scene.healthBar?.run(SKAction.resize(toWidth: CGFloat(100 * (player.health/player.maxHealth)), duration: 0.3))
            }
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
