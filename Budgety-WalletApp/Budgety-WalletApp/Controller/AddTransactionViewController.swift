//
//  AddTransactionViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class AddTransactionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var addTransactionView: UIView!
    @IBOutlet var IncomeButton: UIButton!
    @IBOutlet var savingButton: UIButton!
    @IBOutlet var outcomeButton: UIButton!
    @IBOutlet var savingWalletView: UIView!
    @IBOutlet var WalletPickerLabel: UILabel!
    
    @IBOutlet var addTransactionButton: UIButton!
    @IBOutlet var pickerLaber: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var transactionDescreptionTextField: UITextField!
//    @IBOutlet var porpusePicker: UIPickerView!
    
    @IBOutlet var pickerTextField: UITextField!
    
    @IBOutlet var transactionAmountTextField: UITextField!
    let queue = OperationQueue()

    
    var purpose = ["Salary" , "Gift", "Qattah", "Stocks", "Trading"]
    let incomePurpose = ["Salary" , "Gift", "Qattah", "Stocks", "Trading"]
    let outcomePurpose = ["Grocery" , "Bills", "My Qattah", "Food"]

    var saving = ["New Macbook" , "New Range Rover"]
    
    var transactionType = "Income"
    
    var porpusePicker = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()

        addTransactionView.setCornerRadius()
        IncomeButton.setCornerRadius()
        savingButton.setCornerRadius()
        outcomeButton.setCornerRadius()
        addTransactionButton.setCornerRadius()
        
        datePicker.semanticContentAttribute = .forceRightToLeft
        datePicker.subviews.first?.semanticContentAttribute = .forceRightToLeft
//        porpusePicker.
        porpusePicker.dataSource = self
        porpusePicker.delegate = self
        
        
        pickerTextField.inputView = porpusePicker
        pickerTextField.textAlignment = .left
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        User.shared.userSavingWallet?.removeAll()
        
        queue.waitUntilAllOperationsAreFinished()

        
        

       
//        print("in saving vc : " ,User.shared.userSavingWallet)

       
        queue.addOperation {
            DatabaseHandler.shared.getSharedWallet { error in


            }
        }
        
        
        queue.addOperation {
            DatabaseHandler.shared.getAllSavingWallet(){ error in


                if error  == nil {

                }



            }
        }
        
        
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return purpose.count
    
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return purpose[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        pickerTextField.text = purpose[row]
        pickerTextField.resignFirstResponder()
        
    }
    
    
    @IBAction func incomeTransactionType(_ sender: Any) {
        
        IncomeButton.backgroundColor =  UIColor.appColor(.mainColor)
        IncomeButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        outcomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)

        savingButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
//        savingWalletView.isHidden = true
//        WalletPickerLabel.isHidden = true
        transactionType = "Income"
        purpose = incomePurpose
        pickerTextField.text = purpose[0]
        pickerLaber.text = "Purpose"
        pickerTextField.isEnabled = true
        addTransactionButton.isEnabled = true
    }
    
    
    @IBAction func savingTransactionType(_ sender: Any) {
        
        savingButton.backgroundColor =  UIColor.appColor(.mainColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        IncomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        IncomeButton.titleLabel!.textColor =  UIColor.appColor(.mainColor)
//        IncomeButton.titleLabel!.textColor = .gray

        outcomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        transactionType = "Saving"
        purpose = getWalletNames()
        pickerLaber.text = "Wallet"
        
        if purpose.count == 0 {
            
            addTransactionButton.isEnabled = false
            pickerTextField.text = "No Available Wallets"
            pickerTextField.isEnabled = false
        }else{
            pickerTextField.text = purpose[0]
            pickerTextField.isEnabled = true
            addTransactionButton.isEnabled = true
        }
      

        
        
//        savingWalletView.isHidden = false
//        WalletPickerLabel.isHidden = false

    }
    
    @IBAction func outcomeTransactionType(_ sender: Any) {

        outcomeButton.backgroundColor =  UIColor.appColor(.mainColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
       
        
        IncomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        IncomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)

        savingButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
        transactionType = "Outcome"
//        savingWalletView.isHidden = true
//        WalletPickerLabel.isHidden = true
        purpose = outcomePurpose
       
        pickerLaber.text = "Purpose"
        pickerTextField.text = purpose[0]
        pickerTextField.isEnabled = true
        addTransactionButton.isEnabled = true
    }
    
    

    
    @IBAction func addNewTransaction(_ sender: Any) {
        
        transactionDescreptionTextField.checkEmptyInput { emptyDescreptionResult in
            
            if emptyDescreptionResult {
                transactionDescreptionTextField.invalidInput()
                
            }else{
                transactionDescreptionTextField.validInput()

                transactionAmountTextField.checkEmptyInput { emptyResult in
                    
                    if emptyResult {
                        
                        transactionAmountTextField.invalidInput()
                        
                    }else{
                        
                        transactionAmountTextField.validInput()
                        
                        let purprose = "Salary"
                        let descreption = transactionDescreptionTextField.text!
                        let amount = transactionAmountTextField.text!
                        
                        let transation = Transaction(purpose: purprose, timeStamp: datePicker.date, transactionTypeString: transactionType, amount: Float(amount) ?? 0, description: descreption)
                        
                        
                        DatabaseHandler.shared.addNewTransaction(transaction: transation){ error in
                            
                            if error == nil {
                                self.dismiss(animated: true, completion: nil)
                                
                            }
                            
                            
                        }

                        
                    }
                    
                }
                
                
            }
            
            
            
            
        }
    
        
        
    
    }
    
    
    func getWalletNames() -> [String] {
        
        var names : [String] = []
        let temp = User.shared.userSavingWallet
        
        if temp?.count != 0 {
            
            temp?.forEach({ SavingWallet in
                
                names.append(SavingWallet.name)
                
            })
        }
        
        return names
        
    }
 
    
}
