//
//  BaseView.swift
//  Exmo Console
//
//  Created by Semavin Artem on 19/07/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit


class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    func setupViews() {
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class BaseCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        initialize()
        setData()
    }
    
    func setupViews() {
        
    }
    
    func initialize() {
        
    }
    
    func setData() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

