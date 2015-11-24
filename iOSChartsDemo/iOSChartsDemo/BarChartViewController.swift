//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//
//  Example following the example of this page: http://www.appcoda.com/ios-charts-api-tutorial/

import UIKit
import Charts

class BarChartViewController: UIViewController, ChartViewDelegate {

    @IBOutlet weak var barChartView: BarChartView!
    
    var months: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        barChartView.delegate = self
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        barChartView.descriptionText = ""
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        //barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .EaseInBounce)

        let ll = ChartLimitLine(limit: 10.0, label: "Target")
        barChartView.rightAxis.addLimitLine(ll)

    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "You need to provide data for the chart"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        
        chartDataSet.colors = ChartColorTemplates.colorful()
        
        barChartView.data = chartData
    }
    
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("\(entry.value) in \(months[entry.xIndex])")
    }

    @IBAction func saveChart(sender: UIBarButtonItem) {
        barChartView.saveToCameraRoll()
        //barChartView.saveToPath(path: String, format: ChartViewBase.ImageFormat, compressionQuality: Double)
    }

}

