//
//  ReflectPowerup.swift
//  QuestEd
//
//  Created by Irene Qiao on 12/4/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class ReflectPowerup: StoreItem, Powerup {
    init () {
        super.init(name: "Reflect Powerup", description: "Fish will bounce off of you without damaging your health!", price: 150, row: 0, col: 0, imgNamed: "reflector", size: CGSize(width: 50, height: 50))
    }
    
    func deploy(to scene: GameScene) {
        if let player = scene.player {
            
            player.removeChildren(in: Reflect.currentReflectors)
            Reflect.currentReflectors = []
            
            let reflector = Reflector(size: CGSize(width: Reflect.size, height: Reflect.size))
            
            player.addChild(reflector)
            reflector.zPosition = player.zPosition + 1
            Reflect.currentReflectors.append(reflector)
            
            scene.run(SKAction.sequence([
                SKAction.wait(forDuration: TimeInterval(Reflect.duration)),
                SKAction.run{reflector.removeFromParent()},
                ]))
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
