//
//  File.swift
//  Exmo Console
//
//  Created by ooodin on 27/10/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation

public protocol CurrencyProtocol {
    var currencyName: String { get }
    var currencyParameter: String { get }
}

class Currency: NSObject, CurrencyProtocol {
    var currencyName: String
    var currencyParameter: String
    
    init(parameter: String) {
        self.currencyParameter = parameter
        self.currencyName = parameter.replacingOccurrences(of: "_", with: "/")
    }
}
