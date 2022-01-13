//
//  StatesticsChartsViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 12/01/2022.
//

import UIKit
import Charts

class StatesticsChartsViewController: UIViewController {

    @IBOutlet var globalChartCard: UIView!
    @IBOutlet var pieView: PieChartView!
    @IBOutlet var statesticsNavigationBar: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        globalChartCard.setCornerRadius()
        statesticsNavigationBar.shadowImage = UIImage()
        statesticsNavigationBar.backIndicatorImage = UIImage()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setUpPieChart()
        
    }
    

    func setUpPieChart(){
        
        pieView.chartDescription?.enabled = false
        pieView.drawHoleEnabled = true
        pieView.rotationAngle = 0
        pieView.rotationEnabled = false
        pieView.isUserInteractionEnabled = false
        
        
        var totalTransacions = User.shared.userWallet?.totalGain ?? 0
        totalTransacions += User.shared.userWallet?.totalSpending ?? 0
        totalTransacions += User.shared.userWallet?.Saving ?? 0
        
        print(totalTransacions)
        
        let incomePercentage = ( User.shared.userWallet!.totalGain  / totalTransacions) * 100
        let outcomePercentage = ( User.shared.userWallet!.totalSpending  / totalTransacions) * 100
        let savingPercentage = ( User.shared.userWallet!.Saving  / totalTransacions) * 100
        
        print( "Percentage \(incomePercentage)" )
        
        var entries : [PieChartDataEntry] = Array()
        
        entries.append(PieChartDataEntry(value: Double(incomePercentage), label: "%Income"))
        entries.append(PieChartDataEntry(value: Double(savingPercentage), label: "%saving"))
        entries.append(PieChartDataEntry(value: Double(outcomePercentage) , label: "%Outcome"))

        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        let c1 = NSUIColor(hex: 0x4c8d6e)
        let c2 = NSUIColor(hex: 0x050911)
        let c3 = NSUIColor(hex: 0x8e0001)

        dataSet.colors = [c1,c2,c3]
        
        dataSet.drawValuesEnabled = true
        pieView.data = PieChartData(dataSet: dataSet)
        
    }



}
