//
//  Statistic.swift
//  Exmo Console
//
//  Created by Semavin Artem on 01/08/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class PriceView: BaseView{
    
    let hightScaleLine: CGFloat = Setting.hightScaleLine
    var priceTriagleLeftAnchorConstraint: NSLayoutConstraint?
    
    let priceTriangle: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "price_triangle")
        return imageView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Setting.fontPrice
        label.textColor = Setting.colorPriceLabel
        label.textAlignment = .center
        return label
    }()
    
    let lowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Setting.fontIndex
        label.textColor = Setting.colorLowHightLabel
        label.textAlignment = .left
        return label
    }()
    let hightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Setting.fontIndex
        label.textColor = Setting.colorLowHightLabel
        label.textAlignment = .right
        return label
    }()
    
    let scaleView: UIView = {
        let scale = UIView()
        scale.translatesAutoresizingMaskIntoConstraints = false
        return scale
    }()
    
    let scaleLineView: UIView = {
        let scale = UIView()
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.backgroundColor = Setting.colorScaleLine
        return scale
    }()
    
    let leftView: UIView = {
        let scale = UIView()
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.backgroundColor = Setting.colorScaleLine
        return scale
    }()
    let rightView: UIView = {
        let scale = UIView()
        scale.translatesAutoresizingMaskIntoConstraints = false
        scale.backgroundColor = Setting.colorScaleLine
        return scale
    }()
    
    override func setupViews() {
        
        backgroundColor = Setting.mainBackground
        
        addSubview(priceLabel)
        addSubview(lowLabel)
        addSubview(hightLabel)
        addSubview(scaleView)
        
        scaleView.addSubview(scaleLineView)
        scaleView.addSubview(leftView)
        scaleView.addSubview(rightView)
        scaleView.addSubview(priceTriangle)
        
        priceTriagleLeftAnchorConstraint = priceTriangle.leftAnchor.constraint(equalTo: scaleView.leftAnchor)
        priceTriagleLeftAnchorConstraint?.isActive = true
        
        priceTriangle.bottomAnchor.constraint(equalTo: scaleView.bottomAnchor).isActive = true
        priceTriangle.heightAnchor.constraint(equalTo: scaleView.heightAnchor, multiplier: 0.8).isActive = true
        priceTriangle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        scaleLineView.bottomAnchor.constraint(equalTo: scaleView.bottomAnchor).isActive = true
        scaleLineView.centerXAnchor.constraint(equalTo: scaleView.centerXAnchor).isActive = true
        scaleLineView.widthAnchor.constraint(equalTo: scaleView.widthAnchor, multiplier: 1).isActive = true
        scaleLineView.heightAnchor.constraint(equalToConstant: hightScaleLine).isActive = true
        
        leftView.leftAnchor.constraint(equalTo: scaleView.leftAnchor).isActive = true
        leftView.bottomAnchor.constraint(equalTo: scaleView.bottomAnchor).isActive = true
        leftView.heightAnchor.constraint(equalTo: scaleView.heightAnchor, multiplier: 0.5).isActive = true
        leftView.widthAnchor.constraint(equalToConstant: hightScaleLine).isActive = true
        
        rightView.rightAnchor.constraint(equalTo: scaleView.rightAnchor).isActive = true
        rightView.bottomAnchor.constraint(equalTo: scaleView.bottomAnchor).isActive = true
        rightView.heightAnchor.constraint(equalTo: scaleView.heightAnchor, multiplier: 0.5).isActive = true
        rightView.widthAnchor.constraint(equalToConstant: hightScaleLine).isActive = true
        
        priceLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        priceLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        
        scaleView.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20).isActive = true
        scaleView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        scaleView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        scaleView.heightAnchor.constraint(equalToConstant: hightScaleLine + 14).isActive = true
        
        lowLabel.topAnchor.constraint(equalTo: scaleView.bottomAnchor, constant: 3).isActive = true
        lowLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
       
        hightLabel.topAnchor.constraint(equalTo: scaleView.bottomAnchor, constant: 3).isActive = true
        hightLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

    }
        
    func setData(price: Double, low: Double, hight: Double, animation: Bool) {
        
        let priceString = "\(price)"
        
        priceLabel.fadeTransition(0.5)
        priceLabel.text = priceString
        
        let mutableString = NSMutableAttributedString(string: priceString, attributes: [NSFontAttributeName: Setting.fontPrice])
        
        let range: Range<String.Index> = priceString.range(of: ".")!
        let location: Int = priceString.characters.distance(from: priceString.startIndex, to: range.lowerBound)
        let length = priceString.characters.count - location
        
        mutableString.addAttribute(NSFontAttributeName, value: Setting.fontIndex, range: NSRange(location: location, length: length))
        priceLabel.attributedText = mutableString
        
        let width = Double(Setting.sizeWindow.width) * 0.92 - 20
        let constant = width / (hight - low) * (price - low)
        priceTriagleLeftAnchorConstraint?.constant = CGFloat(constant)
        
        if animation{
            UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 2, options: UIViewAnimationOptions(), animations: {
                self.layoutIfNeeded()
                }, completion: nil)
        }
        
        lowLabel.fadeTransition(0.5)
        lowLabel.text   = "L: \(low)"
        
        hightLabel.fadeTransition(0.5)
        hightLabel.text = "H: \(hight)"
        
    }
    
}





