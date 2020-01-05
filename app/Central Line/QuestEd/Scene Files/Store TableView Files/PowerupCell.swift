//
//  PowerupCell.swift
//  QuestEd
//
//  Created by Irene Qiao on 12/2/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import UIKit

class PowerupCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
        self.accessoryType = .detailDisclosureButton
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    func initialize() {
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    //        doSomethingWithItem(indexPath.row)
    //    }
}
