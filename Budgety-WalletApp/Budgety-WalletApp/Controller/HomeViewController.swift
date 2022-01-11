//
//  HomeViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var addTransactionFABButton: UIButton!
    @IBOutlet var homeNavigationBar: UINavigationBar!
    @IBOutlet var transationSummaryView: UIView!
    @IBOutlet var tableView: UITableView!

    @IBOutlet var totalIncomeLabel: UILabel!
    
    @IBOutlet var totalOutcomeLabel: UILabel!
    @IBOutlet var currentBalanceLabel: UILabel!
    
    
    var transactionArray : [Transaction]? = nil
    
    
    let queue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorColor = .clear
        
        transationSummaryView.setCornerRadius()
        
        addTransactionFABButton.layer.cornerRadius = addTransactionFABButton.frame.width/2
        
        homeNavigationBar.shadowImage = UIImage()
        homeNavigationBar.backIndicatorImage = UIImage()
        print("Here!")
        
    }

    override func viewWillAppear(_ animated: Bool)  {
    
        User.shared.userWallet?.transactions.removeAll()
        
        queue.waitUntilAllOperationsAreFinished()

        queue.addOperation{

            DatabaseHandler.shared.getUserWalletTransaction { error in
            if error  == nil {
                
                self.transactionArray?.removeAll()
                self.transactionArray = User.shared.userWallet?.transactions
                print(self.transactionArray?.count)
                self.transactionArray?.reverse()
                self.tableView.reloadData()

                print("got all the transactions!")

            }else{

                print("error  all the transactions!")

            }
        }

    }
//
        queue.addOperation {

            DatabaseHandler.shared.getUserWallet { error in

                if error == nil {
                    print("Gain : " , User.shared.userWallet!.totalGain)
                    self.totalIncomeLabel.text =  "\(User.shared.userWallet!.totalGain)"
                    self.totalOutcomeLabel.text = "\(User.shared.userWallet!.totalSpending)"
                    self.currentBalanceLabel.text = "\(User.shared.userWallet!.Balance)"
                }



            }
        }

//        print("UnApproved : " , User.shared.unApprovedSharedSavingWallet?.count)
        
        
    }


}

extension UINavigationController {
    func hideHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = true
        }
    }
    func restoreHairline() {
        if let hairline = findHairlineImageViewUnder(navigationBar) {
            hairline.isHidden = false
        }
    }
    func findHairlineImageViewUnder(_ view: UIView) -> UIImageView? {
        if view is UIImageView && view.bounds.size.height <= 1.0 {
            return view as? UIImageView
        }
        for subview in view.subviews {
            if let imageView = self.findHairlineImageViewUnder(subview) {
                return imageView
            }
        }
        return nil
    }
}

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
        }
        
        
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Header"
//    }
    
    
    
}
