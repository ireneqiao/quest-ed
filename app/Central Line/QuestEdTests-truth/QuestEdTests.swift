//
//  QuestEdTests.swift
//  QuestEdTests
//
//  Created by student on 10/16/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import XCTest
@ testable import QuestEd

class QuestEdTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
            XCTAssert(game.player?.coinsThisGame == 0 && game.player?.health == 100.0)
        }
    }
    /*
    func testPurchaseItem() {
        let player = Player()
        let startCoins = player.coinsThisGame
        let storeItem = StoreItem()
        player.purchaseStoreItem()
        XCTAssert(player.coins == startCoins - storeItem.price)
    }
    */
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
