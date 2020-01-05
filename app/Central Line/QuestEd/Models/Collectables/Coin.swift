//
//  Coin.swift
//  QuestEd
//
//  Created by student on 9/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: Collectable{
    var coinFrames: [SKTexture] = []
    
    init() {
        super.init(imgNamed: "coin", size: CGSize(width: 40, height: 40))
        self.physicsBody?.categoryBitMask = BitMasks.collectableCategory | BitMasks.magnetizableCategory
        self.physicsBody?.fieldBitMask = FieldBitMasks.scrollCategory | FieldBitMasks.magnetCategory
        buildCoin()
        animateCoin()
    }
    
    func buildCoin() {
        let coinAnimatedAtlas = SKTextureAtlas(named: "coin")
        var walkFrames: [SKTexture] = []
        let numImages = coinAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let coinTextureName = "coin\(i)"
            walkFrames.append(coinAnimatedAtlas.textureNamed(coinTextureName))
        }
        coinFrames = walkFrames
        let firstFrameTexture = coinFrames[0]
        self.texture = firstFrameTexture
    }
    
    func animateCoin() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: coinFrames,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"rotating coin")
    }
    
    override func getCollected(by player: Player) {
        player.coinsThisGame += 1
        
        if let scene = player.scene as? GameScene {
            let coinSound = SKAction.playSoundFileNamed("coin.aac", waitForCompletion: true)
            scene.run(coinSound)

            scene.coinsCollected?.text = "Coins: \(player.coinsThisGame)"
            if let emitter = SKEmitterNode(fileNamed: "GetCoin.sks") {
                emitter.physicsBody = SKPhysicsBody(circleOfRadius: 100)
                emitter.physicsBody?.affectedByGravity = false
                emitter.physicsBody?.linearDamping = 0.0
                emitter.physicsBody?.categoryBitMask = 0
                emitter.physicsBody?.collisionBitMask = 0
                emitter.position = self.position
                scene.addChild(emitter)
                scene.run(SKAction.wait(forDuration: 1)){
                    emitter.removeFromParent()
                }
                
            }
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
