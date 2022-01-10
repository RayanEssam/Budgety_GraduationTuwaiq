//
//  DataBaseHandler.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 03/01/2022.
//

import Foundation
import FirebaseAuth
import Firebase
class DatabaseHandler {
    
    let db = Firestore.firestore()
    // Singletone
    static var shared: DatabaseHandler = {
        let instance = DatabaseHandler()
        
        return instance
    }()
    
    private init() {}
    
    
    // signUp new user function
    func createNewUser(email : String , passwoord : String, name : String, phonNumber : String) {
        
        Auth.auth().createUser(withEmail: email, password: passwoord) { result, error in
            
            if error == nil {
                
                print("Successful SignUp")
                self.db.collection("Users")
                    .addDocument(data:
                                    [
                                        "name" : "\(name)",
                                        "phone": "\(phonNumber)",
                                        "email": "\(email)",
                                    ])
                { error in
                    if error == nil {
                        User.shared.userEmail = email
                        self.createUserWallet()
                        
                        print("New document has been created...")
                    } else {
                        print("error\(error!.localizedDescription)")
                    }
                    
                }
                
                
            }else{
                
                print(error?.localizedDescription)
                
            }
            
        }
        
    }
    
    
    func logIn(email : String , password : String, completion: @escaping( Error?) -> Void)  {
        
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            
            if error == nil {
                
                self.db.collection("Users").whereField("email", isEqualTo: email)
                
                    .getDocuments { querySnapshot, error in
                        
                        if error == nil {
                            
                            let name = querySnapshot?.documents[0].get("name")! as! String
                            let email = querySnapshot?.documents[0].get("email")! as! String
                            let phone = querySnapshot?.documents[0].get("phone")! as! String
                            //                                  let balance = querySnapshot?.documents[0].get("balance")! as! Float
                            
                            
                            User.shared.userName = name
                            User.shared.userEmail = email
                            User.shared.userPhone = phone
                            User.shared.userWallet = Wallet(transactions: [], totalGain: 0, totalSpending: 0, Balance: 0)
                            User.shared.userSavingWallet = []
                            //                                  User.shared.userBalance = balance
                            completion(error)
                            
                        } else {
                            print(error!.localizedDescription)
                        }
                    }
                
            } else {
                print(error!.localizedDescription)
            }
            
        }
    }
    
    
    func createUserWallet() {
        
        let newRawWallet : [String : Any] = [
            "Balance" : 0,
            "TotalGain" : 0 ,
            "TotalSpending" : 0,
        ]
        
        db.collection("Wallet").document(User.shared.userEmail).setData(newRawWallet) { error in
            if error == nil {
                User.shared.userWallet = Wallet(totalGain: 0, totalSpending: 0, Balance: 0)
                print("adding new wallet")
                
            }
        }
        
    }
    
    
    func addNewTransaction(transaction : Transaction, completion: @escaping( Error?) -> Void)  {
        
        //        let transaction = Transaction(purpose: "test", timeStamp: Date(), transactionTypeString: TransactionType.Income.rawValue, amount: 29, description: "Nothing")
        
        let tarnsactionDictionary : [String : Any] =  [
            
            "Purpose" : transaction.purpose,
            "TimeStamp" : transaction.timeStamp,
            "TransactionTypeS" : transaction.transactionTypeString,
            "Amount" : transaction.amount,
            "Description" : transaction.description
        ]
        
        
        
        db.collection("Wallet").document(User.shared.userEmail).collection("Transaction")
            .addDocument(data: tarnsactionDictionary) { error in
                
                if error == nil {
                    User.shared.userWallet?.transactions.append(transaction)
                    print("New Transaction is added")
                    
                    self.updateIncomeTransaction(incomeAmount: transaction.amount)
                    
                    completion(error)
                    
                    
                }else{
                    
                    print(error?.localizedDescription , "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                    
                }
                
            }
        
        
        
        
    }
    
    func updateIncomeTransaction(incomeAmount : Float){
        
        //        db.collection("Wallet").document(User.shared.userEmail).updateData([
        //
        //            "TotalGain" : incomeAmount ,
        //            "Balance" : incomeAmount+User.shared.userBalance ?? 0
        //
        //        ]) { error in-
        //            if error == nil {
        //                print("Update success")
        //
        //            }
        //        }
        
        
    }
    
    func getUserWallet( completion: @escaping( Error?) -> Void) {
        
        
        
        db.collection("Wallet").document(User.shared.userEmail).getDocument(completion: { querySnapshot, error in
            
            
            if error == nil {
                
                let totalGain = querySnapshot!.get("TotalGain")! as! Float
                print("Gain " , totalGain)
                let spending = querySnapshot!.get("TotalSpending")!  as! Float
                print("Spend  : ", spending )
                let balance = querySnapshot!.get("Balance")!  as! Float
                print("Balance  : ", balance )
                
                User.shared.userWallet?.totalGain = totalGain
                User.shared.userWallet?.totalSpending = spending
                User.shared.userWallet?.Balance = balance
                //                    User.shared.userWallet = Wallet(totalGain: Float(totalGain), totalSpending: Float(spending), Balance: balance)
                
                
                completion(error)
                print("Hello")
                
            }else{
                print("Big problem")
            }
            
            
        })
        
        
        
        
        
        
        
    }
    
    
    func getUserWalletTransaction(completion: @escaping( Error?) -> Void) {
        
        
        db.collection("Wallet").document(User.shared.userEmail).collection("Transaction").order(by: "TimeStamp").getDocuments {querySnapshot, error in
            
            
            var transactionArray : [Transaction] = []
            
            
            if error == nil {
                
                querySnapshot!.documents.forEach { queryDocumentSnapshot in
                    
                    let amount =  queryDocumentSnapshot.get("Amount")! as! Float
                    let description = queryDocumentSnapshot.get("Description")! as! String
                    let purpose = queryDocumentSnapshot.get("Purpose")! as! String
                    let timeStamp = queryDocumentSnapshot.get("TimeStamp")!
                    let date = (timeStamp as AnyObject).dateValue()
                    let transactionType = queryDocumentSnapshot.get("TransactionTypeS")! as! String
                    
                    let tempTransaction = Transaction(purpose: purpose, timeStamp: date, transactionTypeString: transactionType, amount: amount, description: description)
                    print(User.shared.userWallet?.transactions)
                    
                    User.shared.userWallet?.transactions.append(tempTransaction)
                    
                    
                    
                    print(amount)
                    completion(error)
                    
                    
                }
                
            }
            
            
            
        }
        
    }
    
    
    
    func addNewSoloWallet(soloWallet : SavingWallet , completion: @escaping( Error?) -> Void){
        
        
        db.collection("SavingsWallet").addDocument(data: [
            
            
            "email" : User.shared.userEmail,
            "name" : soloWallet.name,
            "amount" : soloWallet.targetAmount,
            "currentAmount" : 0,
            "target" : soloWallet.targetAmount,
            "emailList" : soloWallet.usersEmail,
            "type" : soloWallet.type
            
        ]) { error in
            
            if error == nil {
                
                print("New solo added!")
                completion(error)
                
            }
            
            
        }
        
        
        
    }
    
    func addNewSharedWallet(completion: @escaping( Error?) -> Void){
        
    }
    
    
    
    
    func getAllSavingWallet() {
        
        
        db.collection("SavingsWallet").whereField("email", isEqualTo: User.shared.userEmail).getDocuments { querySnapshot, error in
            
            
            if error == nil {
                
                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                    
                    
                    print(queryDocumentSnapshot.get("amount"))
                    print(queryDocumentSnapshot.get("currentAmount"))
                    print(queryDocumentSnapshot.get("type") ?? "solo")

                })
                
            }
            
            
            
        }
        
        
    }
    
}
