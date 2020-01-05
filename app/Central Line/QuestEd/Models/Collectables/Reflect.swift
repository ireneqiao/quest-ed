//
//  Reflect.swift
//  QuestEd
//
//  Created by student on 11/19/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Reflect: Collectable, Powerup {
    
    static var currentReflectors: [SKNode] = []
    static var size: CGFloat = 150
    static var duration: CGFloat = 15
    
    init() {
        super.init(imgNamed: "reflect", size: CGSize(width: 70, height: 70))
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory
    }
    
    override func getCollected(by player: Player) {
        if let scene = player.scene as? GameScene{
            let magnetSound = SKAction.playSoundFileNamed("reflect.aac", waitForCompletion: true)
            scene.run(magnetSound)
            self.deploy(to: scene)
        }
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
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
