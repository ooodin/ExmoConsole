//
//  mainController.swift
//  Exmo Console
//
//  Created by Semavin Artem on 03/08/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class MainController: UICollectionViewController{
    
    let cellId = "cellId"
    
    let statsController = StatsController()
    
    
    
    let selectedItem = 1
    let hightMenuBar: CGFloat = 30
    
    fileprivate var isFirstTimeViewDidLayoutSubviews = true
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.mainController = self
        return mb
    }()
    
    lazy fileprivate var curencyMenuLauncher: CurencyMenuLauncher = {
        let launcher = CurencyMenuLauncher()
        launcher.chartController = self
        launcher.active = false
        return launcher
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "None"
        titleLabel.textColor = UIColor.white
        titleLabel.font = Setting.fontTitleBar
        titleLabel.sizeToFit()
        titleLabel.isUserInteractionEnabled = true
        
        return titleLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCurrency))
        titleLabel.addGestureRecognizer(tap)
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    // MARK: Setup views
    
    fileprivate func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        let selectedIndexPath = IndexPath(item: selectedItem, section: 0)
        collectionView?.selectItem(at: selectedIndexPath, animated: false, scrollPosition: UICollectionViewScrollPosition())
    
        collectionView?.backgroundColor = Setting.mainBackground
        collectionView?.register(MainCell.self, forCellWithReuseIdentifier: cellId)

        collectionView?.isPagingEnabled = true
        
    }
    
    fileprivate func setupNavBarButtons() {
        
        let settingsImage = UIImage(named: "settings")?.withRenderingMode(.alwaysOriginal)
        let settingsButton = UIBarButtonItem(image: settingsImage, style: .plain, target: self, action: #selector(handleSettings))
        
        navigationItem.rightBarButtonItem = settingsButton
        
    }
    
    fileprivate func setupMenuBar() {
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(\(hightMenuBar))]", views: menuBar)
        
        menuBar.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
    }
    
    // MARK: Menu action
    
    func handleSettings(){
        print("get Setting!")
    }
    
    func handleCurrency(){
        
        curencyMenuLauncher.active = !curencyMenuLauncher.active
        
        if curencyMenuLauncher.active{
            curencyMenuLauncher.handleDismiss(currency: nil)
        }else{
            curencyMenuLauncher.showCurencies()
        }
        
    }
    
    func setCurrency(currency: Currency) {
        titleLabel.text = "\(currency.currencyName) ▾"
        titleLabel.sizeToFit()
        curencyMenuLauncher.active = false
    }
    
}

extension MainController{
    
    override func viewDidLayoutSubviews() {
        if (self.isFirstTimeViewDidLayoutSubviews) {
            let width = view.frame.width
            collectionView?.contentInset = UIEdgeInsetsMake(-hightMenuBar, 0, 0, 0)
            collectionView?.setContentOffset(CGPoint(x: CGFloat(selectedItem) * width, y: 0), animated: false)
            self.isFirstTimeViewDidLayoutSubviews = false
        }
    }
    
    func scrollToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 3
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        if (indexPath as NSIndexPath).item == 1 {
            addChildViewController(child: statsController, superView: cell)
        } else if (indexPath as NSIndexPath).item == 2 {
            //wallet controller
        } else {
            //orders controller
        }
        
        return cell
    }
    
}

extension MainController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - hightMenuBar)
    }
    
}





