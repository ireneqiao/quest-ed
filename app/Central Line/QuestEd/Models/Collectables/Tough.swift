//
//  Tough.swift
//  QuestEd
//
//  Created by student on 11/19/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Tough: Collectable, Powerup {
    
    static var defenseMod: Double = 0.5
    static var toughCount: Int = 0
    static var duration: CGFloat = 15
    
    init() {
        super.init(imgNamed: "tough", size: CGSize(width: 70, height: 70))
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory
    }
    
    override func getCollected(by player: Player) {
        if let scene = player.scene as? GameScene{
            let toughSound = SKAction.playSoundFileNamed("tough.aac", waitForCompletion: true)
            scene.run(toughSound)
            self.deploy(to: scene)
        }
    }
    
    func deploy(to scene: GameScene) {
        
        if let player = scene.player {
            
            player.enumerateChildNodes(withName: "TOUGH-PARTICLE") { (node:SKNode, nil) in
                node.removeFromParent()
            }
            
            let toughParticle = SKEmitterNode(fileNamed: "ToughParticle.sks")
            toughParticle?.name = "TOUGH-PARTICLE"
            if let toughParticle = toughParticle {
                player.addChild(toughParticle)
            }
            
            Tough.toughCount += 1
            
            scene.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(Tough.duration)),
                SKAction.run{player.enumerateChildNodes(withName: "TOUGH-PARTICLE") { (node:SKNode, nil) in
                        node.removeFromParent()
                    }; Tough.toughCount -= 1},
            ]))
            
        }
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
