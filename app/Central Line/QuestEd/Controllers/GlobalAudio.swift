//
//  GlobalAudio.swift
//  QuestEd
//
//  Created by student on 9/27/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import GameplayKit
import SpriteKit
import AVFoundation

extension GameScene {
    func initAudio() {
        let bgm = GKRandomSource.sharedRandom().nextInt(upperBound: 10)
        var bgmName: String
        var bgmExtension = "mp3"
        switch bgm {
        case 0:
            bgmName = "flashfrost"
        case 1:
            bgmName = "trigger"
        case 2:
            bgmName = "cydral"
        case 3:
            bgmName = "noath"
        default :
            bgmName = "valerie"; bgmExtension = "aac"
        }
        
        if let url = Bundle.main.url(forResource: bgmName, withExtension: bgmExtension) {
            self.addChild(SKAudioNode(url: url))
        }
    }
}
