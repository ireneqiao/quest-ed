//
//  Shark.swift
//  Intent
//
//  Created by student on 11/13/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import Foundation
import SpriteKit

class Shark: FishNode {
    
    init() {
            let thisname = "shark"
            let texture = SKTexture(imageNamed: thisname)
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 400, height: 400))
            name = thisname
            scorechange = 20
            healthchange = -3
            swiftness = Int.random(in: 300...500)
       }
    
    func eat(fish: FishNode) {
        scorechange += fish.scorechange
        if (fish.healthchange < 0) {
            healthchange += fish.healthchange
        }
        fish.removeFromParent()
        
    }
    
    override func infect() {
    }
    
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
}

