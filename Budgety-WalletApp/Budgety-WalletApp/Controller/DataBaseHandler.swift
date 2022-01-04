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
                                                    "balance": 0 as! Float
                                      
                                                       
                                                   ])
                               { error in
                                       if error == nil {
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
                                  let balance = querySnapshot?.documents[0].get("balance")! as! Float
                                  
                                  
                                  User.shared.userName = name
                                  User.shared.userEmail = email
                                  User.shared.userPhone = phone
                                  User.shared.userBalance = balance
                                  
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
    
    
    
//    func add(<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
    
    
    
    
}
