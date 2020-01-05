//
//  QuestEdTests.swift
//  QuestEdTests
//
//  Created by student on 10/16/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import XCTest
import SpriteKit
@ testable import QuestEd

class QuestEdTests: XCTestCase {
    let view: SKView = SKView()
    let scene: GameScene = GameScene()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        continueAfterFailure = false
        view.presentScene(scene)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        Tough.toughCount = 0
    }

    func testLift() {
        var player1 = Player()
        player1.lift()
        var player2 = Player()
        player2.size = CGSize(width: 128, height: 128)
        player2.lift()
        print(player1.physicsBody?.velocity)
        XCTAssert(player1.physicsBody?.velocity == player2.physicsBody?.velocity)
    }
    
    func testStartGameStats() {
        let game = GameScene()
        if game.distance == 0 {
            XCTAssert(game.player?.coinsThisGame == 0 && game.player?.health == game.player?.maxHealth)
        }
    }
    
    func testTakeDamage() {
        let dmg: Double = 3
        var currentHealth: Double
        
        let player = Player()
        currentHealth = player.health
        
        let obstacle = Rubble(size: CGSize(width: 0, height: 0), damageDealt: dmg, speed: CGVector(dx: 0, dy: 0))
        
        obstacle.damagePlayer(player)
        XCTAssert(currentHealth - player.health == dmg)
        
        
    }
    
    //MARK: Collectable Tests
    func testGetCoin() {
        var currentCoins: Int
        
        let player = Player()
        currentCoins = player.coinsThisGame
        
        let coin = Coin()
        
        coin.getCollected(by: player)
        XCTAssert(player.coinsThisGame - currentCoins == 1)
    }
    
    func testGetMagnet() {
        let player = scene.player
        let magnet = Magnet()
        
        if let player = player {
            magnet.getCollected(by: player)
            XCTAssert(Magnet.currentMagnets.count == 3)
        } else {
            XCTFail()
        }
        
    }
    
    func testGetHeart() {
        let player = scene.player
        let heart = Heart()
        
        if let player = player {
            
            player.health = 1
            let currentHealth = player.health
            heart.getCollected(by: player)
            XCTAssert(player.health - currentHealth == Heart.healAmount)
        } else {
            XCTFail()
        }
        
    }
    
    func testGetTough() {
        let player = scene.player
        let tough = Tough()
        
        if let player = player {
            
            tough.getCollected(by: player)
            XCTAssert(Tough.toughCount > 0)
            
            let dmg: Double = 4
            var currentHealth: Double
            
            currentHealth = player.health
            
            let obstacle = Rubble(size: CGSize(width: 0, height: 0), damageDealt: dmg, speed: CGVector(dx: 0, dy: 0))
            
            obstacle.damagePlayer(player)
            XCTAssert(currentHealth - player.health == dmg * Tough.defenseMod)
        } else {
            XCTFail()
        }
    }
    
    func testGetReflect() {
        let player = scene.player
        let reflect = Reflect()
        
        if let player = player {
            reflect.getCollected(by: player)
            XCTAssert(Reflect.currentReflectors.count == 1)
        } else {
            XCTFail()
        }
    }

    //MARK: Game Store Tests
    
    func testGameStoreBuy() {
        let store = StoreScene()
        store.coinsTotal = -100
        store.myStoreItems = Array<String>()
        store.buyItem(item: InvincibilityPowerup())
        XCTAssert(!(store.myStoreItems?.contains(InvincibilityPowerup().displayName!))!)
    }
}
