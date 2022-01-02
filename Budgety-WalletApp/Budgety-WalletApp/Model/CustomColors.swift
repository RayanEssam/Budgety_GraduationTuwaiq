//
//  CustomColors.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 02/01/2022.
//

import Foundation
import UIKit

enum AssetsColor {
   case mainColor
   case secondaryColor
case backgroundColor

}

extension UIColor {
    
    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .mainColor:
            return UIColor(named: "MainColor")
        case .secondaryColor:
            return UIColor(named: "")
        case .backgroundColor :
            return UIColor(named: "BackgroundColor")

        }
    }
    
}
