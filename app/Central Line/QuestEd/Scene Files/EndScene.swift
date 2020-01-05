//
//  EndScene.swift
//  QuestEd
//
//  Created by student on 10/16/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class EndScene: SKScene {
    
    var playButton:SKLabelNode?
    var gameScene:SKScene!
    var finalCoinsCollected: SKLabelNode?
    var finalDistanceTraveled: SKLabelNode?
    var backgroundMusic: SKAudioNode!
    
    var coins: Int?
    var distance: Double?
    
    
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "playButton") as? SKLabelNode
        finalCoinsCollected = self.childNode(withName: "finalCoins") as? SKLabelNode
        finalDistanceTraveled = self.childNode(withName: "finalDistance") as? SKLabelNode
        
        if let coins = coins {
            self.finalCoinsCollected?.text = "Coins Collected: \(coins)"
        }
        
        if let distance = distance {
            self.finalDistanceTraveled?.text = String(format: "Distance Traveled: %.0f", distance)
        }
        
        if let musicURL = Bundle.main.url(forResource: "MenuHighscoreMusic", withExtension: "mp3") {
            backgroundMusic = SKAudioNode(url: musicURL)
            addChild(backgroundMusic)
        }
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            
            if node == playButton {
                let transition = SKTransition.fade(withDuration: 1)
                gameScene = SKScene(fileNamed: "GameScene")
                gameScene.scaleMode = .aspectFit
                self.view?.presentScene(gameScene, transition: transition)
                
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
     
    }
}

