//
//  IntentTests.swift
//  IntentTests
//
//  Created by Paulina Asturias on 10/2/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import XCTest
import SpriteKit
@testable import Intent

class IntentTests: XCTestCase {
    let view: SKView = SKView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
    let game: GameScene = GameScene(fileNamed: "GameScene")!
    let ocean = OceanScene(fileNamed: "OceanScene")!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        game.difficulty = "medium"
        ocean.difficulty = "medium"
        view.presentScene(game)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func determineFishCreation() {
        var fish1 = game.determineFish(number: 1, powerup: 0)
        var fish2 = game.determineFish(number: 1, powerup: 0)
        XCTAssert(fish1.name == fish2.name)
        XCTAssert(fish1.size == fish2.size)
        fish1 = game.determineFish(number: 20, powerup: 10)
        fish2 = game.determineFish(number: 20, powerup: 10)
        XCTAssert(fish1.name == fish2.name)
        XCTAssert(fish1.size == fish2.size)
    }
    
    func determineFishCreationWithNegativeNumber() {
        let fish1 = game.determineFish(number: -100000, powerup: 0)
        let fish2 = RedFish(pu: 0)
        XCTAssert(fish1.name == fish2.name)
        XCTAssert(fish1.size == fish2.size)
        XCTAssert(fish1.healthchange == fish2.healthchange)
        XCTAssert(fish1.scorechange == fish2.scorechange)
    }
    
    func testScoreAddition() {
        var fish1 = game.determineFish(number: 1, powerup: 0)
        var fish2 = game.determineFish(number: 1, powerup: 0)
        var score = game.currscore
        game.removeFish(s: fish1)
        var scorediff1 = game.currscore - score
        score = game.currscore
        game.removeFish(s: fish2)
        var scorediff2 = game.currscore - score
        XCTAssert(scorediff1 == scorediff2)
        fish1 = game.determineFish(number: 2, powerup: 0)
        fish2 = game.determineFish(number: 2, powerup: 10)
        score = game.currscore
        game.removeFish(s: fish1)
        scorediff1 = game.currscore - score
        score = game.currscore
        game.removeFish(s: fish2)
        scorediff2 = game.currscore - score
        XCTAssert(scorediff1 == scorediff2)
    }
    
    func testHealthDepletion() {
        let sickfish = game.determineFish(number: 20, powerup: 10)
        var health = game.health
        game.removeFish(s: sickfish)
        XCTAssert(health == game.health + 1)
        let redfish = RedFish(pu: 10)
        redfish.infect()
        health = game.health
        game.removeFish(s: redfish)
        XCTAssert(health == game.health + 1)
        
    }
    func testPowerup() {
        var fish1 = game.determineFish(number: 1, powerup: 10)
        var counter = game.counter
        var health = game.health
        game.removeFish(s: fish1)
        XCTAssert(counter == game.counter)
        XCTAssert(health == game.health)
        fish1 = game.determineFish(number: 15, powerup: 0)
        counter = game.counter
        health = game.health
        game.removeFish(s: fish1)
        XCTAssert(counter < game.counter)
        XCTAssert(health == game.health)
    }
    
    
    func testPause() {
        game.pausescene()
        var counter = game.counter
        game.decrementCounter()
        XCTAssert(counter == game.counter)
        game.unPause()
        counter = game.counter
        game.decrementCounter()
        XCTAssert(counter == game.counter + 1)
        
    }
    
    func testShark() {
        ocean.lastshark = -6
        view.presentScene(ocean)
        ocean.didMove(to: view)
        let shark1 = ocean.summonShark()
        ocean.decrementCounter()
        ocean.decrementCounter()
        XCTAssert(ocean.lastshark == 2)
        ocean.lastshark = 51
        ocean.decrementCounter()
        XCTAssert(ocean.lastshark == 0)
        let shark2 = ocean.summonShark()
        XCTAssert(shark1.name == shark2.name)
    }
    
    func testStartGame() {
        let gscene = GoalScene()
        gscene.diff = "hard"
        view.presentScene(gscene)
        let game1 = gscene.playgame()
        let ocean = gscene.playoceangame()
        let deep = gscene.playdeepgame()
        game1.initScene()
        ocean.initScene()
        deep.initScene()
        XCTAssert(game1.difficulty == gscene.diff)
        XCTAssert(ocean.difficulty == gscene.diff)
        XCTAssert(deep.difficulty == gscene.diff)
    }
    
    func testCurrentChange() {
        view.presentScene(ocean)
        ocean.addCurrent()
        ocean.lastcurrentchange = -6
        ocean.removeCurrent()
        ocean.addCurrent()
        XCTAssert(ocean.lastcurrentchange == 0)
        ocean.lastcurrentchange = 51
        ocean.decrementCounter()
        XCTAssert(ocean.lastcurrentchange == 0)
    }
    
    func testSpeedLeavingCurrent() {
        view.presentScene(ocean)
        ocean.addCurrent()
        let fish1 = ocean.determineFish(number: 1, powerup: 10)
        
        fish1.position = ocean.seacurrent.position
        fish1.orientation = Int(ocean.seacurrent.xScale / abs(ocean.seacurrent.xScale))
        fish1.currenteffect = true
        var oldspeed = fish1.speed
        ocean.removeCurrent()
        XCTAssert(fish1.speed == oldspeed/2)
        
        ocean.addCurrent()
        fish1.position = ocean.seacurrent.position
        fish1.orientation = -Int(ocean.seacurrent.xScale / abs(ocean.seacurrent.xScale))
        fish1.currenteffect = true
        oldspeed = fish1.speed
        ocean.removeCurrent()
        XCTAssert(fish1.speed == oldspeed*2)
    }
    
    func testSpeedInCurrent() {
        view.presentScene(ocean)
        ocean.addCurrent()
        let fish1 = ocean.determineFish(number: 1, powerup: 10)
        
        fish1.position = ocean.seacurrent.position
        fish1.orientation = Int(ocean.seacurrent.xScale / abs(ocean.seacurrent.xScale))
        var oldspeed = fish1.speed
        fish1.currenteffect = false
        ocean.updateFishSpeedInCurrent(fish: fish1)
        XCTAssert(fish1.speed == oldspeed * 2)
        
        ocean.addCurrent()
        fish1.position = ocean.seacurrent.position
        fish1.orientation = -Int(ocean.seacurrent.xScale / abs(ocean.seacurrent.xScale))
        fish1.currenteffect = false
        oldspeed = fish1.speed
        ocean.updateFishSpeedInCurrent(fish: fish1)
        XCTAssert(fish1.speed == oldspeed / 2)
    }

    
    func testGameOver(){
        game.currscore = game.goalNum
        game.counter = 55
        game.update(1.0)
        game.health = 0
        game.update(1.0)
        XCTAssert(view.scene is GameOverScene)
    }
    
    func testLevelPassed(){
        game.currscore = game.goalNum
        game.counter = 0
        game.update(1.0)
        XCTAssert(view.scene is LevelScene)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
