//
//  CurrentNode.swift
//  Intent
//
//  Created by student on 11/11/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import Foundation
import SpriteKit

class CurrentNode: SKSpriteNode {
    
    var orientation = 1
    
    init(scene: SKScene) {
            let texture = SKTexture(imageNamed: "current")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: scene.size.width, height: CGFloat.random(in: 100...200)))
            name = "current"
            zPosition = -10
        if (Int.random(in: 1...2) == 2) {
            orientation = -1
            xScale = xScale * -1
        }
       }
    
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
    
}
