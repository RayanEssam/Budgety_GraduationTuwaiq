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
    @IBOutlet var phoneNumberTextField: UITextField!
    
    
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
        
        
        emailTextFiled.checkEmptyInput { emptyResult in
            
            if emptyResult {
                // empty email here
                // show alert here
                
                
                emailTextFiled.invalidInput()
                
            }else{
                emailTextFiled.validInput()
                
                passwordTextField.checkEmptyInput { emptyResult in
                    
                    if emptyResult {
                        
                        // empty Password here
                        // show alert here
                        
                        
                        passwordTextField.invalidInput()
                        
                    }else{
                        passwordTextField.validInput()
                        emailTextFiled.checkEmailFormat { result in
                            if result {
                             
                                emailTextFiled.validInput()
                                // SignIn here
                                print("All good")
                                
//                                let tabBarVC = TabBarController()
//                                self.present(tabBarVC, animated: true, completion: nil)
                                
                                
                            }else{
                                
                                emailTextFiled.invalidInput()
                                // bad email format here
                                // show alert here
                            }
                        }
                    }
                    
                    
                }
                
                
                
            }
            
            
            
            
        }
        
        
    }
    
    
    @IBAction func signUpActionButton(_ sender: Any) {
        
        
        signUpEmailTextField.checkEmptyInput { emailEmptyResult in
            
            
            if emailEmptyResult {
                // empty email here
                // show alert here
                
                
                signUpEmailTextField.invalidInput()
            }else{
                signUpEmailTextField.validInput()
                
                signUpNameTextField.checkEmptyInput { nameEmptyResult in
                
                    
                    if nameEmptyResult {
                        signUpNameTextField.invalidInput()
                    }else{
                        signUpNameTextField.validInput()
                        
                        signUpPasswordTextField.checkEmptyInput{ passwordEmptyResult in
                            
                            if passwordEmptyResult {
                                
                                // empty Password here
                                // show alert here
                                
                                
                                signUpPasswordTextField.invalidInput()
                                
                            }else{
                                signUpPasswordTextField.validInput()
                                signUpConfirmPasswordTextField.checkEmptyInput { confirmPasswordEmptyResult in
                                
                                    if confirmPasswordEmptyResult {
                                        // show alert here
                                        
                                        signUpConfirmPasswordTextField.invalidInput()
                                        
                                    }else{
                                        signUpConfirmPasswordTextField.validInput()

                                        signUpEmailTextField.checkEmailFormat { result in
                                            if result {
                                             
                                                signUpEmailTextField.validInput()
                                                
                                                
                                                if signUpPasswordTextField.text == signUpConfirmPasswordTextField.text {
                                                    
                                                    signUpPasswordTextField.validInput()
                                                    signUpConfirmPasswordTextField.validInput()
                                                    
                                                    // SignUp here
                                                    print("All good")
                                                    
                                                    DatabaseHandler.shared.createNewUser(email: signUpEmailTextField.text!, passwoord: signUpPasswordTextField.text!, name: signUpNameTextField.text! , phonNumber: phoneNumberTextField.text ?? "")
                                                    
                                                    
                                                }else{
                                                    
                                                    // show alert
                                                    // password does not match
                                                    
                                                    signUpPasswordTextField.invalidInput()
                                                    signUpConfirmPasswordTextField.invalidInput()

                                                    
                                                }
                                                
                                            }else{
                                                
                                                signUpEmailTextField.invalidInput()
                                                // bad email format here
                                                // show alert here
                                            }
                                        }
                                    }
                                    
                                    
                                }
                                
                                
                                
                            }
                            
                            
                        }
                        
                        

                    }
                    
                    
                }
                
                
                
                
            }
            
            
            
            
        }
        
        
        
//        signUpEmailTextField.checkEmailFormat { result in
//            if result {
//                print("Good email")
//
//            }else{
//                print("Bad email")
//
//            }
//        }
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
        
        phoneNumberTextField.setPaddingWithImage(image: UIImage(systemName: "phone")!)
        
        
        // logIn Button
        logInButton.layer.cornerRadius = 15
        
        
        // signUp button
        signUpButton.layer.cornerRadius = 15
        
        
    }
    
    
    
}




