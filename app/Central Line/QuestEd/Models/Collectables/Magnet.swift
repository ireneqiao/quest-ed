//
//  Magnet.swift
//  QuestEd
//
//  Created by student on 11/10/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Magnet: Collectable, Powerup {
    
    static var currentMagnets: [SKNode] = []
    static var range: CGFloat = 200
    static var duration: CGFloat = 10
    
    init() {
        super.init(imgNamed: "magnet", size: CGSize(width: 70, height: 70))
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory
    }
    
    override func getCollected(by player: Player) {
        if let scene = player.scene as? GameScene{
            let magnetSound = SKAction.playSoundFileNamed("magnet.aac", waitForCompletion: true)
            scene.run(magnetSound)
            self.deploy(to: scene)
        }
    }
    
    func deploy(to scene: GameScene) {
        
        if let player = scene.player {
            
            player.removeChildren(in: Magnet.currentMagnets)
            Magnet.currentMagnets = []
            
            let magnet = SKFieldNode.radialGravityField()
            magnet.categoryBitMask = FieldBitMasks.magnetCategory
            magnet.isExclusive = true
            magnet.strength = 500
            
            let boundary = TransferBoundary(toField: FieldBitMasks.magnetCategory, affects: BitMasks.collectableCategory, size: 150)
            
            let magnetParticle = SKEmitterNode(fileNamed: "MagnetParticle.sks")
            
            if let magnetParticle = magnetParticle {
                player.addChild(magnetParticle)
                player.addChild(magnet)
                player.addChild(boundary)
                
                Magnet.currentMagnets.append(contentsOf: [magnet, boundary, magnetParticle])

                scene.run(SKAction.sequence([
                    SKAction.wait(forDuration: TimeInterval(Magnet.duration)),
                    SKAction.run{boundary.removeFromParent()},
                    SKAction.wait(forDuration: TimeInterval(3)),
                    SKAction.run{magnet.removeFromParent(); magnetParticle.removeFromParent(); Magnet.currentMagnets = []},
                ]))
            }
            
            
           
            
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
