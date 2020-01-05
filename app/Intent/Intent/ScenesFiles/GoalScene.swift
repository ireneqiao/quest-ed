//
//  GoalScene.swift
//  Intent
//
//  Created by Paulina Asturias on 10/23/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
import GameplayKit


class GoalScene: SKScene {
    var background: SKSpriteNode!
    var goal: SKSpriteNode!
    var play:SKLabelNode!
    var instructions: SKLabelNode!
    var counter: SKLabelNode!
    var fish = Int()
    
    var goalLabel = SKLabelNode()
    var easy:SKLabelNode!
    var med:SKLabelNode!
    var hard:SKLabelNode!
    var expert:SKLabelNode!
    var diff: String!
    var unlockedDiff: String!
    //var level = 1 //3
    var level = Int()
    
    override func didMove(to view: SKView){
        if level == 2{
            background = SKSpriteNode(imageNamed: "Level2_CS")
            background.size = CGSize(width: frame.size.width*2, height: frame.size.height*2)
        }
        else if level == 3 {
            background = SKSpriteNode(imageNamed: "Level3")
            background.size = CGSize(width: frame.size.width, height: frame.size.height)
        }
        else{
            level = 1
            background = SKSpriteNode(imageNamed: "Background")
            background.size = CGSize(width: frame.size.width, height: frame.size.height)
        }
        background.position = CGPoint(x: frame.midX, y: frame.midY )
        addChild(background)
        
        goalLayout()
        choose_difficulty()
        playLabel()
        goalSetUp()
    }
    
    //set goal function
    func goalLayout(){
        goal = SKSpriteNode(imageNamed: "goal")
        goal.size = CGSize(width: frame.size.width, height: frame.size.height)
        goal.position = CGPoint(x: frame.midX, y: frame.midY )
        addChild(goal)
    }
    
    func playLabel(){
        instructions = SKLabelNode(text: "Instructions")
        instructions.fontName = "Helvetica-Bold"
        instructions.fontSize = 40.0
        instructions.fontColor = UIColor(red: 255/255, green: 204/255, blue: 92/255, alpha: 1.0)
        instructions.name = "instructions"
        instructions.position = CGPoint(x:frame.midX/3, y:self.size.height/1.1)
        addChild(instructions)
        
    }
    func choose_difficulty() {
        easy = SKLabelNode(text: "Easy")
        easy.fontName = "Helvetica-Bold"
        easy.fontSize = 40.0
        easy.fontColor = UIColor.white
        easy.name = "easy"
        easy.position = CGPoint(x: frame.midX-300, y: frame.midY-200)
        addChild(easy)
        
        med = SKLabelNode(text: "Medium")
        med.fontName = "Helvetica-Bold"
        med.fontSize = 40.0
        med.fontColor = UIColor.white
        med.name = "med"
        med.position = CGPoint(x: frame.midX-100, y: frame.midY-200)
        
        hard = SKLabelNode(text: "Hard")
        hard.fontName = "Helvetica-Bold"
        hard.fontSize = 40.0
        hard.fontColor = UIColor.white
        hard.name = "hard"
        hard.position = CGPoint(x: frame.midX+100, y: frame.midY-200)
        
        expert = SKLabelNode(text: "Expert")
        expert.fontName = "Helvetica-Bold"
        expert.fontSize = 40.0
        expert.fontColor = UIColor.white
        expert.name = "expert"
        expert.position = CGPoint(x: frame.midX+300, y: frame.midY-200)
        
        if UserDefaults.standard.bool(forKey: "medium" + String(level)) {
           addChild(med)
        }
        if UserDefaults.standard.bool(forKey: "hard" + String(level))  {
            addChild(hard)
        }
        if UserDefaults.standard.bool(forKey: "expert" + String(level))  {
           addChild(expert)
        }
    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
               label.run(SKAction.repeatForever(sequence))
    }
    //connect the timer to the timer variable in the Game Scene
    // connect the goal to the end of game levels
    
    func goalSetUp(){
        counter = SKLabelNode(text: "60") //update to change depending on level
        counter.fontName = "Helvetica-Bold"
        counter.fontSize = 70.0
        counter.fontColor = UIColor.black
        counter.position = CGPoint(x: frame.midX+225, y: frame.midY+50)
        addChild(counter)
        
        fish = 1     //75 fix if you'd like to change the goal 
        goalLabel.fontSize = 70.0
        goalLabel.fontName = "Helvetica-Bold"
        goalLabel.fontColor = UIColor.black
        goalLabel.position = CGPoint(x: frame.midX-100, y: frame.midY+50)
        goalLabel.text = "\(fish)"
        addChild(goalLabel)
        
    }
    
   func playgame() -> GameScene {
        if let scene = GKScene(fileNamed: "GameScene") {
            if let sceneNode = scene.rootNode as! GameScene? {
                sceneNode.entities = scene.entities
                sceneNode.graphs = scene.graphs
                sceneNode.level = level //tells the game scene what level to display
                sceneNode.difficulty = diff
                sceneNode.goalNum = fish
                sceneNode.scaleMode = .aspectFill
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
                return sceneNode
            }
            return GameScene()
        }
        return GameScene()
    }
    
    func playoceangame() -> GameScene {
        if let scene = GKScene(fileNamed: "OceanScene") {
            if let sceneNode = scene.rootNode as! OceanScene? {
                sceneNode.entities = scene.entities
                sceneNode.level = level
                sceneNode.goalNum = fish
                sceneNode.difficulty = diff
                sceneNode.graphs = scene.graphs
                sceneNode.scaleMode = .aspectFill
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
               return sceneNode
            }
            return GameScene()
        }
        return GameScene()
    }
    
    func playdeepgame() -> GameScene {
        if let scene = GKScene(fileNamed: "DeepScene") {
            if let sceneNode = scene.rootNode as! DeepScene? {
                sceneNode.entities = scene.entities
                sceneNode.level = level
                sceneNode.goalNum = fish
                sceneNode.difficulty = diff
                sceneNode.graphs = scene.graphs
                sceneNode.scaleMode = .aspectFill
                if let view = self.view {
                    view.presentScene(sceneNode)
                    view.ignoresSiblingOrder = true
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            return sceneNode
            }
            return GameScene()
        }
        return GameScene()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let tap = touch.location(in: self)
            enumerateChildNodes(withName: "//*", using: { (node, stop) in
                if node.contains(tap){
                     if node.name == "easy" {
                        self.diff = "easy"
                        if self.level == 2 {
                            self.playoceangame()
                        }
                        else if self.level == 3 {
                            self.playdeepgame()
                        }
                        else{
                            self.playgame()
                        }
                       }
                    if node.name == "med" {
                        self.diff = "medium"
                       if self.level == 2 {
                            self.playoceangame()
                        }
                        else if self.level == 3 {
                            self.playdeepgame()
                        }
                        else{
                            self.playgame()
                        }
                    }
                    if node.name == "hard" {
                        self.diff = "hard"
                       if self.level == 2 {
                            self.playoceangame()
                        }
                        else if self.level == 3 {
                            self.playdeepgame()
                        }
                        else{
                            self.playgame()
                        }
                    }
                    if node.name == "expert" {
                        self.diff = "expert"
                        if self.level == 2 {
                            self.playoceangame()
                        }
                        else if self.level == 3 {
                            self.playdeepgame()
                        }
                        else{
                            self.playgame()
                        }
                    }
                    
                    if node.name == "instructions" {
                        if let view = self.view {
                           let scene = InstructionsScene(size: view.bounds.size)
                               scene.scaleMode = .aspectFill
                               view.presentScene(scene)
                        
                        view.ignoresSiblingOrder = false
                        view.showsFPS = false
                        view.showsNodeCount = false
                        }
                    }
                    }
                 }
            )}
    }
}
