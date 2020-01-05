//
//  Wall.swift
//  QuestEd
//
//  Created by student on 9/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit


class Wall: Obstacle {
    
    init(size: CGSize, damageDealt: Double) {
        super.init(imgNamed: "wall", size: size, damageDealt: damageDealt)
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
