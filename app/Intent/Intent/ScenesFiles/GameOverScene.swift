//
//  levelScene.swift
//  Intent
//
//  Created by Paulina Asturias on 10/27/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
class GameOverScene: SKScene {
    let background = SKSpriteNode(imageNamed: "Background")
    var score = 0
    var game = GameScene()
    var playagain: SKLabelNode!
    
    override func didMove(to view: SKView){
       background.texture = game.background.texture
       background.size = game.background.size
       background.position = CGPoint(x: frame.midX, y: frame.midY )
       addChild(background)
        
        labelPlayAgain()
        gameoverLabel()
    }
    
    func gameoverLabel(){
        let lost = SKLabelNode(text: "Game Over. Your score was \(score)")
        lost.fontName = "Helvetica-Bold"
        lost.fontSize = 50.0
        lost.fontColor = UIColor.white
        lost.name = "play"
        lost.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(lost)
    }
    
    func labelPlayAgain(){
        playagain = SKLabelNode(text: "Play Again")
        playagain.fontName = "Helvetica-Bold"
        playagain.fontSize = 50.0
        playagain.fontColor = UIColor.white
        playagain.name = "playagain"
        playagain.zPosition = 1
        playagain.horizontalAlignmentMode = .right
        playagain.position = CGPoint(x:self.size.width-60, y:frame.midY*1.8)
        addChild(playagain)
    }
    
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    for touch in touches {
        //if touch == touches.first {
        let tap = touch.location(in: self)
        enumerateChildNodes(withName: "//*", using: { (node, stop) in
                if node.contains(tap){
                    if node.name == "playagain" {
                        
                        if let view = self.view {
                            let scene = GoalScene(size: view.bounds.size)
                            scene.scaleMode = .aspectFill
                            view.presentScene(scene)
                            view.ignoresSiblingOrder = false
                            view.showsFPS = false
                            view.showsNodeCount = false
                        }
                    }
                }
            }
        )}
    }
    init(size: CGSize, lastgame: GameScene) {
           super.init(size: size)
           game = lastgame
            // stage = game.level
      }
       
       required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
}
