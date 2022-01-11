//
//  UIColorExtension.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 06/01/2022.
//

import Foundation
import UIKit

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .mainColor:
            return UIColor(named: "MainColor")
        case .redMainColor:
            return UIColor(named: "RedMainColor")
        case .backgroundColor :
            return UIColor(named: "BackgroundColor")

        }
    }
    
}
