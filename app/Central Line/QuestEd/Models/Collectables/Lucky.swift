//
//  Lucky.swift
//  QuestEd
//
//  Created by student on 11/19/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Lucky: Collectable, Powerup {
    
    static var interval: TimeInterval = 4.0
    
    init() {
        super.init(imgNamed: "lucky", size: CGSize(width: 70, height: 70))
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory
    }
    
    override func getCollected(by player: Player) {
        
        if let scene = player.scene as? GameScene{
            
            if let emitter = SKEmitterNode(fileNamed: "GetLucky.sks") {
                emitter.position = player.position
                scene.addChild(emitter)
                scene.run(SKAction.wait(forDuration: 3)){
                    emitter.removeFromParent()
                }
                
            }
            
            let toughSound = SKAction.playSoundFileNamed("lucky.aac", waitForCompletion: true)
            scene.run(toughSound)
            self.deploy(to: scene)
        }
    }
    
    func deploy(to scene: GameScene) {
        if let spawnNode = scene.spawnNode {
            spawnNode.run(SKAction.repeatForever(SKAction.sequence([
                SKAction.wait(forDuration: Lucky.interval, withRange: 0.2),
                SKAction.run {scene.spawnCoin()}
            ])))
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
