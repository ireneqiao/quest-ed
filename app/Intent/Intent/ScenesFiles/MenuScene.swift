//
//  MenuScene.swift
//  Intent
//
//  Created by Paulina Asturias on 10/2/19.
//  Copyright © 2019 Paulina Asturias. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene: SKScene {
    let background = SKSpriteNode(imageNamed: "Background")
    
    override func didMove(to view: SKView){
        background.size = CGSize(width: frame.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.midX, y: frame.midY )
        addChild(background)
        addLabels()
    }
    func addLabels(){
        let playLabel = SKLabelNode(text: "Play")
        playLabel.fontName = "Helvetica-Bold"
        playLabel.fontSize = 80.0
        playLabel.fontColor = UIColor.yellow
        playLabel.name = "playLabel"
        playLabel.position = CGPoint(x: frame.midX, y: frame.midY+100)
        addChild(playLabel)
       animate(label: playLabel)
        
        //scores for easy
        let easy = SKLabelNode(text: "Easy Mode")
        easy.fontName = "Helvetica-Bold"
        easy.fontSize = 30.0
        easy.fontColor = UIColor.yellow
        easy.position = CGPoint(x: frame.midX-300, y: frame.midY - 75)
        addChild(easy)
        
        let easyhighscore = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "Easy_Highscore"))")
        easyhighscore.fontName = "Helvetica"
        easyhighscore.fontSize = 20.0
        easyhighscore.fontColor = UIColor.white
        easyhighscore.position = CGPoint(x: frame.midX-300, y: frame.midY - 125)
        addChild(easyhighscore)
        
        let easyrecentscore = SKLabelNode(text: "Recent score: " + "\(UserDefaults.standard.integer(forKey: "Easy_Recentscore"))")
        easyrecentscore.fontName = "Helvetica"
        easyrecentscore.fontSize = 20.0
        easyrecentscore.fontColor = UIColor.white
        easyrecentscore.position = CGPoint(x: frame.midX-300, y: frame.midY - 175)
        addChild(easyrecentscore)
        
        //scores for medium
        let med = SKLabelNode(text: "Medium Mode")
        med.fontName = "Helvetica-Bold"
        med.fontSize = 30.0
        med.fontColor = UIColor.yellow
        med.position = CGPoint(x: frame.midX-100, y: frame.midY - 75)
        addChild(med)
        
        let medhighscore = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "Med_Highscore"))")
        medhighscore.fontName = "Helvetica"
        medhighscore.fontSize = 20.0
        medhighscore.fontColor = UIColor.white
        medhighscore.position = CGPoint(x: frame.midX-100, y: frame.midY - 125)
        addChild(medhighscore)
        
        let medrecentscore = SKLabelNode(text: "Recent score: " + "\(UserDefaults.standard.integer(forKey: "Med_Recentscore"))")
        medrecentscore.fontName = "Helvetica"
        medrecentscore.fontSize = 20.0
        medrecentscore.fontColor = UIColor.white
        medrecentscore.position = CGPoint(x: frame.midX-100, y: frame.midY - 175)
        addChild(medrecentscore)
        
        //scores for hard
        let hard = SKLabelNode(text: "Hard Mode")
            hard.fontName = "Helvetica-Bold"
            hard.fontSize = 30.0
            hard.fontColor = UIColor.yellow
            hard.position = CGPoint(x: frame.midX+100, y: frame.midY - 75)
            addChild(hard)
 
            let hardhighscore = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "Hard_Highscore"))")
            hardhighscore.fontName = "Helvetica"
            hardhighscore.fontSize = 20.0
            hardhighscore.fontColor = UIColor.white
            hardhighscore.position = CGPoint(x: frame.midX+100, y: frame.midY - 125)
            addChild(hardhighscore)

            let hardrecentscore = SKLabelNode(text: "Recent score: " + "\(UserDefaults.standard.integer(forKey: "Hard_Recentscore"))")
            hardrecentscore.fontName = "Helvetica"
            hardrecentscore.fontSize = 20.0
            hardrecentscore.fontColor = UIColor.white
            hardrecentscore.position = CGPoint(x: frame.midX+100, y: frame.midY - 175)
            addChild(hardrecentscore)
  
        //scores for expert
        let expert = SKLabelNode(text: "Expert Mode")
        expert.fontName = "Helvetica-Bold"
        expert.fontSize = 30.0
        expert.fontColor = UIColor.yellow
        expert.position = CGPoint(x: frame.midX+300, y: frame.midY - 75)
        addChild(expert)
 
        let experthighscore = SKLabelNode(text: "High Score: " + "\(UserDefaults.standard.integer(forKey: "Expert_Highscore"))")
        experthighscore.fontName = "Helvetica"
        experthighscore.fontSize = 20.0
        experthighscore.fontColor = UIColor.white
        experthighscore.position = CGPoint(x: frame.midX+300, y: frame.midY - 125)
        addChild(experthighscore)

        let expertrecentscore = SKLabelNode(text: "Recent score: " + "\(UserDefaults.standard.integer(forKey: "Expert_Recentscore"))")
        expertrecentscore.fontName = "Helvetica"
        expertrecentscore.fontSize = 20.0
        expertrecentscore.fontColor = UIColor.white
        expertrecentscore.position = CGPoint(x: frame.midX+300, y: frame.midY - 175)
        addChild(expertrecentscore)

    }
    
    func animate(label: SKLabelNode){
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        
        let sequence = SKAction.sequence([scaleUp, scaleDown])
               label.run(SKAction.repeatForever(sequence))
    }
 
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch == touches.first {
        
        enumerateChildNodes(withName: "//*", using: { (node, stop) in
            if node.name == "playLabel" {
                if node.contains(touch.location(in: self)){
                    if let view = self.view {
                       let scene = InstructionsScene(size: view.bounds.size)
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
    }
}
