//
//  MenuScene.swift
//  Intent
//
//  Created by Paulina Asturias on 10/2/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
import GameplayKit

class InstructionsScene: SKScene {
    let background = SKSpriteNode(imageNamed: "Background")
    var person: SKSpriteNode!
    var bubble1: SKSpriteNode!
    var bubble2: SKSpriteNode!
    var bubble3: SKSpriteNode!
    var skip: SKLabelNode!
    var prev: SKSpriteNode!
    var n: SKSpriteNode!
    var tapsCounterNum = Int()
    var prevNum = Int()
    
    override func didMove(to view: SKView){
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY )
        addChild(background)
        
        addLabels()
        addGraphics()
        next_instruction()
    }
    
    func addLabels(){
            skip = SKLabelNode(text: "Skip")
               skip.fontName = "Helvetica-Bold"
               skip.fontSize = 50.0
               skip.fontColor = UIColor(red: 255/255, green: 204/255, blue: 92/255, alpha: 1.0)
               skip.name = "skip"
        skip.horizontalAlignmentMode = .right
        skip.position = CGPoint(x:self.size.width-60, y:frame.midY*1.8)
               addChild(skip)
        
        let instructions = SKLabelNode(text: "How To Play")
        instructions.fontName = "Helvetica-Bold"
        instructions.fontSize = 50.0
        instructions.fontColor = UIColor.white
        instructions.position = CGPoint(x: frame.midX, y: frame.midY*1.8)
        addChild(instructions)
    }
    
    func addGraphics(){
        person = SKSpriteNode(imageNamed: "Person")
        person.size = CGSize(width:frame.size.width, height: frame.size.height)
        person.position = CGPoint(x: frame.midX-30, y: frame.midY-30)
        person.name = "person"
        addChild(person)
        
        addbubble1()
        bubbleperson()
        cautionbubble()
    }
    
    func addbubble1(){
        bubble1 = SKSpriteNode(imageNamed: "person1bubble")
        bubble1.size = CGSize(width:frame.size.width/2, height: frame.size.height/2)
        bubble1.position = CGPoint(x: frame.midX+40, y: frame.midY+180)
        bubble1.zPosition = 3
        addChild(bubble1)
    }
    
    func bubbleperson(){
        bubble2 = SKSpriteNode(imageNamed: "hurryBubble")
        bubble2.size = CGSize(width:frame.size.width/2, height: frame.size.height/2)
        bubble2.position = CGPoint(x: frame.midX+40, y: frame.midY+180)
        bubble2.zPosition = 2
        addChild(bubble2)
    }
    func cautionbubble(){
        bubble3 = SKSpriteNode(imageNamed: "caution")
        bubble3.size = CGSize(width:frame.size.width/2, height: frame.size.height/2)
        bubble3.position = CGPoint(x: frame.midX+40, y: frame.midY+180)
        bubble3.zPosition = 1
        addChild(bubble3)
    }
    
    func next_instruction(){
        n = SKSpriteNode(imageNamed: "next")
        n.size = CGSize(width: 100, height: 100)
        n.position = CGPoint(x: self.size.width-100, y:frame.midY)
        n.name = "next"
        addChild(n)
    }
    
    func prev_instruction(){
        prev = SKSpriteNode(imageNamed: "prev")
        prev.size = CGSize(width: 100, height: 100)
        prev.position = CGPoint(x: frame.midX/4, y:frame.midY)
        prev.name = "prev"
        addChild(prev)
    }

    func dissapear(label: SKNode){
        label.removeFromParent()
    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
               label.run(SKAction.repeatForever(sequence))
    }
    
    func play_goalscene(){
        if let view = self.view {
           let scene = GoalScene(size: view.bounds.size)
               scene.scaleMode = .aspectFill
               view.presentScene(scene)
        
        view.ignoresSiblingOrder = false
        view.showsFPS = false
        view.showsNodeCount = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let tap = touch.location(in: self)
        enumerateChildNodes(withName: "//*", using: { (node, stop) in
                if node.contains(tap){
                        if node.name == "skip" {
                                self.play_goalscene()
                        }
                        if node.name == "prev" {
                            if self.bubble3.zPosition == 3 {
                                self.bubble1.zPosition = 2
                                self.bubble2.zPosition = 3
                                self.bubble3.zPosition = 1
                            }
                            else if self.bubble2.zPosition == 3 {
                                self.bubble1.zPosition = 3
                                self.bubble2.zPosition = 1
                                self.bubble3.zPosition = 2
                                self.dissapear(label: self.prev)
                            }
                        }
                        if node.name == "next" {
                            if self.bubble1.zPosition == 3 {
                                self.bubble1.zPosition = 1
                                self.bubble2.zPosition = 3
                                self.bubble3.zPosition = 2
                                self.prev_instruction()
                            }
                            else if self.bubble2.zPosition == 3 {
                                self.bubble1.zPosition = 1
                                self.bubble2.zPosition = 2
                                self.bubble3.zPosition = 3
                            }
                            else if self.bubble3.zPosition == 3 {
                                self.play_goalscene()
                            }
                        }
                    }
                }
            )
        }
    }
}
