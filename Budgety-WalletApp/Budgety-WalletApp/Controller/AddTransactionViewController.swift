//
//  AddTransactionViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class AddTransactionViewController: UIViewController {

    @IBOutlet var addTransactionView: UIView!
    
    @IBOutlet var IncomeButton: UIButton!
    @IBOutlet var savingButton: UIButton!
    @IBOutlet var outcomeButton: UIButton!
    
    var transactionType = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTransactionView.layer.cornerRadius = 15
        IncomeButton.layer.cornerRadius = 15
        savingButton.layer.cornerRadius = 15
        outcomeButton.layer.cornerRadius = 15
    }
    
    @IBAction func incomeTransactionType(_ sender: Any) {
        
        IncomeButton.backgroundColor =  UIColor.appColor(.mainColor)
        IncomeButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        outcomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
        savingButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
    }
    
    
    @IBAction func savingTransactionType(_ sender: Any) {
        
        savingButton.backgroundColor =  UIColor.appColor(.mainColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        IncomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        IncomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
            

        outcomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
    }
    
    @IBAction func outcomeTransactionType(_ sender: Any) {

        outcomeButton.backgroundColor =  UIColor.appColor(.mainColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
       

        
        IncomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        IncomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)

        savingButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
    }
    
    

    
    @IBAction func addNewTransaction(_ sender: Any) {
   
        DatabaseHandler.shared.addNewTransaction()
    
    }
    
 
    
}
