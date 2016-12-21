//
//  StatisticManager.swift
//  Exmo Console
//
//  Created by ooodin on 30/10/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import Foundation

public typealias TaskClosure = (_ completion: @escaping () -> Void) -> Void

public protocol StatisticDelegateProtocol {
    
//    static var instance: Self { get }
    
    var active: Bool { set get }
    var currency: CurrencyProtocol { get }
    var typeChart: String { get }
    
    func startUpdate(_ task: @escaping TaskClosure)
    func stopUpdate()
    
    func getStatistic() -> StatisticCellModelProtocol?
    
}
