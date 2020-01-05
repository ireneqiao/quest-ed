//
//  WhiteFish.swift
//  Intent
//
//  Created by student on 11/11/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import Foundation
import SpriteKit

class WhiteFish: FishNode {
    
    init(pu: Int) {
            var thisname = "white"
            if (pu <= 2){
                thisname += "pu"
            }
            let texture = SKTexture(imageNamed: thisname)
            super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 125, height: 125))
            name = thisname
            scorechange = 2
            swiftness = Int.random(in: 400...500)
       }
    
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
}

