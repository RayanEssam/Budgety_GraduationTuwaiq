//
//  HomeViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class HomeViewController: UIViewController{

    

    @IBOutlet var addTransactionFABButton: UIButton!
    @IBOutlet var homeNavigationBar: UINavigationBar!
    @IBOutlet var transationSummaryView: UIView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var totalIncomeLabel: UILabel!
    @IBOutlet var totalOutcomeLabel: UILabel!
    @IBOutlet var currentBalanceLabel: UILabel!
    @IBOutlet var bellButton: UIBarButtonItem!
    @IBOutlet var totalSaving: UILabel!
    @IBOutlet var noTransactionsImage: UIImageView!
    
    
    var transactionArray : [Transaction]? = nil
    let queue = OperationQueue()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }

    override func viewWillAppear(_ animated: Bool)  {

        
        User.shared.userWallet?.transactions.removeAll()
        User.shared.userSavingWallet?.removeAll()

        queue.waitUntilAllOperationsAreFinished()        
        
        
        queue.addOperation {
            DatabaseHandler.shared.getUnApprovedSahredWallet { error in
                if error == nil {
                    
                }
            }
        }
        
        queue.addOperation {
            DatabaseHandler.shared.getSharedWallet { error in

            }
        }
     
        queue.addOperation {
            DatabaseHandler.shared.getAllSavingWallet(){ error in


                if error  == nil {
                    print("Gloabal : " , User.shared.userSavingWallet!)

                }



            }
        }
     
        queue.addOperation{

        
        DatabaseHandler.shared.getUserWalletTransaction { error in
        if error  == nil {
            
            self.transactionArray?.removeAll()
            self.transactionArray = User.shared.userWallet?.transactions

            self.transactionArray?.reverse()
            self.tableView.reloadData()

            if self.transactionArray?.count == 0 {
                self.tableView.isHidden = true
                self.noTransactionsImage.isHidden = false
                
            }else{
                self.tableView.isHidden = false
                self.noTransactionsImage.isHidden = true
            }

        }else{

            print("error  all the transactions!")

        }
    }

    }
       
        queue.addOperation {

            DatabaseHandler.shared.getUserWallet { error in

                if error == nil {
                    print("3")
                    self.totalIncomeLabel.text =  "\(User.shared.userWallet!.totalGain)"
                    self.totalOutcomeLabel.text = "\(User.shared.userWallet!.totalSpending)"
                    self.currentBalanceLabel.text = "\(User.shared.userWallet!.Balance)"
                    self.totalSaving.text = "\(User.shared.userWallet!.Saving)"
                }



            }
        }

        
        
        
    }

    @IBAction func addTransactionButtonSegue(_ sender: Any) {
        
        performSegue(withIdentifier: "VCinitialToFinal", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddTransactionViewController {
            destination.delegate = self
        }
    }
    
    
}

// SetUp UI elements (customaization)
extension HomeViewController {
    
    func setUpUI(){
        
        tableView.separatorColor = .clear
        transationSummaryView.setCornerRadius()
        
        addTransactionFABButton.layer.cornerRadius = addTransactionFABButton.frame.width/2
        
        homeNavigationBar.shadowImage = UIImage()
        homeNavigationBar.backIndicatorImage = UIImage()
        
    }
    
}

// Handle table view
extension HomeViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionArray?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell") as! TransactionTableViewCell
        
        cell.setCornerRadius()
        cell.amountLabel.text = String( transactionArray![indexPath.row].amount)
        cell.transactionLabel.text = String( transactionArray![indexPath.row].description)
        cell.transactionDate.text = "\(transactionArray![indexPath.row].timeStamp)"
        
        if transactionArray![indexPath.row].transactionTypeString == "Income"{
            
            cell.amountLabel.textColor =  UIColor.appColor(.mainColor)
            
            cell.transactionTypeImage.image = UIImage(systemName: "chevron.up")
            cell.transactionTypeImage.tintColor = UIColor.appColor(.mainColor)
        } else if transactionArray![indexPath.row].transactionTypeString == "Outcome"{
            
            cell.amountLabel.textColor =  UIColor(named: "RedMainColor")
            
            cell.transactionTypeImage.image = UIImage(systemName: "chevron.down")
            cell.transactionTypeImage.tintColor = UIColor(named: "RedMainColor")
        }else{
            
            cell.amountLabel.textColor =  .darkGray
            
            cell.transactionTypeImage.image = UIImage(systemName: "bitcoinsign.circle")
            cell.transactionTypeImage.tintColor = .darkGray
            
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}


// Handle Custome Delegate protocol.
extension HomeViewController : AddTransactionViewControllerDelegate {
    func finishedPassingData(transactionsArray: [Transaction], newBalance: Float, income: Float, saving: Float, outcome: Float) {
        transactionArray = transactionsArray
        currentBalanceLabel.text = "\(newBalance)"
        totalIncomeLabel.text = "\(income)"
        totalSaving.text = "\(saving)"
        totalOutcomeLabel.text = "\(outcome)"
        
        tableView.reloadData()
    }
    
    
   
}
