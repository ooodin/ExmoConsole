//
//  MenuBar.swift
//  youtube
//
//  Created by Brian Voong on 6/6/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

class SwitchChart: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let mainBackground = Setting.colorBackBMenu
    var selectedItem = 0
    var titteCells = ["1D", "1W", "1M", "1Y"]
    var numberOfItems: Int = 4
    var heightLines: CGFloat = 1.3

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Setting.colorBackBMenu
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let cellId = "cellId"
    var mainController: MainController?
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = Setting.mainBackground
        
        collectionView.register(SwitchChartCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        let selectedIndexPath = IndexPath(item: selectedItem, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
        
        setupHorizontalBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHorizontalBar() {
        let horizontalBarView = UIView()
        horizontalBarView.backgroundColor = UIColor.white
        horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horizontalBarView)
        
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: self.leftAnchor)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        horizontalBarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1 / CGFloat(numberOfItems)).isActive = true
        horizontalBarView.heightAnchor.constraint(equalToConstant: heightLines).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         horizontalBarLeftAnchorConstraint?.constant = frame.width / CGFloat(numberOfItems) * CGFloat(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SwitchChartCell
        
        cell.tittleLable.text = titteCells[(indexPath as NSIndexPath).item].uppercased()
        cell.tittleLable.sizeToFit()
        cell.tintColor = mainBackground
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / CGFloat(numberOfItems), height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

class SwitchChartCell: BaseCell {
    
    let mainColor = UIColor.white
    let extraColor = Setting.colorFontBMenu2
    
    let tittleLable: UILabel = {
        let tittle = UILabel()
        tittle.font = Setting.fontTitleBar
        tittle.textColor = Setting.mainGrey
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








