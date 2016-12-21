//
//  File.swift
//  Exmo Console
//
//  Created by ooodin on 27/10/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation

protocol StatisticModelProtocol {
    
    var buy_price: Double? { get }
    var sell_price: Double? { get }
    var last_trade: Double? { get }
    var avg: Double? { get }
    var vol_curr: Double? { get }
    var high: Double? { get }
    var low:  Double? { get }
    var vol:  Double? { get }
    
    var updated: Date? { get }
    
}

class Statistic: NSObject, StatisticModelProtocol{

    var buy_price: Double?
    var sell_price: Double?
    var last_trade: Double?
    var avg: Double?
    var vol_curr: Double?
    var updated: Date?
    var high: Double?
    var low:  Double?
    var vol:  Double?
    
    // MARK: StatisticModelProtocol

    init(fromJSON json: JSON) {
        
        buy_price  = json["buy_price"].doubleValue
        sell_price = json["sell_price"].doubleValue
        last_trade = json["last_trade"].doubleValue
        avg        = json["avg"].doubleValue
        vol_curr   = json["vol_curr"].doubleValue
        high       = json["high"].doubleValue
        low        = json["low"].doubleValue
        vol        = json["vol"].doubleValue
        
        updated    = json["updated"].dateTime
        
    }
    
}
