//
//  FishNode.swift
//  Intent
//
//  Created by student on 11/11/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import Foundation
import SpriteKit

class FishNode: SKSpriteNode {
    
    var healthchange = 0
    var scorechange = 0
    var swiftness = 0
    var orientation = -1
    var currenteffect = false
    
    func infect() {
        if (name != "sick") {
            name = "sick"
            scorechange = 0
            healthchange = -1
        }
        texture = SKTexture(imageNamed: name!)
    }
}
