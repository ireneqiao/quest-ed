//
//  MagnetPowerup.swift
//  QuestEd
//
//  Created by Irene Qiao on 11/12/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class MagnetPowerup: StoreItem, Powerup {
    init () {
        //TODO: modify constructor, get rid of row, col, img, and size params
        super.init(name: "Magnet Powerup", description: "Let the coins come to you!", price: 2000, row: 0, col: 0, imgNamed: "magnet", size: CGSize(width: 50, height: 50))
        print("invincibility powerup constructor")
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
