//
//  SignupViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTextFields()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func shouldEnableSignInButton(enable:Bool) {
        self.registerButton.isEnabled = enable
        self.registerButton.backgroundColor = enable ? UIColor.TLOrange() : UIColor.TLLightGrey()
    }
    
    
    //MARK: text field actions
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
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
        self.nameTextField.setBottomBorder(color: UIColor.TLLightGrey())
        
        nameTextField.delegate = self
        nameTextField.returnKeyType = .next
        nameTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: .editingChanged)
        
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .done
        passwordTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: .editingChanged)
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .next
        emailTextField.addTarget(self, action: #selector(LoginViewController.textFieldDidChange), for: .editingChanged)
        
    }
    
    func textFieldDidChange() {
        let enable = emailTextField.text != "" && nameTextField.text != "" && passwordTextField.text!.characters.count >= 6;
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
    
    //IB actions
    
    @IBAction func signInPressed(_ sender: Any) {
    }
    
    @IBAction func registerPressed(_ sender: Any) {
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