//
//  DemoData.swift
//  Exmo Console
//
//  Created by Semavin Artem on 04/08/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

//class DemoStatsData: StatsSourceData {
//    
//    var period: String = ""
//    var chartData: Array<Dictionary<String, Any>> = []
//    
//    init() {
//       self.chartData = getStockValues()
//    }
//    
//    func getStockValues() -> Array<Dictionary<String, Any>> {
//        
//        // Read the JSON file
//        let filePath = Bundle.main.path(forResource: "AAPL", ofType: "json")!
//        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath))
//        let json: NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData!, options: [])) as! NSDictionary
//        let jsonValues = json["quotes"] as! Array<NSDictionary>
//        
//        // Parse data
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        let values = jsonValues.map { (value: NSDictionary) -> Dictionary<String, Any> in
//            let date = dateFormatter.date(from: value["date"]! as! String)
//            let close = (value["close"]! as! NSNumber).floatValue
//            return ["date": date!, "close": close]
//        }
//        
//        return values
//        
//    }
//    
//}


//        setData(590.0212923, low: 570.0212923, hight: 770.0212923, animation: false)
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)

//    var timer: Timer?
//    func updateData(){
//        let low = Double.random(570.0212923, 530.0212923)
//        let hight = Double.random(770.0212923, 670.0212923)
//        let price = Double.random(low, hight)
//        setData(price, low: low, hight: hight, animation: true)
//    }
