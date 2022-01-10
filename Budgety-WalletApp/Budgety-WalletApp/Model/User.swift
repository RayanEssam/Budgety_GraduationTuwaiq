//
//  User.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 04/01/2022.
//

import Foundation

class User {
    
    static var shared = User()
    
    private var name : String = ""
    private var email : String = ""
    private var phone : String = ""
    private var wallet : Wallet? = nil
    private var savingWallet : [SavingWallet]? = nil
    
    
    
    private init(){
        
    }
    
    
    var userName: String {
           get {
               return name
           }
           set (newName) {
               name = newName
           }
       }
    
    var userEmail: String {
           get {
               return email
           }
           set (newEmail) {
               email = newEmail
           }
       }
    
    var userPhone: String {
           get {
               return phone
           }
           set (newPhone) {
               phone = newPhone
           }
       }
    
    var userWallet : Wallet?{
        
        get {
            return wallet
        }
        set (newWallet) {
            wallet = newWallet
        }
    }
    
    
    var userSavingWallet : [SavingWallet]?{
        
        get {
            return savingWallet
        }
        
        set (newSavingWallet) {
            savingWallet = newSavingWallet
        }
    }
    
    
    func addNewSavingWallet(newSavingWallet : SavingWallet)  {
        
        
        savingWallet?.append(newSavingWallet)
        
    }
    
    
    
   }

        
    

