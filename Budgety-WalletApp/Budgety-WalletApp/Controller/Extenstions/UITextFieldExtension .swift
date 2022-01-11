//
//  UITextFieldExtension .swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 02/01/2022.
//

import Foundation
import UIKit

extension UITextField {
    
    // Add icons for textfields
    func setPaddingWithImage(image: UIImage){
        let height = self.frame.height
        let imageView = UIImageView(image: image)
        imageView.tintColor = UIColor.appColor(.mainColor)
        imageView.contentMode = .scaleAspectFit
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: height))
        imageView.frame = CGRect(x: 12.0, y: 10.0, width: 26.0, height: 26.0)

        self.leftViewMode = .always
        view.addSubview(imageView)
        
        self.leftViewMode = .always
        self.leftView = view
    }

    // check if email is in good format
    func checkEmailFormat(action: (_ result : Bool) -> Void) {

        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

          let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
//        if self.text!.isEmpty {
//            action(true)
//
//        }
        
        action(emailPred.evaluate(with: self.text))
     
    }
    
    func checkEmptyInput(action: (_ emptyResult : Bool) -> Void) {
        
    
        action(self.text!.isEmpty)
    }
    
    
    // change the color of the text field to red
    func invalidInput()  {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 100, green: 0, blue: 0, alpha: 1).cgColor
    }
    
    // change the color of the text field back to normal
    func validInput()  {
        self.layer.borderWidth = 0.0
      
    }
    
    
    
    
}
