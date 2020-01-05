//
//  GameScene.swift
//  Cancer
//
//  Created by Paulina Asturias on 9/29/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var currscore = 0;
    
   
    
    private var lastUpdateTime : TimeInterval = 0
    let sick = SKTexture(imageNamed: "sickFish")
    let platelet = SKTexture(imageNamed: "Platelets")
    let white = SKTexture(imageNamed: "WhiteBlood")
    let score = SKLabelNode(text: "Score: 0")
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let locus = touch.location(in: self)
            let touchedNode = self.atPoint(locus)
            let name = touchedNode.name
            if name != "background" {
                touchedNode.removeFromParent()
            }
            if name == "red" {
                currscore += 5
            }
            if name == "platelet"{
                currscore += 10
            }
            if name == "sick" {
            }
            if name == "white" {
                currscore += 7
            }
        }
    }
    
    func addLabels(){
        score.fontName = "Helvetica-Bold"
        score.fontSize = 40.0
        score.fontColor = UIColor.white
        score.position = CGPoint(x: 0, y: 0)
        score.zPosition = CGFloat(-5.0)
        addChild(score)
    }
    
    func addFish() {
        let number = Int.random(in: 0 ..< 20)
        let fish = SKSpriteNode(imageNamed: "RedBlood")
        fish.name = "red"
        fish.scale(to: CGSize(width: 100, height: 100))
        if number > 17 {
            fish.texture = sick
            fish.name = "sick"
        }
        else if number > 13 {
            fish.texture = platelet
            fish.name = "platelet"
            fish.scale(to: CGSize(width: 70, height: 70))
        }
        else if number > 9 {
            fish.texture = white
            fish.name = "white"
            fish.scale(to: CGSize(width: 125, height: 125))
        }
        let startingY = CGFloat(Float.random(in: Float(-size.height/2 + fish.size.height/2)...Float(size.height/2 - fish.size.height/2)))
        let destinationY = CGFloat(Float.random(in: Float(-size.height/2 + fish.size.height/2)...Float(size.height/2 - fish.size.height/2)))
        var startingX = size.width/2 + fish.size.width/2
        var endX = -size.width/2 - fish.size.width/2
        if (Int.random(in: 0 ... 1) == 0) {
            startingX = -size.width/2 - fish.size.width/2
            endX = size.width/2 + fish.size.width/2
            fish.xScale = fish.xScale * -1
        }
        fish.position = CGPoint(x: startingX, y: startingY)
        addChild(fish)
        var actualDuration = Float.random(in: 2.0...4.0)
        if fish.name == "sick"{
            actualDuration = Float.random(in: 4.0...6.0)
        }
        else if fish.name == "white"{
            actualDuration = Float.random(in: 3.0...4.0)
        }
        else if fish.name == "platelet"{
            actualDuration = Float.random(in: 1.0...2.0)
        }
        let actionMove = SKAction.move(to: CGPoint(x: endX, y: destinationY), duration: TimeInterval(actualDuration))
        let actionMoveDone = SKAction.removeFromParent()
        fish.run(SKAction.sequence([actionMove, actionMoveDone]))}
    
    override func didMove(to view: SKView) {
        addLabels()
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addFish),
                SKAction.wait(forDuration: Double.random(in: 0.0 ... 1.0)),
                SKAction.run(addFish),
                SKAction.wait(forDuration: Double.random(in: 0.0 ... 1.0)),
                SKAction.run(addFish),
                SKAction.wait(forDuration: Double.random(in: 1.0 ... 3.0))
                ])
        ))}
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        for node in self.children {
            if (node.name == "sick") {
                for node2 in self.children {
                    if let victim = node2 as? SKSpriteNode {
                        if victim.name != "background" && victim.name != "sick" && node.intersects(victim) {
                            victim.name = "sick"
                            victim.texture = sick
                        }
                    }
                }
            }
        }
       score.text = "Score: \(currscore)"
        self.lastUpdateTime = currentTime
    }
}
