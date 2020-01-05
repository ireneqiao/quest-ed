//
//  DeepScene.swift
//  Intent
//
//  Created by student on 12/2/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
import GameplayKit

class DeepScene: OceanScene {
    
    var light = SKSpriteNode(imageNamed: "lightLevel3") //change design to another illustration
    var lightchange = 0
    
    
    func addLight(){
        let randomsize = CGFloat.random(in: 600...800)
        light.size = CGSize(width: randomsize, height: randomsize)
        light.position = CGPoint(x: CGFloat.random(in: -self.size.width/2 + light.size.width/2...self.size.width/2 - light.size.width/2), y: CGFloat.random(in: -self.size.height/2 + light.size.height/2...self.size.height/2 - light.size.height/2))
        light.zPosition = -10
        self.addChild(light)
        lightchange = 0
    }
    
    func removeLight() {
        light.removeFromParent()
        lightchange = 0
    }
    
    override func initScene() {
        super.initScene()
        level = 3
        addLight()
    }

    override func decrementCounter() {
        super.decrementCounter()
        if !isPaused {
            if lightchange == 1 && light.parent != nil{
                removeLight()
            }
            else if lightchange == 1 {
                addLight()
            }
            else {
                lightchange += 1
            }
    }
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        for node in self.children {
        if let victim = node as? FishNode {
            if victim.intersects(light) && light.parent != nil {
                victim.isHidden = false
            }
            else {
                victim.isHidden = true
                }
            }
        }
    }
}
    
