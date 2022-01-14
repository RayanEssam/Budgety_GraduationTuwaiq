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
    @IBOutlet var savingWalletView: UIView!
    @IBOutlet var WalletPickerLabel: UILabel!
    @IBOutlet var addTransactionButton: UIButton!
    @IBOutlet var pickerLaber: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var transactionDescreptionTextField: UITextField!
    @IBOutlet var pickerTextField: UITextField!
    @IBOutlet var transactionAmountTextField: UITextField!
    
    var purpose = ["Salary" , "Gift", "Qattah", "Stocks", "Trading"]
    let incomePurpose = ["Salary" , "Gift", "Qattah", "Stocks", "Trading"]
    let outcomePurpose = ["Grocery" , "Bills", "My Qattah", "Food"]
    let queue = OperationQueue()
    var savingDocumentIndex = 0
    var transactionType = "Income"
    var porpusePicker = UIPickerView()
    var delegate : AddTransactionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()

        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        User.shared.userSavingWallet?.removeAll()
        
        queue.waitUntilAllOperationsAreFinished()
        
        queue.addOperation {
            DatabaseHandler.shared.getSharedWallet { error in
                
                self.savingDocumentIndex = 0
                
            }
        }
        
        queue.addOperation {
            DatabaseHandler.shared.getAllSavingWallet(){ error in
                
                if error  == nil {
                    
                    self.savingDocumentIndex = 0
                }
                
                
                
            }
        }
        
        
    }
    
    @IBAction func incomeTransactionType(_ sender: Any) {
        
        IncomeButton.backgroundColor =  UIColor.appColor(.mainColor)
        IncomeButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        outcomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
        savingButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
        
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
        
    }
    
    @IBAction func outcomeTransactionType(_ sender: Any) {
        
        outcomeButton.backgroundColor =  UIColor.appColor(.mainColor)
        outcomeButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        
        IncomeButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        IncomeButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
        savingButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        savingButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        
        transactionType = "Outcome"
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
                        
                        let purprose = pickerTextField.text!
                        let descreption = transactionDescreptionTextField.text!
                        let amount = transactionAmountTextField.text!
                        
                        let transation = Transaction(purpose: purprose, timeStamp: datePicker.date, transactionTypeString: transactionType, amount: Float(amount) ?? 0, description: descreption)
                        
                        DatabaseHandler.shared.addNewTransaction(transaction: transation, savingDocumentIndex: savingDocumentIndex){ error in
                            
                            if error == nil {
                                
                                switch self.transactionType {
                                case "Income":
                                    self.delegate?.finishedPassingData(transactionsArray: User.shared.userWallet!.transactions ,  newBalance: User.shared.userWallet!.Balance+Float(amount)!,
                                        income: User.shared.userWallet!.totalGain+Float(amount)!,
                                        saving: User.shared.userWallet!.Saving,
                                        outcome: User.shared.userWallet!.totalSpending)
                                case "Outcome":
                                    
                                        self.delegate?.finishedPassingData(transactionsArray: User.shared.userWallet!.transactions ,  newBalance: User.shared.userWallet!.Balance-Float(amount)!,
                                            income: User.shared.userWallet!.totalGain,
                                            saving: User.shared.userWallet!.Saving,
                                            outcome: User.shared.userWallet!.totalSpending+Float(amount)!)
                                default:
                                    self.delegate?.finishedPassingData(transactionsArray: User.shared.userWallet!.transactions ,  newBalance: User.shared.userWallet!.Balance-Float(amount)!,
                                        income: User.shared.userWallet!.totalGain,
                                        saving: User.shared.userWallet!.Saving+Float(amount)!,
                                        outcome: User.shared.userWallet!.totalSpending)
                                }
                                
                           
                                self.dismiss(animated: true, completion: nil)
                                
                            }
                            
                            
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                
                
            }
            
            
            
            
        }
        
        
        
        
    }
    
}

// SetUp UI elements (customaization) + Functionality 
extension AddTransactionViewController {
    
    func setUpUI(){
        
        addTransactionView.setCornerRadius()
        IncomeButton.setCornerRadius()
        savingButton.setCornerRadius()
        outcomeButton.setCornerRadius()
        addTransactionButton.setCornerRadius()
        
        datePicker.semanticContentAttribute = .forceRightToLeft
        datePicker.subviews.first?.semanticContentAttribute = .forceRightToLeft
        
        porpusePicker.dataSource = self
        porpusePicker.delegate = self
        
        
        pickerTextField.inputView = porpusePicker
        pickerTextField.textAlignment = .left
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


// Handle Purpose Picker
extension AddTransactionViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
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
        
        if transactionType == "Saving" {
            
            savingDocumentIndex = row
        }
        pickerTextField.resignFirstResponder()
        
    }
}
