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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addTransactionView.layer.cornerRadius = 15
        IncomeButton.layer.cornerRadius = 15
        savingButton.layer.cornerRadius = 15
        outcomeButton.layer.cornerRadius = 15
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
