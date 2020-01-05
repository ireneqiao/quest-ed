//
//  Rubble.swift
//  QuestEd
//
//  Created by student on 9/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Rubble: Obstacle {
    
    var selfSpeed: CGVector
    var fishFrames: [SKTexture] = []

    
    init(size: CGSize, damageDealt: Double, speed: CGVector) {
        self.selfSpeed = speed
        super.init(imgNamed: "rubble", size: size, damageDealt: damageDealt)
        self.physicsBody?.categoryBitMask = self.physicsBody!.categoryBitMask | BitMasks.reflectableCategory
        self.physicsBody?.fieldBitMask = 0
        buildFish()
        animateFish()
    }
    
    func buildFish() {
        let fishAnimatedAtlas = SKTextureAtlas(named: "sickFish")
        var walkFrames: [SKTexture] = []
        let numImages = fishAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let fishTextureName = "sickFish\(i)"
            walkFrames.append(fishAnimatedAtlas.textureNamed(fishTextureName))
        }
        fishFrames = walkFrames
        let firstFrameTexture = fishFrames[0]
        self.texture = firstFrameTexture
    }
    
    func animateFish() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: fishFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"swimming fish")
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
