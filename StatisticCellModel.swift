//
//  StatisticViewModel.swift
//  Exmo Console
//
//  Created by ooodin on 30/10/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation

public protocol StatisticCellModelProtocol {
    
    var price: Double { get }
    var high: Double{ get }
    var low:  Double{ get }
    
    var open:  Double { get }
    var close: Double { get }
    var vol:  Double{ get }
    
    var stockValues: [[String: Any]] { get }
    
}
