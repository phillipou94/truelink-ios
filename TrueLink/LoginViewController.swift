//
//  LoginViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/16/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit
import Bluejay
import CoreBluetooth

class LoginViewController: UIViewController, UITextFieldDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {

    var centralManager: CBCentralManager!
    var arduinoPeripheral: CBPeripheral!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            
        case .unknown:
            print("central.state is .unknown")
        case .resetting:
            print("central.state is .resetting")
        case .unsupported:
            print("central.state is .unsupported")

        case .unauthorized:
            print("central.state is .unauthorized")

        case .poweredOff:
            print("central.state is .poweredOff")

        case .poweredOn:
            print("central.state is .poweredOn")
            let serviceIdentifier = "19B10000-E8F2-537E-4F6C-D104768A1214"
            centralManager.scanForPeripherals(withServices: [CBUUID(string: serviceIdentifier)])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Found peripheral: ", peripheral)
        arduinoPeripheral = peripheral
        arduinoPeripheral.delegate = self
        centralManager.stopScan()
        centralManager.connect(arduinoPeripheral)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to peripheral: ", peripheral)
        let serviceIdentifier = "19B10000-E8F2-537E-4F6C-D104768A1214"
        arduinoPeripheral.discoverServices([CBUUID(string: serviceIdentifier)])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {return}
        
        let arduinoService = services[0]
        let characteristicIdentifier = "19B10001-E8F2-537E-4F6C-D104768A1214"
        peripheral.discoverCharacteristics([CBUUID(string: characteristicIdentifier)], for: arduinoService)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else {return}
        
        let arduinoCharacteristic = characteristics[0]
        print(arduinoCharacteristic)
        
        if arduinoCharacteristic.properties.contains(.read) {
            print("properties contains .read")
        }
        if arduinoCharacteristic.properties.contains(.notify) {
            print("properties contains .notify")
        }
        
        peripheral.setNotifyValue(true, for: arduinoCharacteristic)
        print("writeValue a")
        peripheral.writeValue("a".data(using: .utf8)!, for: arduinoCharacteristic, type: .withResponse)
        print("writeValue b")
        peripheral.writeValue("b".data(using: .utf8)!, for: arduinoCharacteristic, type: .withResponse)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if error != nil {
            print("error writing value")
        } else {
//            print("readValue")
//            peripheral.readValue(for: characteristic)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        print("didUpdateNotificationStateFor")
        if error != nil {
            print("uh oh", error)
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        print("didUpdateValueFor")
        let newValue = String(data: characteristic.value!, encoding: String.Encoding.ascii)
        print(newValue)
//        if newValue == "c" {
//            print("send love to beacon 1")
//        } else if newValue == "d" {
//            print("send love to beacon 2")
//        }
    }
    
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
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
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
        
        
        
        
//        BluetoothManager.shared.scanForPeripherals()
        
//        let bluejay = Bluejay()
//
//        bluejay.start()
//
//        bluejay.start(connectionObserver: self)
//
//        let serviceId = "19B10000-E8F2-537E-4F6C-D104768A1214"
//        let characteristicId = "19B10001-E8F2-537E-4F6C-D104768A1214"
//
//        let serviceIdentifier = ServiceIdentifier(uuid: serviceId)
//        let characteristicIdentifier = CharacteristicIdentifier(uuid: characteristicId, service: serviceIdentifier)
//
//
//
//        bluejay.scan(
//            serviceIdentifiers: [serviceIdentifier],
//            discovery: { [weak self] (discovery, discoveries) -> ScanAction in
//
//                guard let weakSelf = self else {
//                    return .stop
//                }
//
//                return .continue
//            },
//            stopped: { (discoveries, error) in
//                if let error = error {
//                    debugPrint("Scan stopped with error: \(error.localizedDescription)")
//                }
//                else {
//                    debugPrint("Scan stopped without error.")
//                }
//        })
        
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
