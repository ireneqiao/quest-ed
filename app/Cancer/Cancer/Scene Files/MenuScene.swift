//
//  MenuScene.swift
//  Cancer
//
//  Created by Paulina Asturias on 10/1/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
import UIKit
import GameplayKit

class MenuScene: SKScene {

    override func didMove(to view: SKView){
        addBackground()
        addLabels() 
    }
    
    func addBackground(){
      let background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
    }
    
    func addLabels(){
        let playLabel = SKLabelNode(text: "Play")
        playLabel.fontName = "Helvetica-Bold"
        playLabel.fontSize = 50.0
        playLabel.fontColor = UIColor.yellow
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(playLabel)
        animate(label: playLabel)
        
        let highscore = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "Highscore"))")
        highscore.fontName = "Helvetica-Bold"
        highscore.fontSize = 40.0
        highscore.fontColor = UIColor.white
        highscore.position = CGPoint(x: frame.midX, y: frame.midY - highscore.frame.size.height*4)
        addChild(highscore)
        
        let recentscore = SKLabelNode(text: "Recent score: " + "\(UserDefaults.standard.integer(forKey: "Recentscore"))")
        recentscore.fontName = "Helvetica-Bold"
        recentscore.fontSize = 40.0
        recentscore.fontColor = UIColor.white
        recentscore.position = CGPoint(x: frame.midX, y: highscore.position.y - recentscore.frame.size.height*2)
        addChild(recentscore)
    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
               label.run(SKAction.repeatForever(sequence))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //code to go to instructions
        /*
        if let view = self.view {
               let scene = InstructionsScene(size: view.bounds.size)
                   scene.scaleMode = .aspectFill
                   view.presentScene(scene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        */
        
        
        //code to start game
        
        if let scene = GKScene(fileNamed: "GameScene") {
          if let sceneNode = scene.rootNode as! GameScene? {
            sceneNode.entities = scene.entities
            sceneNode.graphs = scene.graphs
            sceneNode.scaleMode = .aspectFill
            
            if let view = self.view {
                view.presentScene(sceneNode)
                
                view.ignoresSiblingOrder = true
                view.showsFPS = true
                view.showsNodeCount = true
            }
        }
        //view!.presentScene(gameScene)
    }
 
    }
    
}
