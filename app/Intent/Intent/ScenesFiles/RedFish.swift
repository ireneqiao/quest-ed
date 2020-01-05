//
//  RedFish.swift
//  Intent
//
//  Created by student on 11/11/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import Foundation
import SpriteKit

class RedFish: FishNode {
    
    init(pu: Int) {
            var thisname = "red"
            var thishealthchange = 0
            if (pu <= 2){
                thisname += "pu"
                thishealthchange = 1
            }
            let texture = SKTexture(imageNamed: thisname)
            super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 100, height: 100))
            name = thisname
            healthchange = thishealthchange
            scorechange = 1
            swiftness = Int.random(in: 550...650)
       }
    
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
}

