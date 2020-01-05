//
//  ContactDelegate.swift
//  QuestEd
//
//  Created by student on 11/7/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    //MARK: -Contact Delegate
    
    func didBegin(_ contact: SKPhysicsContact) {
        var playerBody:SKPhysicsBody
        var otherBody:SKPhysicsBody
        var transferBoundaryBody:SKPhysicsBody
        
        
        //MARK: Contacts with Player
        if contact.bodyA.categoryBitMask == BitMasks.playerCategory || contact.bodyA.categoryBitMask == BitMasks.invinciblePlayerCategory || contact.bodyB.categoryBitMask == BitMasks.playerCategory || contact.bodyB.categoryBitMask == BitMasks.invinciblePlayerCategory {
            
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                playerBody = contact.bodyA
                otherBody = contact.bodyB
            } else {
                playerBody = contact.bodyB
                otherBody = contact.bodyA
            }
            
            if otherBody.categoryBitMask & BitMasks.obstacleCategory != 0 {
                self.run(SKAction.sequence([
                    SKAction.run(player!.becomeInvincible),
                    SKAction.wait(forDuration: TimeInterval(3)),
                    SKAction.run(player!.loseInvincible)
                ]))
                if let obstacle = otherBody.node as? Obstacle {
                    obstacle.damagePlayer(player!)
                }
                self.run(SKAction.playSoundFileNamed("break.aac", waitForCompletion: true))
                self.healthBar?.run(SKAction.resize(toWidth: CGFloat(100 * (player!.health/player!.maxHealth)), duration: 0.3))
                moveSpeed = max(1, moveSpeed * 0.7)
                
                if let emitter = SKEmitterNode(fileNamed: "Damage.sks") {
                    emitter.position = player!.position
                    self.addChild(emitter)
                    self.run(SKAction.wait(forDuration: 3)){
                        emitter.removeFromParent()
                    }
                    
                }
                
            } else if otherBody.categoryBitMask & BitMasks.collectableCategory != 0 {
                
                if let collectable = otherBody.node as? Collectable {
                    collectable.getCollected(by: player!)
                    collectable.removeFromParent()
                }
            }
            
        }
            
        //MARK: Contacts with Reflector
        if contact.bodyA.categoryBitMask == BitMasks.reflectorCategory || contact.bodyB.categoryBitMask == BitMasks.reflectorCategory {
            
            var reflectorBody: SKPhysicsBody
            
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                reflectorBody = contact.bodyA
                otherBody = contact.bodyB
            } else {
                reflectorBody = contact.bodyB
                otherBody = contact.bodyA
            }
            
            if otherBody.categoryBitMask & BitMasks.reflectableCategory != 0 {
                self.run(SKAction.playSoundFileNamed("reflection.aac", waitForCompletion: true))
                otherBody.categoryBitMask = (otherBody.categoryBitMask & ~BitMasks.reflectableCategory) | BitMasks.reflectedCategory
                otherBody.fieldBitMask = 0
                otherBody.contactTestBitMask = BitMasks.reflectableCategory
                otherBody.velocity = CGVector(dx: -otherBody.velocity.dx, dy: 0)
                otherBody.angularVelocity = -20
            }
            
        }
            
        //MARK: Contacts with Reflected
        if contact.bodyA.categoryBitMask & BitMasks.reflectedCategory != 0 || contact.bodyB.categoryBitMask & BitMasks.reflectedCategory != 0 {
            
            var reflectedBody: SKPhysicsBody
            
            if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
                reflectedBody = contact.bodyA
                otherBody = contact.bodyB
            } else {
                reflectedBody = contact.bodyB
                otherBody = contact.bodyA
            }
            
            if otherBody.categoryBitMask & BitMasks.reflectableCategory != 0 {
                if let node = otherBody.node {
                    self.run(SKAction.playSoundFileNamed("break.aac", waitForCompletion: true))
                    if let emitter = SKEmitterNode(fileNamed: "FishDamage.sks") {
                        emitter.position = node.position
                        self.addChild(emitter)
                        self.run(SKAction.wait(forDuration: 3)){
                            emitter.removeFromParent()
                        }
                        
                    }
                    node.removeFromParent()
                }
            }
            
        }
        
        //MARK: Contacts with Transter Boundary
        else if contact.bodyA.categoryBitMask == BitMasks.transferBoundaryCategory || contact.bodyB.categoryBitMask == BitMasks.transferBoundaryCategory {
            
            if contact.bodyA.categoryBitMask > contact.bodyB.categoryBitMask {
                transferBoundaryBody = contact.bodyA
                otherBody = contact.bodyB
            } else {
                transferBoundaryBody = contact.bodyB
                otherBody = contact.bodyA
            }
            
            
            if let transferBoundaryNode = transferBoundaryBody.node as? TransferBoundary {
                if otherBody.categoryBitMask & transferBoundaryNode.affectedBitmask != 0 {
                    otherBody.fieldBitMask = transferBoundaryNode.toField
                    otherBody.categoryBitMask = otherBody.categoryBitMask & ~BitMasks.magnetizableCategory
                    
                }
            }
            
            
        }
        
        
        
        
        
    }
}
