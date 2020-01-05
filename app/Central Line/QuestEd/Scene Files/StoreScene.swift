//
//  StoreScene.swift
//  QuestEd
//
//  Created by Irene Qiao on 10/28/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import SpriteKit

class StoreScene: SKScene {
    
    var background: SKNode?
    var coinsCollected: SKLabelNode?
    var backButton: SKLabelNode?
    var errorPopup: SKNode?
    var confirmPurchasePopup: SKNode?
    
    var coinsTotal: Int?
    var myStoreItems: Array<String>?
    var storeItemsAvailable: Array<StoreItem>?
    var storeItemTableView: UITableView?
    
    var buyButtonPressed: Bool?
    var selectedItem: StoreItem?
    
    override func didMove(to view: SKView) {
        background = self.childNode(withName: "background")
        backButton = self.childNode(withName: "backButton") as? SKLabelNode
        errorPopup = self.childNode(withName: "error-popup")
        errorPopup?.isHidden = true
        
        coinsCollected = self.childNode(withName: "coins-collected") as? SKLabelNode
        
        let defaults = UserDefaults.standard
        //create key player_total_coins and player_powerups if not yet created
        
        if defaults.object(forKey: "player_total_coins") == nil {
            defaults.set(0, forKey: "player_total_coins")
        }
        coinsTotal = (defaults.value(forKey: "player_total_coins") as? Int)!

        if defaults.object(forKey: "player_powerups") == nil {
            defaults.set(Array<String>(), forKey: "player_powerups")
        }
        myStoreItems = defaults.value(forKey: "player_powerups") as? Array<String>
        
        if let myCoins = coinsTotal {
            self.coinsCollected?.text = "Coins: \(myCoins)"
        }
        
        setUpTableView()
    }
    
    func setUpTableView() {
        storeItemTableView = StoreItemTableView(parent: self)
        storeItemTableView!.dataSource = storeItemTableView as? UITableViewDataSource
        storeItemTableView!.delegate = storeItemTableView as? UITableViewDelegate
        storeItemTableView!.frame = CGRect(x:110,y:110,width:800,height:570)
        self.view?.addSubview(storeItemTableView!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            print(node)
            
            if node == backButton {
                storeItemTableView?.removeFromSuperview()
                let transition = SKTransition.fade(withDuration: 1)
                if let startScene = SKScene(fileNamed: "StartScene") {
                    startScene.scaleMode = .aspectFit
                    self.view?.presentScene(startScene, transition: transition)
                }
            }
        }
    
    func previouslyBought(item: StoreItem) -> Bool {
        return (myStoreItems?.contains(item.displayName!))!
    }
    
    func checkSufficientFunds(item: StoreItem) -> Bool{
        if coinsTotal! >= item.itemPrice! {
            return true
        }
        else {
            errorPopup?.isHidden = false
            return false
        }
    }
    
    func buyItem(item: StoreItem){
        if (!previouslyBought(item: item)) && (checkSufficientFunds(item: item)) {
            myStoreItems?.append(item.displayName!)
            coinsTotal = coinsTotal! - item.itemPrice!
            if let coinsLeft = coinsTotal {
                coinsCollected?.text = "Coins: \(coinsLeft)"
                }
            }
        }
        
        func update(_ currentTime: TimeInterval) {
            if buyButtonPressed! {
                buyItem(item: selectedItem!)
            }
        }
    }

}
