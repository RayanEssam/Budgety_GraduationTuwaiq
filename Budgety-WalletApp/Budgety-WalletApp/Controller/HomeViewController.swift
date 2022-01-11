//
//  HomeViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import UIKit

class HomeViewController: UIViewController , AddTransactionViewControllerDelegate  {
    func finishedPassingData(transactionsArray: [Transaction]) {
        
        
        transactionArray = transactionsArray
        tableView.reloadData()
    }
    

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

        tableView.separatorColor = .clear
        
        transationSummaryView.setCornerRadius()
        
        addTransactionFABButton.layer.cornerRadius = addTransactionFABButton.frame.width/2
        
        homeNavigationBar.shadowImage = UIImage()
        homeNavigationBar.backIndicatorImage = UIImage()
        print("Here!")
        
    }

    override func viewWillAppear(_ animated: Bool)  {
    print("AM GONNA APPEAR AGAIN !!!")
        
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


//                self.savingWallet = User.shared.userSavingWallet ?? []
//
//                self.tableView.reloadData()

                print("Gloabal : " , User.shared.userSavingWallet!)

            }
        }
        
        
        queue.addOperation {
            DatabaseHandler.shared.getAllSavingWallet(){ error in


                if error  == nil {


//                    self.savingWallet = User.shared.userSavingWallet ?? []
//                    self.tableView.reloadData()

                    print("Gloabal : " , User.shared.userSavingWallet!)

                }



            }
        }
        queue.addOperation{

            
            DatabaseHandler.shared.getUserWalletTransaction { error in
            if error  == nil {
                
                self.transactionArray?.removeAll()
                self.transactionArray = User.shared.userWallet?.transactions
                print(self.transactionArray?.count)
                self.transactionArray?.reverse()
                self.tableView.reloadData()

                if self.transactionArray?.count == 0 {
                    self.tableView.isHidden == true
                    self.noTransactionsImage.isHidden = false
                    
                }else{
                    self.tableView.isHidden == false
                    self.noTransactionsImage.isHidden = true
                }

            }else{

                print("error  all the transactions!")

            }
        }

    }
//
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

//        print("UnApproved : " , User.shared.unApprovedSharedSavingWallet?.count)
        
        
        
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
        }else{
            
            cell.amountLabel.textColor =  .darkGray
            
            cell.transactionTypeImage.image = UIImage(systemName: "bitcoinsign.circle")
            cell.transactionTypeImage.tintColor = .darkGray
            
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
extension UIBarButtonItem {
        
    convenience init(icon: UIImage, badge: String, _ badgeBackgroundColor: UIColor = #colorLiteral(red: 0.9156965613, green: 0.380413115, blue: 0.2803866267, alpha: 1), target: Any? = self, action: Selector? = nil) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        imageView.image = icon

        let label = UILabel(frame: CGRect(x: -8, y: -5, width: 18, height: 18))
        label.text = badge
        label.backgroundColor = badgeBackgroundColor
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.clipsToBounds = true
        label.layer.cornerRadius = 18 / 2
        label.textColor = .white

        let buttonView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        buttonView.addSubview(imageView)
        buttonView.addSubview(label)
        buttonView.addGestureRecognizer(UITapGestureRecognizer.init(target: target, action: action))
        self.init(customView: buttonView)
    }
    
}
