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
    private  var balance : Float = 0
    
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
    
    var userBalance: Float {
           get {
               return balance
           }
           set (newBalance) {
               balance = newBalance
           }
       }
    
    
   }

        
    

