//
//  ColorfulPlayerItem.swift
//  QuestEd
//
//  Created by Irene Qiao on 11/12/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class ColorfulPlayerItem: StoreItem, Powerup {
    init () {
        //TODO: update constructor to remove params for img, row, col, size, etc.
        super.init(name: "Colorful Player", description: "Look stylish while you travel the aqueducts!", price: 70000, row: 0, col: 0, imgNamed: "player-colorful", size: CGSize(width: 50, height: 50))
    }
    
    func deploy(to scene: GameScene) {
        if let player = scene.player {
            player.skin = SKTexture(imageNamed: "player-colorful")
            player.texture = player.skin
            print("colorful item deploy() called")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
