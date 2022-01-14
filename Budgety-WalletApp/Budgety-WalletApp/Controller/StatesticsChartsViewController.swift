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
    @IBOutlet var tableView: UITableView!
    
    let tipsString : [String] = ["If you’re looking for a place to trade your stocks, check out TradeStation its a great place for trading stocks!" ,
    "Get a credit card that gives you a cash back! it helps in the long term!",
    "Avoid the Non-Essentials such as buying coffee every morning,instad you should do it", "Cancel unused memberships, you will be suprised how much it will saves you", "It's not wrong to buy on sell items!"
    
    ]
    
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


extension StatesticsChartsViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tipsString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatesticsTableViewCell") as! StatesticsTableViewCell
        
        cell.tipTextContent.text = tipsString[indexPath.row]
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
}
