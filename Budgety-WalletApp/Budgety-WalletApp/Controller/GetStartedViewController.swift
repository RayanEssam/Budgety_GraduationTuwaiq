//
//  GetStartedViewController.swift
//  Budgety-WalletApp
//
//  Created by Rayan Taj on 02/01/2022.
//

import UIKit

class GetStartedViewController: UIViewController {
    
    // LogIn elements
    @IBOutlet var logInStackView: UIStackView!
    @IBOutlet var segmentControll: UISegmentedControl!
    @IBOutlet var emailTextFiled: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var logInButton: UIButton!
    
    //SignUp elements
    @IBOutlet var signUpStackView: UIStackView!
    @IBOutlet var signUpEmailTextField: UITextField!
    @IBOutlet var signUpNameTextField: UITextField!
    @IBOutlet var signUpPasswordTextField: UITextField!
    @IBOutlet var signUpConfirmPasswordTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
   
    }
    
    @IBAction func changeSegmentAction(_ sender: Any) {
        
        switch segmentControll.selectedSegmentIndex  {
            
        case 0 :
            logInStackView.isHidden = false
            signUpStackView.isHidden = true
        case 1 :
            logInStackView.isHidden = true
            signUpStackView.isHidden = false

        default :
            print("error")
            
            
        }
        
    }
    
    @IBAction func LogInActionButton(_ sender: Any) {
    
        emailTextFiled.checkEmailFormat { result in
            if result {
                print("Good email")
                
            }else{
                print("Bad email")
            }
        }
    
    }
    
    
    @IBAction func signUpActionButton(_ sender: Any) {
        
        
        signUpEmailTextField.checkEmailFormat { result in
            if result {
                print("Good email")
                
            }else{
                print("Bad email")
            }
        }
    }
    
    
    
}

extension GetStartedViewController {
    
    func setUpViews()  {
        
        // Segment
        segmentControll.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2980392157, green: 0.5529411765, blue: 0.431372549, alpha: 1)], for: .selected)
        segmentControll.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) ], for: .normal)
        
        
        emailTextFiled.setPaddingWithImage(image:  UIImage(systemName: "envelope")!)
   
        passwordTextField.setPaddingWithImage(image: UIImage(systemName: "lock")!)
        
        signUpEmailTextField.setPaddingWithImage(image:  UIImage(systemName: "envelope")!)
        
        signUpNameTextField.setPaddingWithImage(image: UIImage(systemName: "person")!)
        
        signUpPasswordTextField.setPaddingWithImage(image: UIImage(systemName: "lock.open")!)
        
        signUpConfirmPasswordTextField.setPaddingWithImage(image: UIImage(systemName: "lock")!)
        
        
        // logIn Button
        logInButton.layer.cornerRadius = 15
    
        
        // signUp button
        signUpButton.layer.cornerRadius = 15
        
        
    }
    
  
    
}




