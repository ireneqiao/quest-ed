//
//  StoreItemTableView.swift
//  QuestEd
//
//  Created by Irene Qiao on 12/1/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class StoreItemTableView: UITableView {
    var powerups: [StoreItem] = [InvincibilityPowerup(), MagnetPowerup(), ReflectPowerup(), LuckyPowerup()]
    var skins: [StoreItem] = [ColorfulPlayerItem()]
    
    var parentScene: StoreScene?
    var isOpen: Bool = false
    var indexOpen: IndexPath?
    
    init(parent: StoreScene) {
        self.parentScene = parent
        super.init(frame: CGRect(x:110,y:130,width:800,height:600), style: UITableView.Style.plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StoreItemTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            if isOpen && indexOpen!.section == 0 {
                return powerups.count + 1
            }
            else {
                return powerups.count
            }
        case 1:
            if isOpen && indexOpen!.section == 1 {
                return skins.count + 1
            }
            else {
                return skins.count
            }
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var itemIndex: Int
        if isOpen {
            if indexPath.row == (indexOpen!.row + 1) && indexPath.section == indexOpen!.section{
                let cellIdentifier = "DescripCell"
                var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? DescripCell
                if cell == nil {
                    cell = DescripCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier:    cellIdentifier)
                }
                switch indexPath.section {
                case 0:
                    cell?.textLabel?.text = powerups[indexOpen!.row].displayDescription
                case 1:
                    cell?.textLabel?.text = skins[indexOpen!.row].displayDescription
                default:
                    cell?.textLabel?.text = powerups[indexOpen!.row].displayDescription
                }
                cell?.textLabel?.font = UIFont.init(name: "Helvetica.tff", size: 18)
                let buyButton = UIImageView(image: UIImage(named: "buy"))
                buyButton.frame = CGRect(x: 0, y: 0, width: 65, height: 30)
                cell!.accessoryView = buyButton
                return cell!
            }
            else if indexPath.row > (indexOpen!.row + 1) {
                itemIndex = indexPath.row - 1
            }
            
            let cellIdentifier = "TitleCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TitleCell
            if cell == nil {
                cell = TitleCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
            }
            itemIndex = indexPath.row
            return cell!
        }
        else {
            let cellIdentifier = "TitleCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TitleCell
            if cell == nil {
                cell = TitleCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: cellIdentifier)
            }
            switch indexPath.section {
            case 0:
                cell?.textLabel?.text = powerups[indexPath.row].displayName
                cell?.imageView?.image = UIImage(named: powerups[indexPath.row].image!)
                cell?.imageView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            case 1:
                cell?.textLabel?.text = skins[indexPath.row].displayName
                cell?.imageView?.image = UIImage(named: skins[indexPath.row].image!)
                cell?.imageView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            default:
                cell?.textLabel?.text = powerups[indexPath.row].displayName
                cell?.imageView?.image = UIImage(named: powerups[indexPath.row].image!)
                cell?.imageView?.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            }
            //price label formatting
            let price: Int = powerups[indexPath.row].itemPrice!
            cell?.detailTextLabel?.text = "\(price) Coins"
            cell?.detailTextLabel?.font = UIFont(name: "Helvetica.tff", size: 18)
            let priceImageView = UIImageView(image: UIImage(named: "coin1"))
            priceImageView.frame = CGRect(x: 15, y: 0, width: 30, height: 30)
            cell?.accessoryView = priceImageView
            cell?.textLabel?.font = UIFont.init(name: "Helvetica.tff", size: 22)
            return cell!
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

extension StoreItemTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //set cell height
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = cellForRow(at: indexPath) as? TitleCell {
            if isOpen {
                isOpen = false
                reloadData()
            }
            else {
                isOpen = true
                indexOpen = indexPath
                reloadData()
            }
        }
        
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("attempt to buy item")
        parentScene?.buyButtonPressed = true
        switch indexPath.section {
            case 0:
                parentScene?.selectedItem = powerups[indexOpen!.row]
            case 1:
                parentScene?.selectedItem = skins[indexOpen!.row]
            default:
                parentScene?.selectedItem = powerups[indexOpen!.row]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            "sectionHeader") as? HeaderView
        if header == nil {
            header = HeaderView(reuseIdentifier: "sectionHeader")
        }
        switch (section) {
        case 0:
            header?.textLabel?.text = "Powerups";
        case 1:
            header?.textLabel?.text = "Skins";
        default:
            header?.textLabel?.text = "Other"
        }
        header?.textLabel?.textColor = UIColor.white
        header?.textLabel?.font = UIFont.init(name: "Helvetica.tff", size: 20)
        return header
    }
    
}
