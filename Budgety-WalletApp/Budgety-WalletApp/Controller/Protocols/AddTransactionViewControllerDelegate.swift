//
//  AddTransactionViewControllerDelegate.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 11/01/2022.
//

import Foundation
import UIKit


protocol AddTransactionViewControllerDelegate {
    func finishedPassingData(transactionsArray : [Transaction])
}
