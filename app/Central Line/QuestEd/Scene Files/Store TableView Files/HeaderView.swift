//
//  HeaderView.swift
//  QuestEd
//
//  Created by Irene Qiao on 12/2/19.
//  Copyright © 2019 QuestED Team. All rights reserved.
//

import Foundation
import UIKit

class HeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        let title = UILabel()
        title.font = UIFont(name: "Helvetica.tff", size: 22)
        contentView.addSubview(title)
        contentView.backgroundColor = UIColor(hue: 0.5417, saturation: 1, brightness: 1, alpha: 1.0) /* #00bfff */

    }
}
