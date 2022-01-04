//
//  Transaction.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 04/01/2022.
//

import Foundation

class Transaction {
    
    static var sharedTransaction = Transaction()
    
    private var  purpose : String = ""
    private var timeStamp : Date  = Date()
    private var transactionType : TransactionType  = TransactionType.Income
    private var amount  : Float = 0
    private var Description : String = ""

    
    private init (){
        
    }
    
}
