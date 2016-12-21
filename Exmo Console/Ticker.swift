//
//  Ticker.swift
//  Exmo Console
//
//  Created by Semavin Artem on 19/10/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation

class Ticker: NSObject {
    
    static let instance = Ticker() // singleton
    
    var currencies = [Currency]()
    var statistics = [Currency: Statistic]()
    
    func update(json: JSON){
        
        for (key, subJson):(String, JSON) in json {
            
            let newCurrency = Currency(parameter: key)
            
            guard subJson.dictionary != nil else {
                return
            }
            
            let newStatistic = Statistic(fromJSON: subJson)
            
            self.currencies.append(newCurrency)
            self.statistics[newCurrency] = newStatistic
            
        }
    }
}

