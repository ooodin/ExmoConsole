//
//  MenuCell.swift
//  Exmo Console
//
//  Created by ooodin on 18/11/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class MenuCell: BaseCell {
    
    let mainColor = Setting.colorFontBMenu1
    let extraColor = Setting.colorFontBMenu2
    
    let tittleLable: UILabel = {
        let tittle = UILabel()
        tittle.font = Setting.fontBMenu
        tittle.textColor = Setting.colorFontBMenu2
        tittle.textAlignment = .center
        return tittle
    }()
    
    override var isHighlighted: Bool {
        didSet {
            tittleLable.textColor = extraColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            tittleLable.textColor = isSelected ? mainColor : extraColor
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(tittleLable)
        
        addConstraintsWithFormat("H:[v0(60)]", views: tittleLable)
        addConstraintsWithFormat("V:[v0(25)]", views: tittleLable)
        
        addConstraint(NSLayoutConstraint(item: tittleLable, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        addConstraint(NSLayoutConstraint(item: tittleLable, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0.0))
        
    }
}
