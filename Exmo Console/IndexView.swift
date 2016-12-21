//
//  IndexView.swift
//  Exmo Console
//
//  Created by Semavin Artem on 14/08/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class IndexView: BaseView{
    
    var separator = false
    
    let separatorView: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = Setting.colorChartLightLine
        return separator
    }()
    
    let indexLabel: UILabel = {
        let index = UILabel()
        index.translatesAutoresizingMaskIntoConstraints = false
        index.textAlignment = .center
        index.font = Setting.fontIndex
        index.textColor = UIColor.white
        index.text = "0000000000"
        index.sizeToFit()
        return index
    }()

    let tittlelabel: UILabel = {
        let tittle = UILabel()
        tittle.translatesAutoresizingMaskIntoConstraints = false
        tittle.textColor = Setting.colorChartText
        tittle.textAlignment = .center
        tittle.font = Setting.fontTitleIndex
        tittle.sizeToFit()
        return tittle
    }()
    
    init(title: String, separator: Bool) {
        self.separator = separator
        
        tittlelabel.text = title.uppercased()
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        addSubview(indexLabel)
        addSubview(tittlelabel)
        
        indexLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indexLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -6).isActive = true
        indexLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        tittlelabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tittlelabel.topAnchor.constraint(equalTo: indexLabel.bottomAnchor).isActive = true
        tittlelabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        if separator{
            addSubview(separatorView)
            
            separatorView.topAnchor.constraint(equalTo: indexLabel.topAnchor).isActive = true
            separatorView.bottomAnchor.constraint(equalTo: tittlelabel.bottomAnchor).isActive = true
            
            separatorView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            separatorView.widthAnchor.constraint(equalToConstant: 1.5).isActive = true
        }
    
    }
    
    func setData(index: Double) {
        indexLabel.text = "\(index)"
    }
}
