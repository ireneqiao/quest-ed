//
//  MakeBackground.swift
//  QuestEd
//
//  Created by student on 10/21/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func makeBackground() {

        var backgroundTexture = SKTexture(imageNamed: "background.png")

        //move background right to left; replace
        var shiftBackground = SKAction.moveBy(x: -backgroundTexture.size().width, y: 0, duration: 30)
        var replaceBackground = SKAction.moveBy(x: backgroundTexture.size().width, y:0, duration: 0)
        var movingAndReplacingBackground = SKAction.repeatForever(SKAction.sequence([shiftBackground,replaceBackground]))

        for var i in 0...2 {
            //defining background; giving it height and moving width
            background=SKSpriteNode(texture:backgroundTexture)
            background?.zPosition = -1
            background?.position = CGPoint(x: backgroundTexture.size().width/2 + (backgroundTexture.size().width * CGFloat(i)), y: self.frame.midY)
            background?.size.height = self.frame.height
            background?.run(movingAndReplacingBackground)

            self.addChild(background!)
        }
    }

}

