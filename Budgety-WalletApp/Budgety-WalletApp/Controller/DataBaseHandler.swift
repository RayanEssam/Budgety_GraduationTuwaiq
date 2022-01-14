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
                            User.shared.userWallet = Wallet(transactions: [], totalGain: 0, totalSpending: 0, Balance: 0, Saving: 0)
                            User.shared.userSavingWallet = []
                            User.shared.unApprovedSharedSavingWallet = [] 
                            // User.shared.userBalance = balance
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
            "TotalSaving" : 0,
        ]
        
        db.collection("Wallet").document(User.shared.userEmail).setData(newRawWallet) { error in
            if error == nil {
                User.shared.userWallet = Wallet(totalGain: 0, totalSpending: 0, Balance: 0, Saving: 0)
                print("adding new wallet")
                
            }
        }
        
    }
    
    
    func addNewTransaction(transaction : Transaction,savingDocumentIndex : Int , completion: @escaping( Error?) -> Void)  {
        
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
                    
                    switch transaction.transactionTypeString {
        
                    case "Income" :
                        self.updateIncomeTransaction(incomeAmount: transaction.amount)
                    case "Outcome" :
                        self.updateOutcomeTransaction(outcomeAmount: transaction.amount)
                    default :
                        // add in transactions and update wallet
                        print("ID :   \(User.shared.userSavingWallet![savingDocumentIndex].documentID)")
                        self.updateSavingTransaction(amount: transaction.amount)
                        self.updateSavingWallet(amount: transaction.amount, savingDocumentIndex: savingDocumentIndex)
                        
                    }
                    
                    
                    
                    completion(error)
                    
                    
                }else{
                    
                    print(error?.localizedDescription , "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                    
                }
                
            }
        
        
        
        
    }
    
    func updateSavingTransaction(amount : Float){
        
        db.collection("Wallet").document(User.shared.userEmail).updateData([

            "TotalSaving" : User.shared.userWallet!.Saving + amount ,
            "Balance" :  User.shared.userWallet!.Balance - amount


        ]) { error in

            if error == nil {

print("Errrr :(")

            }else{
                print( "Error saving ",error?.localizedDescription)
            }

        }
    }
    
    func updateIncomeTransaction(incomeAmount : Float){
        
                db.collection("Wallet").document(User.shared.userEmail).updateData([
        
                    "TotalGain" : User.shared.userWallet!.totalGain + incomeAmount ,
                    "Balance" : User.shared.userWallet!.Balance + incomeAmount
        
                ]) { error in
                    
                    if error == nil {
                        
                        User.shared.userWallet!.totalGain += incomeAmount
                        User.shared.userWallet!.Balance += incomeAmount
                    }
                    
                }
        
        
    }
    
    func updateOutcomeTransaction(outcomeAmount : Float){
        
                db.collection("Wallet").document(User.shared.userEmail).updateData([
        
                    "TotalSpending" : User.shared.userWallet!.totalSpending + outcomeAmount ,
                    "Balance" : User.shared.userWallet!.Balance - outcomeAmount
        
                ]) { error in
                    
                    if error == nil {
                        
                        User.shared.userWallet!.totalSpending += outcomeAmount
                        User.shared.userWallet!.Balance -= outcomeAmount
                    }
                    
                }
        
        
    }
    
    func updateSavingWallet(amount : Float , savingDocumentIndex : Int){
        
        print("")
        db.collection("SavingsWallet").document(User.shared.userSavingWallet![savingDocumentIndex].documentID).updateData([


            "currentAmount" : User.shared.userSavingWallet![savingDocumentIndex].currentAmount + amount

        ]) { error in
            if error == nil {
                
                User.shared.userSavingWallet![savingDocumentIndex].currentAmount += amount

            }
            
        }
        
        
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
                let saving = querySnapshot!.get("TotalSaving")!  as! Float
                User.shared.userWallet?.totalGain = totalGain
                User.shared.userWallet?.totalSpending = spending
                User.shared.userWallet?.Balance = balance
                User.shared.userWallet?.Saving = saving

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
    
    func addNewWallet(soloWallet : SavingWallet, uuid : String  , completion: @escaping( Error?) -> Void){
        
//        let uuid = UUID().uuidString
        db.collection("SavingsWallet").document(uuid).setData([
            
            
            "email" : User.shared.userEmail,
            "name" : soloWallet.name,
            "currentAmount" : 0,
            "target" : soloWallet.targetAmount,
            "emailList" : soloWallet.type == "Solo" ? [] : soloWallet.usersEmail ,
            "type" : soloWallet.type
            
        ]) { error in
            
            if error == nil {
                
                print("New solo added!")
                
                if soloWallet.type == "Shared" {
                    
                    soloWallet.usersEmail?.forEach({ email in
                        
                        self.db.collection("UserSahredWalletApprove").addDocument(data: [
                        
                            "walletName" : soloWallet.name,
                            "target" : soloWallet.targetAmount,
                            "approved" : false,
                            "from" : User.shared.userEmail,
                            "to" : email ,
                            "documentID" : uuid
                        ]){ error in
                            
                            if error == nil {
                                print("No error")
                                completion(error)
                            }
                            
                        }
                        
                    })
                    
                   
                    
                    
                }else{
                    completion(error)
                }
                
                
                
                
            }
            
            
        }
        
        
        
    }
    
    func getSharedWallet(completion: @escaping( Error?) -> Void){
        
        db.collection("UserSahredWalletApprove").whereField("to", isEqualTo: User.shared.userEmail).getDocuments { querySnapshot, error in
            
            
            if error == nil {
                print(User.shared.userEmail)
                print(querySnapshot?.documents.count)
                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                    
                    print(queryDocumentSnapshot.get("to"))
                    
                    let isApproved = queryDocumentSnapshot.get("approved") as! Bool
                    print("C : \(isApproved)")
                    if isApproved {
                        print(" Approved")
                        self.getSavingWalletByDocumentID(documentID: queryDocumentSnapshot.get("documentID") as! String){ WalletError in
                            
                            if WalletError == nil {
                                
                                completion(error)
                                
                            }
                            
                        }
                    }else{
                        
                    
                        
                    }
                    
                    
                })
                
            }
            
        }
        
        
    }
    
    func getUnApprovedSahredWallet(completion: @escaping( Error?) -> Void){
        
        db.collection("UserSahredWalletApprove").getDocuments { querySnapshot, error in
            
            if error == nil {
                
//                if querySnapshot?.documents.count != 0 {
                    querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                        
                        let isApproved = queryDocumentSnapshot.get("approved") as! Bool
                        var to = queryDocumentSnapshot.get("to") as! String
                        to = to.trimmingCharacters(in: .whitespaces)
                        let email = User.shared.userEmail.trimmingCharacters(in: .whitespaces)
                        print("to : " , to , " - " , email )
                        if isApproved == false && to == User.shared.userEmail {
                            
                            print("Not Approved")
                            let temp = SharedWallet(documentID: queryDocumentSnapshot.documentID, isApproved: isApproved, from: queryDocumentSnapshot.get("from") as! String, target: queryDocumentSnapshot.get("target") as! Float, walletName: queryDocumentSnapshot.get("walletName") as! String)
                            print("Temp : " , temp)
                            User.shared.unApprovedSharedSavingWallet?.append(SharedWallet(documentID: queryDocumentSnapshot.documentID, isApproved: isApproved, from: queryDocumentSnapshot.get("from") as! String, target: queryDocumentSnapshot.get("target") as! Float, walletName: queryDocumentSnapshot.get("walletName") as! String))
                        }
                      
                        
                                print("Check : " ,User.shared.unApprovedSharedSavingWallet )
                    })
                    
                    completion(error)
//                }else{
//                    completion(error)
//
//                }
                
                
            }else{
                
            }
            
           
            
            
            
            
        }
        
        
        
    }
    
    func getAllSavingWallet(completion: @escaping( Error?) -> Void) {
        
        
        db.collection("SavingsWallet").whereField("email", isEqualTo: User.shared.userEmail).getDocuments { querySnapshot, error in
            
            
            if error == nil {
                
                querySnapshot?.documents.forEach({ queryDocumentSnapshot in
                    
                 
                    let currentAmount = queryDocumentSnapshot.get("currentAmount") as! Float
                    let type =  queryDocumentSnapshot.get("type") as! String
                    let emailList : [String] = queryDocumentSnapshot.get("emailList") as! [String]
                    let name = queryDocumentSnapshot.get("name") as! String
                    let target = queryDocumentSnapshot.get("target") as! Float
                    
                    
                    let savingWallet = SavingWallet(name: name, targetAmount: target, currentAmount: currentAmount, type: type, usersEmail: emailList , documentID  : queryDocumentSnapshot.documentID)
  
                    User.shared.addNewSavingWallet(newSavingWallet: savingWallet)
                    
                    completion(error)
                    
                })
                
            }
            
            
            
        }
        
        
    }
    
    func getSavingWalletByDocumentID(documentID : String, completion: @escaping( Error?) -> Void){
        
        
        db.collection("SavingsWallet").document(documentID).getDocument { documentSnapshot, error in
            
            if error == nil {
                
                let currentAmount = documentSnapshot?.get("currentAmount") as! Float
                let type =  documentSnapshot?.get("type") as! String
                let emailList : [String] = documentSnapshot?.get("emailList") as! [String]
                let name = documentSnapshot?.get("name") as! String
                let target = documentSnapshot?.get("target") as! Float
                
                
                let savingWallet = SavingWallet(name: name, targetAmount: target, currentAmount: currentAmount, type: type, usersEmail: emailList , documentID : documentID)

                User.shared.addNewSavingWallet(newSavingWallet: savingWallet)
                
                completion(error)
                print("Sahred : " ,User.shared.userSavingWallet!)
            }
            
        }
        
        
    }
    
    func updateSavingWalletToApproved(documentID : String, completion: @escaping( Error?) -> Void) {
        
        
        db.collection("UserSahredWalletApprove").document(documentID).updateData([
            
            "approved" : true
        
        ]) { error in
            
            
            if error == nil {
                User.shared.unApprovedSharedSavingWallet?.removeAll(where: { SharedWallet in
                    
                    SharedWallet.documentID == documentID 
                    
                })
                
                completion(error)
                
            }
            
        }
        
        
        
        
    }







}
