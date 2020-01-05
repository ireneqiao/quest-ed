//
//  OceanScene.swift
//  Intent
//
//  Created by student on 11/12/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.

import SpriteKit
import GameplayKit

class OceanScene: GameScene {
    
    var seacurrent = SKSpriteNode()
    var lastcurrentchange = 0
    var lastshark = -10
    
    override func initScene() {
        super.initScene()
        addCurrent()
        level = 2
    }
    
    func removeCurrent() {
        for node in self.children {
            if let fish = node as? FishNode {
                    updateFishSpeedOutOfCurrent(fish: fish)
                }
            }
        seacurrent.removeFromParent()
    }
    
    func addCurrent() {
        seacurrent = CurrentNode(scene: self)
        seacurrent.position = CGPoint(x: 0, y: CGFloat.random(in: -size.height/2 ... size.height/2))
        self.addChild(seacurrent)
        lastcurrentchange = 0
    }
    
    
    func summonShark() -> Shark {
        let shark = Shark()
        makeFish(fish: shark)
        lastshark = 0
        return shark
    }
    
    override func decrementCounter() {
        super.decrementCounter()
        if !isPaused {
            if lastcurrentchange > Int.random(in: 0...20) {
                removeCurrent()
                addCurrent()
            }
            else {
            lastcurrentchange += 1
            }
            if lastshark > Int.random(in: 10...30) {
                summonShark()
            }
            else {
            lastshark += 1
            }
        }
    }
    
    func updateFishSpeedOutOfCurrent(fish: FishNode) {
        if let current = seacurrent as? CurrentNode {
            if (fish.orientation == current.orientation && fish.currenteffect) {
                fish.speed = fish.speed / 2
            }
            else if (fish.currenteffect) {
                fish.speed = fish.speed * 2
            }
            fish.currenteffect = false
        }
    }
    
    func updateFishSpeedInCurrent(fish: FishNode) {
        if let current = seacurrent as? CurrentNode {
            if (fish.orientation == current.orientation && !fish.currenteffect) {
                fish.speed = fish.speed * 2
            }
            else if (!fish.currenteffect) {
                fish.speed = fish.speed / 2
            }
            fish.currenteffect = true
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        for node in self.children {
                if let victim = node as? FishNode {
                    if victim.intersects(seacurrent) && seacurrent.parent != nil {
                        updateFishSpeedInCurrent(fish: victim)
                    }
                    else {
                        updateFishSpeedOutOfCurrent(fish: victim)
                    }
                    for node2 in self.children {
                        if let shark = node2 as? Shark {
                            if victim.intersects(shark) && victim.name != "shark" {
                                shark.eat(fish: victim)
                            }
                        }
                    
                }
            }

            }
        }
    }
    
