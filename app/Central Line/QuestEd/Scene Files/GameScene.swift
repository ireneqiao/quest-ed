//
//  GameScene.swift
//  QuestEd
//
//  Created by student on 9/24/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    var lastUpdateTime : TimeInterval = 0
    var realPaused : Bool = false
    
    var background: SKSpriteNode?
    var pauseScreen: SKShapeNode?
    var coinsCollected: SKLabelNode?
    var healthBar: SKSpriteNode?
    var distanceTraveled: SKLabelNode?
    var speedometer: SKLabelNode?
    
    
    var player: Player?
    var startingPowerup:Powerup?
    
    var scroll: SKFieldNode?
    var isTouching: Bool = false
    var distance: Double = 0 {
        didSet {
            self.distanceTraveled?.text = String(format: "Distance: %.0f", self.distance)
        }
    }
    var moveSpeed: Float = 1 {
        didSet {
            if let scroll = scroll {
                scroll.direction.x = -moveSpeed
                self.speedometer?.text = String(format: "Speed: %.2f", self.moveSpeed)
            }
            
            spawnNode!.speed = CGFloat(moveSpeed)
        }
    }
    
    var spawnNode: SKNode?
    
    
    //MARK: -sceneDidLoad
    override func sceneDidLoad() {

        self.lastUpdateTime = 0
        
        //Initialize Background
        makeBackground()
        
        //Initialize UI
        coinsCollected = self.childNode(withName: "coins") as? SKLabelNode
        healthBar = self.childNode(withName: "healthBar") as? SKSpriteNode
        distanceTraveled = self.childNode(withName: "distance") as? SKLabelNode
        speedometer = self.childNode(withName: "speed") as? SKLabelNode
        pauseScreen = self.childNode(withName: "pauseScreen") as? SKShapeNode
        //background = self.childNode(withName: "background") as? SKSpriteNode
        
        //Create border
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody?.categoryBitMask = BitMasks.borderCategory
        
        //Initialize Player
        player = Player()
        player?.position = CGPoint(x: 150, y: self.size.height / 2)
        
        //Initialize Scroll
        scroll = SKFieldNode.velocityField(withVector: vector3(-1, 0, 0))
        scroll?.categoryBitMask = FieldBitMasks.scrollCategory
        scroll?.isExclusive = false
        self.addChild(scroll!)
        
        
        //Initialize spawns
        spawnNode = SKNode()
        self.addChild(spawnNode!)
        
        spawnNode!.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 0.7, withRange: 0.2),
            SKAction.run {self.spawnCoin()}
            
        ])))
        
        spawnNode!.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: 4, withRange: 3),
            SKAction.run {self.spawnRubble()}
        ])))
        
        spawnNode!.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: Double(4), withRange: Double(2)),
            SKAction.run {self.spawnWall()}
        ])))
        
        spawnNode!.run(SKAction.repeatForever(SKAction.sequence([
            SKAction.wait(forDuration: Double(18), withRange: Double(7)),
            SKAction.run {self.spawnPowerup()}
        ])))

        
        //Initialize BGM
        initAudio()
        
        self.physicsWorld.contactDelegate = self
        
        //Initialize Powerup
        if let player = player {
            for powerup in player.myPowerups {
                powerup.deploy(to: self)
                print("powerup deployed")
            }
        }
        
        //add player to scene
        self.addChild(player!)

    }
    
    
    //MARK: -didMove to view
    override func didMove(to view: SKView) {
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.previousLocation(in: self)
            let node = self.nodes(at: location).first
            
            //Pause Button
            if node?.name == "pauseButton" {
                if !self.realPaused {
                    self.realPaused = true
                    self.isPaused = true
                    pauseScreen?.zPosition = 3
                }
            }
            
            //Pause Screen
            else if self.realPaused {
                
                if node?.name == "resumeButton" {
                    pauseScreen?.zPosition = -3
                    self.realPaused = false
                    self.isPaused = false
                }
                
                if node?.name == "quitButton" {
                    let transition = SKTransition.fade(withDuration: 1)
                    if let gameScene = SKScene(fileNamed: "StartScene") as? StartScene { 
                        gameScene.scaleMode = .aspectFit
                        self.view?.presentScene(gameScene, transition: transition)
                    }
                }
                
                if node?.name == "muteButton" {
                    if self.audioEngine.mainMixerNode.outputVolume > 0 {
                        self.audioEngine.mainMixerNode.outputVolume = 0
                        if let muteButton = node as? SKSpriteNode {
                            muteButton.texture = SKTexture(imageNamed: "mute")
                        }
                    } else if self.audioEngine.mainMixerNode.outputVolume == 0 {
                        self.audioEngine.mainMixerNode.outputVolume = 1
                        if let muteButton = node as? SKSpriteNode {
                            muteButton.texture = SKTexture(imageNamed: "unmute")
                        }
                    }
                    
                }
                
            }

                
            else {
                isTouching = true
            }

        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       isTouching = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
       
    }
    

    
    
    
    
    
    //MARK: -Update
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if isTouching {
            if let playerNode = player {
                playerNode.lift()
            }
        } else if player!.physicsBody!.velocity.dy > CGFloat(0) {
            player?.physicsBody?.velocity.dy *= 0.7
        }
    
        if player!.health > 0.0 {
            
            if realPaused {
                self.isPaused = true
            } else {
                self.isPaused = false
            }
            
            let distanceScaling = Float((distance+7000)/7000)
            moveSpeed += Float(0.005 * ((7-moveSpeed)/7) * distanceScaling)
            distance += Double(moveSpeed)
            
            despawn()
            doMagnet()
            
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
            
            self.lastUpdateTime = currentTime
        }
    
        else {
            let defaults = UserDefaults.standard
            let previousCoinsTotal: Int
            if defaults.value(forKey: "player_total_coins") != nil {
                previousCoinsTotal = defaults.value(forKey: "player_total_coins") as! Int
            }
            else {
                previousCoinsTotal = 0
            }
            defaults.set(player!.coinsThisGame + previousCoinsTotal, forKey: "player_total_coins")
            let transition = SKTransition.fade(withDuration: 1)
            if let gameScene = SKScene(fileNamed: "EndScene") as? EndScene {
                gameScene.coins = player!.coinsThisGame
                gameScene.distance = distance
                gameScene.scaleMode = .aspectFit
                self.view?.presentScene(gameScene, transition: transition)
            }
            
        }
        
    }
    
    //MARK: Misc Help Functions
    
    func distanceBetweenPoints(_ first: CGPoint, _ second: CGPoint) -> CGFloat {
        return CGFloat(hypotf(Float(second.x - first.x), Float(second.y - first.y)));
    }
    
    func doMagnet() {
        self.enumerateChildNodes(withName: "QuestEd.Coin") { (node:SKNode, nil) in
            if Magnet.currentMagnets.count != 0 {
                if self.distanceBetweenPoints(self.player!.position, node.position) < Magnet.range {
                    node.physicsBody?.fieldBitMask = FieldBitMasks.magnetCategory
                }
                
            }
        }
    }
}
