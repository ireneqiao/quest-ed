//
//  GameScene.swift
//  Intent
//
//  Created by Paulina Asturias on 10/2/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//
import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    var currscore = 0 //tracks fish tapped count
    var counter = 1 // timer counter
    var counterTimer = Timer()
    var health = 1
    let counterStartValue = ["easy": 5, "medium": 5, "hard": 5, "expert": 5]//["easy": 75, "medium": 60, "hard": 45, "expert": 30]
    let maxhealth = ["easy": 15, "medium": 10, "hard": 5, "expert": 3]
    var background = SKSpriteNode()
    var lastUpdateTime : TimeInterval = 0
    var score = SKLabelNode() //where the score will be displayed
    var countDownLabel = SKLabelNode()
    var healthLabel = SKSpriteNode()
    var redBase = SKSpriteNode()
    var help = SKSpriteNode()
    var instructions: SKSpriteNode!
    var difficulty: String!
    var goal = SKLabelNode()
    var goalNum = Int()
    var levelup: SKSpriteNode!
    var diffup: SKSpriteNode!
    var notified = false
    //var level = 1
    var level = Int()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let locus = touch.location(in: self)
            let touchedNode = self.atPoint(locus)
            if !isPaused {
                removeFish(s: touchedNode)
            }
            if touchedNode.name == "help" && !isPaused {
                    self.fish_instructions()
                    self.pausescene()
                }
            else if (touchedNode.name == "instructions" || touchedNode.name == "help") && instructions!.parent != nil {
                instructions.removeFromParent()
                self.unPause()
            }
            else if (touchedNode.name == "levelup" || touchedNode.name == "diffup") && isPaused{
                touchedNode.removeFromParent()
                self.unPause()
            }
        }
    }
    
    func removeFish(s: SKNode ){
        if let tappedfish = s as? FishNode {
            tappedfish.removeFromParent()
            currscore += tappedfish.scorechange
            health += tappedfish.healthchange
            if health > maxhealth[difficulty]! {
                health = maxhealth[difficulty]!
            }
        }
        if s.name == "plateletpu"{
            counter += 20
        }
        else if s.name == "whitepu" {
                for node in self.children {
                    if let fish = node as? FishNode {
                        fish.speed /= 2
                    }
                }
            }
        }
    
    
    func addFish() {
        let number = Int.random(in: 0...20)
        let powerup = Int.random(in: 0...20)
        determineFish(number: number , powerup: powerup)
    }
    
    func determineFish(number: Int, powerup: Int) -> FishNode {
        var fish = FishNode()
        if number > 17 {
            fish = SickFish()
        }
        else if number > 13 {
            fish = Platelet(pu: powerup)
        }
        else if number > 9 {
            fish = WhiteFish(pu: powerup)
        }
        else {
            fish = RedFish(pu: powerup)
        }
        makeFish(fish: fish)
        return fish
    }
    
    func makeFish(fish: FishNode) {
    let startingY = CGFloat(Float.random(in: Float(-size.height/2 + fish.size.height/2)...Float(size.height/2 - fish.size.height/2)))
    let destinationY = CGFloat(Float.random(in: Float(-size.height/2 + fish.size.height/2)...Float(size.height/2 - fish.size.height/2)))
    var startingX = size.width/2 + fish.size.width/2
    var endX = -size.width/2 - fish.size.width/2
    if (Int.random(in: 0 ... 1) == 0) {
        fish.orientation = 1
        startingX = -size.width/2 - fish.size.width/2
        endX = size.width/2 + fish.size.width/2
        fish.xScale = fish.xScale * -1
    }
    fish.position = CGPoint(x: startingX, y: startingY)
    addChild(fish)
    let actionMove = SKAction.follow(createPath(x1: startingX, x2: endX, y1: startingY, y2: destinationY).cgPath, asOffset: false, orientToPath: false, speed: CGFloat(fish.swiftness))
    let actionMoveDone = SKAction.removeFromParent()
    fish.run(SKAction.sequence([actionMove, actionMoveDone]))}
    
func createPath(x1: CGFloat, x2: CGFloat, y1: CGFloat, y2: CGFloat) -> UIBezierPath {
        let dy = (y2 - y1)
        let path = UIBezierPath()
        let period = Double.random(in: 0.75...1.25)
        let amp = Double.random(in: 0...80)
        path.move(to: CGPoint(x: x1, y: y1))
         for i in 0...200 {
            let x = x1 + 2 * CGFloat(i) * x2 / 200
            let offset = dy * CGFloat(i) / 200 + y1
            let y = CGFloat(amp * sin(Double(i) * 0.1 / period)) + offset
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.move(to: CGPoint(x: x2, y: y2))
        path.close()
        return path
    }
    
func startCounter(){
        countDownLabel.text = "Timer: \(counter)"
        counterTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrementCounter), userInfo: nil, repeats: true)
    }
    
    @objc func decrementCounter(){
        if (!isPaused) {
      counter -= 1
      countDownLabel.text = "Timer: \(counter)"
        }
    }
    
    
    func initScene() {
        score = self.childNode(withName: "score") as! SKLabelNode
        
        countDownLabel = self.childNode(withName: "timer") as! SKLabelNode
        
        healthLabel = self.childNode(withName: "life") as! SKSpriteNode
        
        redBase = self.childNode(withName: "red") as! SKSpriteNode
        
        help = self.childNode(withName: "help") as! SKSpriteNode
        help.name = "help"
        
        goal = self.childNode(withName: "goal") as! SKLabelNode
        
        background = self.childNode(withName: "background") as! SKSpriteNode
        
        instructions = SKSpriteNode(imageNamed:"helpinstructions")
        instructions.size = CGSize(width: frame.size.width/1.2, height: frame.size.height/1.2)
        instructions.position = CGPoint(x: frame.midX, y: frame.midY)
        instructions.name = "instructions"
        instructions.zPosition = 1
                
        health = maxhealth[difficulty]!
        counter = counterStartValue[difficulty]!
        startCounter()
    }
    
    func fish_instructions(){ //function to display instruction fish menu
        addChild(instructions)
    }
    
    func pausescene(){
        isPaused = true
    }
    
    func unPause(){
        isPaused = false
    }
    
    func spawnFish() -> SKAction {
        return SKAction.repeat(SKAction.sequence([
        SKAction.run(addFish),
        SKAction.wait(forDuration: Double.random(in: 0.0 ... 1.0))]), count: 3)
    }
    //set goal depending on the goal
    func levelup_func(){
        diffup = SKSpriteNode(imageNamed: "diff_up")
        diffup.size = CGSize(width: frame.size.width/2, height: frame.size.height/2)
        diffup.position = CGPoint(x: frame.midX, y: frame.midY)
        diffup.name = "diffup"
        diffup.zPosition = 1
        
        levelup = SKSpriteNode(imageNamed: "levelup")
        levelup.size = CGSize(width: frame.size.width/2, height: frame.size.height/2)
        levelup.position = CGPoint(x: frame.midX, y: frame.midY)
        levelup.name = "levelup"
        levelup.zPosition = 1
        
        if difficulty != "expert" {
            addChild(diffup)
        }
        else {
            addChild(levelup)
        }
    }
    
    
    
    override func didMove(to view: SKView) {
        initScene()
        run(SKAction.repeatForever(SKAction.sequence([
                spawnFish(),
                SKAction.wait(forDuration: Double.random(in: 1.0 ... 3.0))
                ])
        ))}
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if ((counter == 0 && currscore < goalNum) || health == 0) { //include the fish count condition
            if let view = self.view {
                let scene = GameOverScene(size: view.bounds.size, lastgame: self)
                scene.scaleMode = .aspectFill
                scene.score = currscore
     
                view.presentScene(scene)
            view.ignoresSiblingOrder = false
            view.showsFPS = false
            view.showsNodeCount = false
            }
        }
        else if (counter == 0 && currscore >= goalNum) {
           if let view = self.view {
            let scene = LevelScene(size: view.bounds.size, lastgame: self)
                scene.scaleMode = .aspectFill
                scene.score = currscore
                scene.level = level
                scene.goal = goalNum
                scene.difficulty = difficulty
                view.presentScene(scene)
            view.ignoresSiblingOrder = false
            view.showsFPS = false
            view.showsNodeCount = false
            }
        }

        healthLabel.size = CGSize(width: CGFloat(health)/CGFloat(maxhealth[difficulty]!) * redBase.size.width, height: healthLabel.size.height)
        //Initialize _lastUpdateTime if it has not already been
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
                    if let victim = node2 as? FishNode {
                        if node.intersects(victim) {
                            victim.infect()
                       }
                    }
                }
            }
        }
        score.text = "Score: \(currscore)"
        goal.text = "Goal: \(goalNum)"
        
        self.lastUpdateTime = currentTime
        
        if currscore >= goalNum && !notified {
                pausescene()
                levelup_func()
                notified = true
            }

        if difficulty == "easy" {
            UserDefaults.standard.set(currscore,forKey:"Easy_Recentscore")
        if currscore > UserDefaults.standard.integer(forKey: "Easy_Highscore") {
            UserDefaults.standard.set(currscore, forKey: "Easy_Highscore")
            }
        }
        else if difficulty == "medium" {
            UserDefaults.standard.set(currscore,forKey:"Med_Recentscore")
            if currscore > UserDefaults.standard.integer(forKey: "Med_Highscore") {
                UserDefaults.standard.set(currscore, forKey: "Med_Highscore")
                }
        }
        else if difficulty == "hard" {
            UserDefaults.standard.set(currscore,forKey:"Hard_Recentscore")
            if currscore > UserDefaults.standard.integer(forKey: "Hard_Highscore") {
                UserDefaults.standard.set(currscore, forKey: "Hard_Highscore")
                }
        }
        else if difficulty == "expert" {
            UserDefaults.standard.set(currscore,forKey:"Expert_Recentscore")
            if currscore > UserDefaults.standard.integer(forKey: "Expert_Highscore") {
                UserDefaults.standard.set(currscore, forKey: "Expert_Highscore")
                }
        }
    }
}

