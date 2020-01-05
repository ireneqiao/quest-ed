//
//  Player.swift
//  QuestEd
//
//  Created by student on 9/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    var health: Double = 40.0
    var maxHealth: Double = 40.0
    var moveSpeed: Float = 0

    var coinsThisGame: Int = 0
    var storeItems: [StoreItem] = []
    var myPowerups: [Powerup] = []
    //TODO: fetch stored data from NSUserDefaults when Player is initialized, to be used in GameStore
    
    var skin: SKTexture = SKTexture(imageNamed: "player")
    
    convenience init() {
        self.init(imageNamed: "player")
        let defaults = UserDefaults.standard
        let storeItemsArray = defaults.value(forKey: "player_powerups")
        if let itemsArray = storeItemsArray as? Array<String> {
            for item in itemsArray { //check if we can use array of StoreItems instead to get rid of conditionals
                if item == "Invincibility Powerup"{
                    storeItems.append(InvincibilityPowerup()) //TODO: refactor this
                    myPowerups.append(InvincibilityPowerup())
                }
                else if item == "Magnet Powerup"{
                    storeItems.append(MagnetPowerup())
                    myPowerups.append(MagnetPowerup())
                }
                else if item == "Colorful Player"{
                    storeItems.append(ColorfulPlayerItem())
                    myPowerups.append(ColorfulPlayerItem())
                    print("colorful player added to user arrays")
                }
            }
        }

        //erase player_powerups once copied into Player
        defaults.set(Array<String>(), forKey: "player_powerups")
        
        self.size = CGSize(width: 60, height: 90)
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.restitution = 0.0
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.categoryBitMask = BitMasks.playerCategory
        self.physicsBody?.fieldBitMask = 0
        self.physicsBody?.collisionBitMask = BitMasks.borderCategory
        self.physicsBody?.contactTestBitMask = BitMasks.collectableCategory
    }
    
    func lift() {
        let y = self.physicsBody!.velocity.dy
        if y < 0 {
            self.physicsBody?.velocity.dy = 0
        }
        self.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 50*self.physicsBody!.mass))
    }
    
    func becomeInvincible() {
        self.physicsBody?.categoryBitMask = BitMasks.invinciblePlayerCategory
        self.texture = SKTexture(imageNamed: "player-invincible")
    }
    
    func loseInvincible() {
        self.physicsBody?.categoryBitMask = BitMasks.playerCategory
        self.texture = skin
    }
    
    func decreaseHealth(num: Double){
        health -= num
    }
    
    func increaseHealth(num: Double){
        health += num
    }
    
    
}
