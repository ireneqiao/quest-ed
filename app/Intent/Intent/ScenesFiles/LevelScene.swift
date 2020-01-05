//
//  LevelScene.swift
//  Intent
//
//  Created by Paulina Asturias on 11/15/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
import GameplayKit

class LevelScene: SKScene {
    var level1: SKSpriteNode!
    var level2: SKSpriteNode!
    var level3: SKSpriteNode!
    var easy: SKSpriteNode!
    var med: SKSpriteNode!
    var hard: SKSpriteNode!
    var expert: SKSpriteNode!
    var firework: SKSpriteNode!
    var count = Int()
    let background = SKSpriteNode(imageNamed: "level1_unlock")
    var playagain: SKLabelNode!
    var play1: SKLabelNode!
    var play2: SKLabelNode!
    var play3: SKLabelNode!
    
    var level = Int()
    
    var score = Int()
    var goal = Int()
    var difficulty: String!

    var game = GameScene()
    var stage = 1
    
    var countifUnlocked = false
    
    override func didMove(to view: SKView){
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
         background.position = CGPoint(x: frame.midX, y: frame.midY )
         addChild(background)
 
        labelPlayAgain()
        
        if score >= goal {
            if level == 2{
                secondLevel()
            }
            else if level == 3{
                thirdLevel()
            }
                if difficulty == "easy" {
                    easy_level()
                    med_level()
                    UserDefaults.standard.set(true,forKey:"medium" + String(stage))
                    countifUnlocked = true 
                }
                if difficulty == "medium" {
                    easy_level()
                    med_level()
                    hard_level()
                    UserDefaults.standard.set(true,forKey:"hard" + String(stage))
                }
                if difficulty == "hard" {
                    easy_level()
                    med_level()
                    hard_level()
                    expert_level()
                    UserDefaults.standard.set(true,forKey:"expert" + String(stage))
                }
                if difficulty == "expert" {
                    UserDefaults.standard.set(true,forKey:"easy" + String(stage+1))
                    level = level + 1
                    
                    
                    if level == 2 {
                        fireworks()
                        secondLevel()
                        easy_level()
                    }
                    else if level == 3{
                        fireworks()
                        thirdLevel()
                        easy_level()
                    }
                }
            }
        }
    
    func easy_level(){
        easy = SKSpriteNode(imageNamed: "difficulty_unlock")
        easy.size = CGSize(width: 30, height: 30)
        easy.position = CGPoint(x: frame.midX-50, y: frame.midY-100 )
        addChild(easy)
        
    }
    func med_level(){
        med = SKSpriteNode(imageNamed: "difficulty_unlock")
        med.size = CGSize(width: 30, height: 30)
        med.position = CGPoint(x: frame.midX-10, y: frame.midY-100 )
        addChild(med)
    }
    
    func unlockMed(){
        let l_med = SKLabelNode(text: "Medium level unlocked")
        l_med.fontName = "Helvetica-Bold"
        l_med.fontSize = 40.0
        l_med.fontColor = UIColor.white
        l_med.zPosition = 2
        l_med.position = CGPoint(x:frame.midX, y:frame.midY + 200)
        addChild(l_med)
        fireworks()
    }
    
    func hard_level(){
        hard = SKSpriteNode(imageNamed: "difficulty_unlock")
        hard.size = CGSize(width: 30, height: 30)
        hard.position = CGPoint(x: frame.midX+30, y: frame.midY-100)
        addChild(hard)
    }
    
    func unlockhard(){
        let l_hard = SKLabelNode(text: "Hard level unlocked")
        l_hard.fontName = "Helvetica-Bold"
        l_hard.fontSize = 40.0
        l_hard.fontColor = UIColor.white
        l_hard.zPosition = 2
        l_hard.position = CGPoint(x:frame.midX, y:frame.midY + 200)
        addChild(l_hard)
        fireworks()
    }
    
    func expert_level(){
        expert = SKSpriteNode(imageNamed: "difficulty_unlock")
        expert.size = CGSize(width: 30, height: 30)
        expert.position = CGPoint(x: frame.midX+70, y: frame.midY-100 )
        addChild(expert)
    }
     
    func unlockExpert(){
        let l_expert = SKLabelNode(text: "Expert level unlocked")
        l_expert.fontName = "Helvetica-Bold"
        l_expert.fontSize = 40.0
        l_expert.fontColor = UIColor.white
        l_expert.zPosition = 2
        l_expert.position = CGPoint(x:frame.midX, y:frame.midY + 200)
        addChild(l_expert)
        fireworks()
    }
    
    func fireworks(){
        firework = SKSpriteNode(imageNamed: "firework")
        firework.size = CGSize(width: 250, height: 250)
        firework.position = CGPoint(x: frame.midX, y: frame.midY+250)
        firework.zPosition = 1
        addChild(firework)
        animate(label: firework)
        
        let firework2 = SKSpriteNode(imageNamed: "firework")
        firework2.size = CGSize(width: 250, height: 250)
        firework2.position = CGPoint(x: frame.midX-75, y: frame.midY+200)
        firework2.zPosition = 1
        addChild(firework2)
        animate(label: firework2)
        
        let firework3 = SKSpriteNode(imageNamed: "firework")
        firework3.size = CGSize(width: 250, height: 250)
        firework3.position = CGPoint(x: frame.midX+75, y: frame.midY+200)
        firework3.zPosition = 1
        addChild(firework3)
        animate(label: firework3)
    }
    
    func animate(label: SKSpriteNode){
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.7)
        let scaleDown = SKAction.scale(to: 0.0, duration: 0.2)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
               label.run(SKAction.repeatForever(sequence))
    }
    
    func playLevel2(){
        play2 = SKLabelNode(text: "Level 2")
        play2.fontName = "Helvetica-Bold"
        play2.fontSize = 50.0
        play2.fontColor = UIColor.white
        play2.name = "l2"
        play2.zPosition = 1
        play2.position = CGPoint(x:self.size.width-60, y:frame.midY*1.8)
        addChild(play2)
    }
    
    func playLevel3(){
        play3 = SKLabelNode(text: "Level 3")
        play3.fontName = "Helvetica-Bold"
        play3.fontSize = 50.0
        play3.fontColor = UIColor.white
        play3.name = "l2"
        play3.zPosition = 1
        play3.position = CGPoint(x:self.size.width-60, y:frame.midY*1.8)
        addChild(play3)
    }
    
    func playLevel1(){
        play1 = SKLabelNode(text: "Level 1")
        play1.fontName = "Helvetica-Bold"
        play1.fontSize = 50.0
        play1.fontColor = UIColor.white
        play1.name = "l2"
        play1.zPosition = 1
        play1.position = CGPoint(x:self.size.width-60, y:frame.midY*1.8)
        addChild(play1)
    }
    
    func secondLevel(){
        level2 = SKSpriteNode(imageNamed: "level2_unlock")
        level2.size = CGSize(width: frame.size.width, height: frame.size.height)
        level2.position = CGPoint(x: frame.midX, y: frame.midY )
        level2.name = "level"
        addChild(level2)
    }
    func thirdLevel(){
        level3 = SKSpriteNode(imageNamed: "level3_unlock")
        level3.size = CGSize(width: frame.size.width, height: frame.size.height)
        level3.position = CGPoint(x: frame.midX, y: frame.midY )
        level3.name = "level"
        addChild(level3)
    }
    func playOtherLevels(){
        if level == 1 {
            
        }
    }
    
    func labelPlayAgain(){
        playagain = SKLabelNode(text: "Play Again")
        playagain.fontName = "Helvetica-Bold"
        playagain.fontSize = 50.0
        playagain.fontColor = UIColor.white
        playagain.name = "playagain"
        playagain.zPosition = 1
        playagain.horizontalAlignmentMode = .right
        playagain.position = CGPoint(x:self.size.width-60, y:frame.midY*1.8)
        addChild(playagain)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
        //if touch == touches.first {
        let tap = touch.location(in: self)
        enumerateChildNodes(withName: "//*", using: { (node, stop) in
                if node.contains(tap){
                    if node.name == "playagain" {
                        if let view = self.view {
                            let scene = GoalScene(size: view.bounds.size)
                           // scene.unlockedDiff = self.d
                            scene.level = self.level
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

    init(size: CGSize, lastgame: GameScene) {
               super.init(size: size)
               game = lastgame
               stage = game.level
          }
           
           required init?(coder aDecoder: NSCoder) {
                super.init(coder: aDecoder)
            }
    }

