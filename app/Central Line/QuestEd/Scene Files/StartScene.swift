//
//  StartScene.swift
//  QuestEd
//
//  Created by student on 10/16/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class StartScene: SKScene {
    
    var playButton:SKLabelNode?
    var gameStoreButton:SKLabelNode?
    var gameScene:SKScene?
    var backgroundMusic: SKAudioNode!
    
    
    
    
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "playButton") as? SKLabelNode
        gameStoreButton = self.childNode(withName: "gameStoreButton") as? SKLabelNode
        
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
                
                if let intro1 = SKScene(fileNamed: "IntroScene1") as? IntroScene {
                    if let intro2 = SKScene(fileNamed: "IntroScene2") as? IntroScene {
                        if let intro3 = SKScene(fileNamed: "IntroScene3") as? IntroScene {
                            if let gameScene = SKScene(fileNamed: "GameScene") {
                                intro3.nextScene = gameScene
                                intro3.previousScene = intro2
                            }
                            intro2.nextScene = intro3
                            intro2.previousScene = intro1
                        }
                        intro1.nextScene = intro2
                        intro1.previousScene = self
                    }
                    self.view?.presentScene(intro1, transition: transition)
                }
                
            }
            
            if node == gameStoreButton {
                let transition = SKTransition.fade(withDuration: 1)
                if let storeScene = SKScene(fileNamed: "StoreScene") {
                    storeScene.scaleMode = .aspectFit
                    self.view?.presentScene(storeScene, transition: transition)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
     
    }
}
