//
//  StatsViewController.swift
//  Exmo Console
//
//  Created by ooodin on 18/11/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class StatsController: UIViewController {
    
    var dataSource: StatisticCellModelProtocol?
    
    // MARK: Setup Views
    let chart: ChartView = {
        let chart = ChartView(frame: CGRect.zero)
        chart.translatesAutoresizingMaskIntoConstraints = false
        return chart
    }()
    
    let priceView     = PriceView()
    let switchView    = SwitchChart()
    let openCloseView = OpenCloseView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    func setupViews() {
        
        let hightPrice = Setting.hightPrice
        let hightStats = Setting.hightStats
        
        view.addSubview(priceView)
        view.addSubview(switchView)
        view.addSubview(chart)
        view.addSubview(openCloseView)
        
        priceView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        priceView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        priceView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.92).isActive = true
        priceView.heightAnchor.constraint(equalToConstant: hightPrice).isActive = true
        
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.topAnchor.constraint(equalTo: priceView.bottomAnchor).isActive = true
        switchView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        switchView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        switchView.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        openCloseView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        openCloseView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        openCloseView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        openCloseView.heightAnchor.constraint(equalToConstant: hightStats).isActive = true
        
        chart.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        chart.topAnchor.constraint(equalTo: switchView.bottomAnchor).isActive = true
        chart.bottomAnchor.constraint(equalTo: openCloseView.topAnchor).isActive = true
        chart.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1).isActive = true
        
    }
    
    func updateStatistic() {
        
        guard let statistic = dataSource as StatisticCellModelProtocol! else {
            return
        }
        
        priceView.setData(price: statistic.price,
                          low: statistic.low,
                          hight: statistic.high, animation: true)
        
        openCloseView.setData(open: statistic.open,
                              close: statistic.close,
                              vol: statistic.vol)
        
        chart.setData(stockValues: statistic.stockValues)
        
    }
    
}
