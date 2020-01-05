//
//  InvincibilityPowerUp.swift
//  QuestEd
//
//  Created by Irene Qiao on 10/23/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class InvincibilityPowerup: StoreItem, Powerup {
    init () {
        super.init(name: "Invincibility Powerup", description: "You will not lose health for the first x distance!", price: 1500, row: 0, col: 0, imgNamed: "invincibility-powerup", size: CGSize(width: 50, height: 50))
        print("invincibility powerup constructor")
    }
    
    func deploy(to scene: GameScene) {
        scene.run(SKAction.sequence([
            SKAction.run(scene.player!.becomeInvincible),
            SKAction.wait(forDuration: TimeInterval(10)),
            SKAction.run(scene.player!.loseInvincible),
        ]))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
