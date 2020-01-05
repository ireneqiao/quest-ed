//
//  IntroScene.swift
//  QuestEd
//
//  Created by student on 10/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class IntroScene: SKScene {
    

    var nextScene:SKScene?
    var previousScene: SKScene?
    
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            if node == self.childNode(withName: "back") {
                let transition = SKTransition.crossFade(withDuration: 1)
                if let previous = previousScene {
                    previous.scaleMode = .aspectFit
                    self.view?.presentScene(previous, transition: transition)
                }
            }
            else {
                let transition = SKTransition.crossFade(withDuration: 1)
                if let gameScene = nextScene {
                    gameScene.scaleMode = .aspectFit
                    self.view?.presentScene(gameScene, transition: transition)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
     
    }
}
