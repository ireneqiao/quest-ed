//
//  Platelet.swift
//  Intent
//
//  Created by student on 11/11/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import Foundation
import SpriteKit

class Platelet: FishNode {
    
    init(pu: Int) {
            var thisname = "platelet"
            if (pu <= 2){
                thisname += "pu"
            }
            let texture = SKTexture(imageNamed: thisname)
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 70, height: 70))
            name = thisname
            scorechange = 20
            swiftness = Int.random(in: 800...900)
       }
    
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
}


