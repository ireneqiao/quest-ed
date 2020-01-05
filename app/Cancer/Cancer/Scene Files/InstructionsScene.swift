//
//  InstructionsScene.swift
//  Cancer
//
//  Created by Paulina Asturias on 10/2/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class InstructionsScene: SKScene {
    override func didMove(to view: SKView){
        addBackground()
        addfish()
    }
    
    func addBackground(){
      let background = SKSpriteNode(imageNamed: "Background")
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(background)
    }
    
    func addfish(){
        let red = SKSpriteNode(imageNamed: "RedBlood")
        red.size = CGSize(width: 250, height: 250)
        red.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(red)
        
        let white = SKSpriteNode(imageNamed: "WhiteBlood")
        white.size = CGSize(width: 250, height: 250)
        white.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(white)

        
        let sick = SKSpriteNode(imageNamed: "sickFish")
        sick.size = CGSize(width: 250, height: 250)
        sick.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(sick)
        
        let plat = SKSpriteNode(imageNamed: "Platelets")
        plat.size = CGSize(width: 250, height: 250)
        plat.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(plat)
        
    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
               label.run(SKAction.repeatForever(sequence))
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
