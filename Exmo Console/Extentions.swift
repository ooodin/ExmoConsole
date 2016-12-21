//
//  Extentions.swift
//  Exmo Console
//
//  Created by Semavin Artem on 19/07/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

//MARK: Double

public extension Double {
    /// SwiftRandom extension
    public static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

//MARK: UIView

extension UIView {
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        self.layer.add(animation, forKey: kCATransitionFade)
    }
}

extension UIView{
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictinary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictinary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictinary))
    }
}

//MARK: UIImage

extension UIImage {
    // create image of solid color
    class func imageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        color.setFill()
        ctx?.fill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//MARK: UILabel

class BottomAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        if let stringText = text {
            let stringTextAsNSString = stringText as NSString
            let labelStringSize = stringTextAsNSString.boundingRect(with: CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude),
                                                                            options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                            attributes: [NSFontAttributeName: font],
                                                                            context: nil).size
            super.drawText(in: CGRect(x: 0, y: self.frame.height - labelStringSize.height, width: self.frame.width, height: ceil(labelStringSize.height)))
        } else {
            super.drawText(in: rect)
        }
    }
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}


//MARK: UIColor

extension UIColor {
    
    // Convert a hex string to a UIColor object.
    class func colorFromHex(_ hex: Int) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    class func colorFromHex(_ hex: Int, alpha: CGFloat) -> UIColor {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1).withAlphaComponent(alpha)
    }
}


//MARK: UIViewController

extension UIViewController {
    
    func addChildViewController(child:UIViewController, superView: UIView) {
        
        child.willMove(toParentViewController: self)
        addChildViewController(child)
        
        child.beginAppearanceTransition(true, animated: true)
        superView.addSubview(child.view)
        
        child.endAppearanceTransition()
        child.view.translatesAutoresizingMaskIntoConstraints = false
        
        let viewsDictionary : [String : UIView] = ["child":child.view]
        let child_constraint_H:Array = NSLayoutConstraint.constraints(withVisualFormat: "H:|[child]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        let child_constraint_V:Array = NSLayoutConstraint.constraints(withVisualFormat: "V:|[child]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewsDictionary)
        
        superView.addConstraints(child_constraint_H)
        superView.addConstraints(child_constraint_V)
        
        child.didMove(toParentViewController: self)
        
    }
    
    func removeChildViewController(child:UIViewController) {
        
        child.willMove(toParentViewController: nil)
        child.beginAppearanceTransition(false, animated: true)
        child.view.removeFromSuperview()
        child.endAppearanceTransition()
        child.removeFromParentViewController()
        child.didMove(toParentViewController: nil)
    }
}

//MARK: UIViewController

extension JSON {
    
    public var date: Date? {
        get {
            switch self.type {
            case .number:
                let date = NSDate(timeIntervalSince1970: self.object as! TimeInterval) as Date?
                return date
            case .string:
                return Formatter.jsonDateFormatter.date(from: self.object as! String)
            default:
                return nil
            }
        }
    }
    
    public var dateTime: Date? {
        get {
            switch self.type {
            case .number:
                let date = NSDate(timeIntervalSince1970: self.object as! TimeInterval) as Date?
                return date
            case .string:
                return Formatter.jsonDateTimeFormatter.date(from: self.object as! String)
            default:
                return nil
            }
        }
    }
    
}

