//
//  DescripCell.swift
//  QuestEd
//
//  Created by Irene Qiao on 12/4/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import UIKit

class DescripCell: UITableViewCell {
    var opened: Bool
    var buyButton: UIImageView?
    var color: UIColor?
    
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
        color = UIColor(hue: 0.55, saturation: 0.23, brightness: 1, alpha: 1.0) /* #c4edff */
        self.tintColor = color
        translatesAutoresizingMaskIntoConstraints = false
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
