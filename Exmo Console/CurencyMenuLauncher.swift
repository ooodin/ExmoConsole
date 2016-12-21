//
//  CurencyMenuLauncher.swift
//  Exmo Console
//
//  Created by Semavin Artem on 25/07/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class CurencyMenuLauncher: NSObject {
    
    var active: Bool = false
    let currencies: [Currency] = Ticker.instance.currencies
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = Setting.mainBackground
        
        return cv
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    let y: CGFloat = -1
    
    var chartController: MainController?
    
    func showCurencies() {
        
        let width = (chartController?.view.frame.width)!
        let height: CGFloat = min(CGFloat(currencies.count) * cellHeight, (chartController?.view.frame.height)!)
        
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateDismiss)))
        blackView.frame = (chartController?.view.frame)!
        
        blackView.alpha = 0
        
        collectionView.frame = CGRect(x: 0, y: y, width: width, height: 0)
        
        chartController?.view.addSubview(blackView)
        chartController?.view.addSubview(collectionView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
            self.blackView.alpha = 1
            self.collectionView.frame = CGRect(x: 0, y: self.y, width: width, height: height)
            
            }, completion: nil)
    }
    
    func handleDismiss(currency: Currency?) {
        
        if let currency = currency as Currency!{
            self.chartController?.setCurrency(currency: currency)
        }
        
        animateDismiss()
    }
    
    func animateDismiss() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.collectionView.frame = CGRect(x: 0, y: self.y, width: self.collectionView.frame.width, height: 0)
            
        }) { (completed: Bool) in
            self.blackView.removeFromSuperview()
            self.collectionView.removeFromSuperview()
        }
    }
    
    func deleteSubviews() {
        self.blackView.removeFromSuperview()
        self.collectionView.removeFromSuperview()
    }
    
    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CurrencyCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

extension CurencyMenuLauncher: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CurrencyCell
        cell.currencyName = currencies[(indexPath as NSIndexPath).row].currencyName
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currency = self.currencies[(indexPath as NSIndexPath).item]
        handleDismiss(currency: currency)
    }
}









