//
//  ChartView.swift
//  Exmo Console
//
//  Created by Semavin Artem on 24/08/2016.
//  Copyright © 2016 Semavin Artem. All rights reserved.
//

import UIKit

class ChartView: Chart {
    
    var labelLeadingMarginInitialConstant: CGFloat = 30
    var labelLeadingMarginConstraint = NSLayoutConstraint()
    var labelChart = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        
        self.backgroundColor = Setting.mainBackground
        self.labelColor = Setting.colorChartText
        self.highlightLineColor = Setting.colorChartLightLine
        
        self.lineWidth = Setting.hightScaleLine
        self.labelFont = Setting.fontTitleIndex
        self.xLabelsTextAlignment = .center
        self.yLabelsOnRightSide = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(stockValues: [[String: Any]]) {
        
        // Initialize data series and labels
        var serieData: [Float] = []
        var labels: [Float] = []
        var labelsAsString: [String] = []
        
        
        // Date formatter to retrieve the month names
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        

        for (i, value) in stockValues.enumerated() {
            
            serieData.append(value["close"] as! Float)
            
            // Use only one label for each month
            let month = Int(dateFormatter.string(from: value["date"] as! Date))!
            let monthAsString:String = dateFormatter.monthSymbols[month - 1].uppercased()
            
            if (labels.count == 0 || labelsAsString.last != monthAsString) {
                labels.append(Float(i))
                labelsAsString.append(monthAsString)
            }
        }
        
        let series = ChartSeries(serieData)
        series.area = true
        series.color = Setting.mainGreen
        
        // Configure chart layout
        self.xLabels = labels
        self.xLabelsFormatter = { (labelIndex: Int, labelValue: Float) -> String in
            return labelsAsString[labelIndex]
        }
        
        // Add some padding above the x-axis
        self.minY = serieData.min()! - 5
        self.addSeries(series)
        
    }
    
}

extension ChartView: ChartDelegate{
    
    // Chart delegate
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Float, left: CGFloat) {
        
        if let value = chart.valueForSeries(0, atIndex: indexes[0]) {
            
            let numberFormatter = NumberFormatter()
            numberFormatter.minimumFractionDigits = 2
            numberFormatter.maximumFractionDigits = 2
            labelChart.text = numberFormatter.string(from: NSNumber(value: value))
            
            // Align the label to the touch left position, centered
            var constant = labelLeadingMarginInitialConstant + left - (labelChart.frame.width / 2)
            
            // Avoid placing the label on the left of the chart
            if constant < labelLeadingMarginInitialConstant {
                constant = labelLeadingMarginInitialConstant
            }
            
            // Avoid placing the label on the right of the chart
            let rightMargin = chart.frame.width - labelChart.frame.width
            if constant > rightMargin {
                constant = rightMargin
            }
            
            labelLeadingMarginConstraint.constant = constant
            
        }
        
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        labelChart.text = ""
        labelLeadingMarginConstraint.constant = labelLeadingMarginInitialConstant
    }
    
}
