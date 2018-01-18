//
//  LoginViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    var isLoggingIn = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTextFields()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func shouldEnableSignInButton(enable:Bool) {
        self.signInButton.isEnabled = enable
        self.signInButton.backgroundColor = enable ? UIColor.TLOrange() : UIColor.TLLightGrey()
    }
    
    
    //MARK: text field actions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
            
        }else if textField == passwordTextField{
            
            textField.resignFirstResponder()
            
        }
        return true
    }
    
    func initTextFields(){
        self.emailTextField.setBottomBorder(color: UIColor.TLLightGrey())
        self.passwordTextField.setBottomBorder(color: UIColor.TLLightGrey())
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: .editingChanged)
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: .editingChanged)
        
    }
    
    func textFieldDidChange() {
        let enable = emailTextField.text != "" && passwordTextField.text!.characters.count >= 6;
        shouldEnableSignInButton(enable: enable)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.setBottomBorder(color: UIColor.TLOrange())
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.setBottomBorder(color: UIColor.TLLightGrey())
        return true
    }
    
    func dismissKeyboard (_ sender: UITapGestureRecognizer)  {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    //IB actions
    
    @IBAction func signInPressed(_ sender: Any) {
        self.isLoggingIn = true
        self.animateSigningIn()
//        if let email = emailTextField.text {
//            if let password = passwordTextField.text {
//                UserRequest.shared.loginWithEmail(email: email, password: password, success: { (response) in
//                    self.isLoggingIn = false
//                    self.navigationController?.pushViewController(TabBarController(), animated: true)
//                }) { (failure) in
//                    
//                }
//            }
//        }
        BluetoothManager.shared.scanForPeripherals()
    }
    
    func animateSigningIn() {
        
        if self.isLoggingIn {
            if self.signInButton.titleLabel?.text == "Sign In" {
                self.signInButton.setTitle("Signing In", for: .normal)
            }else if self.signInButton.titleLabel?.text == "Signing In..." {
                self.signInButton.setTitle("Signing In", for: .normal)
            } else if (self.signInButton.titleLabel?.text == "Signing In") {
            self.signInButton.setTitle("Signing In.", for: .normal)
            } else if (self.signInButton.titleLabel?.text == "Signing In.") {
                self.signInButton.setTitle("Signing In..", for: .normal)
            } else if (self.signInButton.titleLabel?.text == "Signing In..") {
                self.signInButton.setTitle("Signing In...", for: .normal)
            }
            
            perform(#selector(animateSigningIn), with: nil, afterDelay: 0.5)
        }
        
        
    }


    @IBAction func signUpPressed(_ sender: Any) {
        let signupViewController = SignupViewController(nibName: "SignupViewController", bundle: nil)
        self.navigationController?.pushViewController(signupViewController, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
