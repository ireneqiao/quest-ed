//
//  Sickish.swift
//  Intent
//
//  Created by student on 11/11/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import Foundation
import SpriteKit

class SickFish: FishNode {
    
    init() {
            let thisname = "sick"
            let texture = SKTexture(imageNamed: thisname)
            super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 100, height: 100))
            name = thisname
            healthchange = -1
            swiftness = Int.random(in: 300...500)
       }
    
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
}

