//
//  CustomCell.swift
//  QuestEd
//
//  Created by Irene Qiao on 12/4/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import UIKit

class TitleCell: UITableViewCell {
    var opened: Bool
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        opened = false
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        opened = false
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    func initialize() {
        translatesAutoresizingMaskIntoConstraints = false
        self.accessoryType = .detailButton
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    //    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    //        doSomethingWithItem(indexPath.row)
    //    }
}
