//
//  StoreItem.swift
//  QuestEd
//
//  Created by Irene Qiao on 10/18/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class StoreItem: SKSpriteNode {
    var displayName: String?
    var displayDescription: String?
    var itemPrice: Int?
    var itemRow: Int?
    var itemColumn: Int?
    var image: String?
    
    init(name: String, description: String, price: Int, row: Int, col: Int, imgNamed: String, size: CGSize){
        displayName = name
        displayDescription = description
        itemPrice = price
        itemRow = row
        itemColumn = col
        image = imgNamed
        let texture = SKTexture(imageNamed: imgNamed)
        super.init(texture: texture, color: UIColor(white: 1, alpha: 0), size: texture.size())
        print("store item constructor")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
