//
//  Settings.swift
//  Exmo Console
//
//  Created by Semavin Artem on 05/08/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

struct Setting {
    
    //Colors
    static let mainGreen = UIColor.colorFromHex(0x21CB97)
    static let mainBackground = UIColor.colorFromHex(0x1E2C37)
    
    static let statsBackground = UIColor.colorFromHex(0x17242C)
    
    static let mainGrey = UIColor.colorFromHex(0x58626C)
    static let barColor = UIColor.black
    
    //Chart 
    static let colorChartText = mainGrey
    static let colorChartLightLine = mainGreen
    
    //Global
    static let sizeWindow = UIScreen.main.bounds
    static let fontIndex = UIFont.systemFont(ofSize: 16)
    static let fontTitleIndex = UIFont.systemFont(ofSize: 10)
    static let fontTitleBar   = UIFont.systemFont(ofSize: 18)
    
    static let hightScaleLine: CGFloat = 1.3
    
    //Bottom menu
    static let fontBMenu = UIFont.systemFont(ofSize: 10)
    static let colorFontBMenu1 = mainGreen
    static let colorFontBMenu2 = mainGrey
    static let colorBackBMenu  = mainBackground
    
    //Price
    static let fontPrice = UIFont.systemFont(ofSize: 45, weight: UIFontWeightThin)
    static let colorScaleLine: UIColor = mainGrey
    
    static let colorPriceLabel = UIColor.white
    static let colorLowHightLabel = mainGrey
    
    //Buy Sell buttons
    static let hightPrice: CGFloat = 160
    static let hightStats: CGFloat = 80
    
}

struct Constants {
    
    static let baseURL = "https://api.exmo.com/v1"
    
}

