//
//  CurencyCell.swift
//  Exmo Console
//
//  Created by Semavin Artem on 25/07/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class CurrencyCell: BaseCell{
    
    var currencyName: String? {
        didSet {
            nameLabel.text = currencyName
            nameLabel.sizeToFit()
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = Setting.fontTitleBar
        return label
    }()
    
    override func setupViews() {
        addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    
    }
    
}
