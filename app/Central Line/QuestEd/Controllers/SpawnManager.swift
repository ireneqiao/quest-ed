//
//  SpawnManager.swift
//  QuestEd
//
//  Created by student on 9/28/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

extension GameScene {
    
    func spawnCoin() {
        let newCoin = Coin()
        let spawnHeight = GKRandomSource.sharedRandom().nextInt(upperBound: Int(self.frame.height - 2*newCoin.size.height)) + Int(newCoin.size.height)
        
        newCoin.position = CGPoint(x: self.frame.width + newCoin.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newCoin)
        newCoin.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
    }
    
    func spawnMagnet() {
        let newMagnet = Magnet()
        let spawnHeight = GKRandomSource.sharedRandom().nextInt(upperBound: Int(self.frame.height - 2*newMagnet.size.height)) + Int(newMagnet.size.height)
        
        newMagnet.position = CGPoint(x: self.frame.width + newMagnet.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newMagnet)
        newMagnet.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
    }
    
    func spawnHeart() {
        let newHeart = Heart()
        let spawnHeight = GKRandomSource.sharedRandom().nextInt(upperBound: Int(self.frame.height - 2*newHeart.size.height)) + Int(newHeart.size.height)
        
        newHeart.position = CGPoint(x: self.frame.width + newHeart.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newHeart)
        newHeart.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
    }
    
    func spawnTough() {
        let newTough = Tough()
        let spawnHeight = GKRandomSource.sharedRandom().nextInt(upperBound: Int(self.frame.height - 2*newTough.size.height)) + Int(newTough.size.height)
        
        newTough.position = CGPoint(x: self.frame.width + newTough.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newTough)
        newTough.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
    }
    
    func spawnLucky() {
        let newLucky = Lucky()
        let spawnHeight = GKRandomSource.sharedRandom().nextInt(upperBound: Int(self.frame.height - 2*newLucky.size.height)) + Int(newLucky.size.height)
        
        newLucky.position = CGPoint(x: self.frame.width + newLucky.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newLucky)
        newLucky.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
    }
    
    func spawnReflect() {
        let newReflect = Reflect()
        let spawnHeight = GKRandomSource.sharedRandom().nextInt(upperBound: Int(self.frame.height - 2*newReflect.size.height)) + Int(newReflect.size.height)
        
        newReflect.position = CGPoint(x: self.frame.width + newReflect.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newReflect)
        newReflect.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
    }
    
    func spawnPowerup() {
        let type = GKRandomSource.sharedRandom().nextInt(upperBound:5)
        
        switch type {
        case 0:
            spawnMagnet()
        case 1:
            spawnHeart()
        case 2:
            spawnTough()
        case 3:
            spawnLucky()
        case 4:
            spawnReflect()
        default:
            spawnCoin()
        }
    }
    
    func spawnRubble() {
        let dim = Double(GKRandomSource.sharedRandom().nextInt(upperBound: 50) + 100)
        let damage = dim/25.0
        let size = CGSize(width: dim, height: dim)
        let speed = Float(GKRandomSource.sharedRandom().nextInt(upperBound: 300) + 400) * moveSpeed.squareRoot()
        
        let newRubble = Rubble(size: size, damageDealt: damage, speed: CGVector(dx: Double(-speed), dy: 0))
        let spawnHeight = GKRandomSource.sharedRandom().nextInt(upperBound: Int(self.frame.height - 2*newRubble.size.height)) + Int(newRubble.size.height)
        
        newRubble.position = CGPoint(x: self.frame.width + newRubble.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newRubble)
        newRubble.physicsBody?.velocity = newRubble.selfSpeed
    }
    
    func spawnWall() {
        let dim = Double(GKRandomSource.sharedRandom().nextInt(upperBound: 350) + 250)
        let damage = 5.0
        let size = CGSize(width: 200, height: dim)
        
        let newWall = Wall(size: size, damageDealt: damage)
    
        let ceilingWall = GKRandomSource.sharedRandom().nextBool()
        //let offset = newWall.size.height/2
        let offset:CGFloat = 0
        let spawnHeight = ceilingWall ? self.frame.height - offset : offset
        
        newWall.position = CGPoint(x: self.frame.width + newWall.size.width, y: CGFloat(spawnHeight))
        
        self.addChild(newWall)
        newWall.physicsBody?.velocity = CGVector(dx: -300, dy: 0)
    }
    
    func despawn() {
        self.enumerateChildNodes(withName: "NOT PLAYER") { (node:SKNode, nil) in
            if node.position.x < -300  || node.position.y < -300 || node.position.x > self.frame.width + 300 || node.position.y > self.frame.height + 300 {
                node.removeFromParent()
            }
        }
    }
    
}
