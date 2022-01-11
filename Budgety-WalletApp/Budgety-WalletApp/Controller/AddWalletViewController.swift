//
//  AddWalletViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 09/01/2022.
//

import UIKit

class AddWalletViewController: UIViewController {
    
    @IBOutlet var addWalletView: UIView!
    @IBOutlet var soloWalletButton: UIButton!
    @IBOutlet var sharedWalletButton: UIButton!
    @IBOutlet var walletNameTextField: UITextField!
    @IBOutlet var walletTargetTextField: UITextField!
    @IBOutlet var sharedEmailWallet: UITextView!
    @IBOutlet var addWalletButton: UIButton!
    @IBOutlet var sharedEmailLabel: UILabel!
    var walletType = "Solo"
    var usersEmail : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        soloWalletButton.setCornerRadius()
        sharedWalletButton.setCornerRadius()
        addWalletView.setCornerRadius()
        addWalletButton.setCornerRadius()
    }
    
    @IBAction func soloActionButton(_ sender: Any) {
        soloWalletButton.backgroundColor =  UIColor.appColor(.mainColor)
        soloWalletButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        sharedWalletButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        sharedWalletButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        sharedEmailLabel.isHidden = true
        sharedEmailWallet.isHidden = true
        walletType = "Solo"
    }
    
    @IBAction func sharedActionButton(_ sender: Any) {
        sharedWalletButton.backgroundColor =  UIColor.appColor(.mainColor)
        sharedWalletButton.titleLabel?.textColor =  UIColor.appColor(.backgroundColor)
        
        soloWalletButton.backgroundColor =  UIColor.appColor(.backgroundColor)
        soloWalletButton.titleLabel?.textColor =  UIColor.appColor(.mainColor)
        sharedEmailLabel.isHidden = false
        sharedEmailWallet.isHidden = false
        walletType = "Shared"
    }
    
    
    @IBAction func addWalletButton(_ sender: Any) {
        
        
        
        walletNameTextField.checkEmptyInput(action: { resultEmpty in
            
            if resultEmpty {
                walletNameTextField.invalidInput()
                
            }else{
                
                walletNameTextField.validInput()
                walletTargetTextField.checkEmptyInput { emptyResult in
                    
                    if emptyResult{
                        walletTargetTextField.invalidInput()
                        
                    }else{
                        
                        walletTargetTextField.validInput()
                        print("Do it here!")
                        
                    
                        if walletType == "Shared" {
                            usersEmail = setEmailArray(text: sharedEmailWallet.text ?? "")
                            print(usersEmail)
                        }
                        
                        let uuid = UUID().uuidString
                        DatabaseHandler.shared.addNewWallet(soloWallet: SavingWallet(name: walletNameTextField.text!, targetAmount: Float(walletTargetTextField.text!)! , currentAmount: 0, type: walletType, usersEmail: usersEmail, documentID: uuid), uuid: uuid) { error in


                            if error == nil {
                                print("Done here!")
                            }

                        }
                        
                        
                        
                    }
                    
                    
                    
                }
                
            }
            
            
        })
    
    }
    
    
    func setEmailArray(text : String) -> [String] {
        
        let subStringArray = text.split(separator: ",")
        var stringArray : [String] = []
        
        subStringArray.forEach { substring in
            
            stringArray.append(String(substring))
            
        }

        return stringArray
                
    }
    
    
}
