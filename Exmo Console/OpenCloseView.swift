//
//  OpenCloseView.swift
//  Exmo Console
//
//  Created by Semavin Artem on 25/10/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class OpenCloseView: BaseView {
    
    let openView = IndexView(title: "open", separator: true)
    let closeView = IndexView(title: "close", separator: true)
    let volView = IndexView(title: "vol.", separator: false)
    
    override func setupViews() {
        
        backgroundColor = Setting.statsBackground
        
        addSubview(openView)
        addSubview(closeView)
        addSubview(volView)
        
        openView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        closeView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        volView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        addConstraintsWithFormat("H:|[v0(v2)][v1(v2)][v2]|", views: openView, closeView, volView)
        
    }
    
    func setData(open: Double, close: Double, vol: Double){
        
        openView.setData(index: open)
        closeView.setData(index: close)
        volView.setData(index: vol)
        
    }
    
}
