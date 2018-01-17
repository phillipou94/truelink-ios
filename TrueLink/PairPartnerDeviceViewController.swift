//
//  PairPartnerDeviceViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/17/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class PairPartnerDeviceViewController: UIViewController, UITextFieldDelegate {

    var emptyView : EmptyView?
    var loadingView : LoadingView?
    var deviceNameTextField : UITextField?
    var saveButton : UIButton?
    
    let keyboardDisplacement = CGFloat(100)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showLoadingState()
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.showFinishedLoadingState()
            self.saveDeviceFlow()
        }
    }
    
    private func showEmptyState(viewType: EmptyView.EmptyViewType) {
        self.emptyView = EmptyView(view: self.view, viewType: viewType)
        if let emptyView = self.emptyView {
            if !(self.view.subviews.contains(emptyView)) {
                self.view.addSubview(emptyView)
            }
        }
    }
    
    func showLoadingState() {
        self.emptyView?.isHidden = true
        self.loadingView = LoadingView.init(parentView: self.view, loadingMessage: "Setting Up Partner Device", finishedLoadingMessage:"Device Activated!")
        if let loadingView = self.loadingView {
            loadingView.startLoadingAnimation()
            
            self.view.addSubview(loadingView)
        }
        
        
    }
    
    func showFinishedLoadingState() {
        if let loadingView = self.loadingView {
            loadingView.finishedLoading()
        }
    }
    
    func saveDeviceFlow() {
        let buttonPadding = CGFloat(30.0)
        if let loadingView = self.loadingView {
            let textFieldFrame = CGRect(x:buttonPadding, y: self.loadingView!.frame.maxY, width:self.view.frame.width - 2*buttonPadding, height:40)
            self.deviceNameTextField = UITextField(frame: textFieldFrame)
            self.deviceNameTextField?.placeholder = "Set Device Name"
            self.deviceNameTextField?.font = UIFont.TLFontOfSize(size: 20)
            self.deviceNameTextField?.setBottomBorder(color: UIColor.TLLightGrey())
            self.deviceNameTextField?.delegate = self
            
            let buttonFrame = CGRect(x:buttonPadding, y: textFieldFrame.maxY + 20, width:self.view.frame.width - 2*buttonPadding, height:40)
            let button = UIButton(frame: buttonFrame)
            
            button.titleLabel?.font =  UIFont.TLFontOfSize(size: 20)
            button.setTitleColor(UIColor.white, for: UIControlState.normal)
            button.backgroundColor = UIColor.TLOrange()
            
            button.layer.shadowRadius = 3.0;
            button.layer.shadowColor = UIColor.black.cgColor;
            button.layer.shadowOffset =  CGSize(width: 0.0, height: 1.0)
            button.layer.shadowOpacity = 0.5;
            button.layer.masksToBounds = false;
            button.isUserInteractionEnabled = true
            button.setTitle("Save Device Name", for: UIControlState.normal)
            
            button.setBackgroundColor(UIColor.TLOrangeDarkened(), for: UIControlState.highlighted)
            self.saveButton = button
            
            if let textField = self.deviceNameTextField {
                self.view.addSubview(textField)
            }
            
            if let saveButton = self.saveButton {
                self.view.addSubview(saveButton)
            }
            
            button.addTarget(self, action: #selector(saveButtonPressed), for: UIControlEvents.touchDown)
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.setBottomBorder(color: UIColor.TLOrange())
        if let lv = self.loadingView {
            UIView.animate(withDuration: 0.2) {
                let newLVFrame = CGRect(x: 0, y: lv.frame.origin.y - self.keyboardDisplacement, width: lv.frame.size.width, height: lv.frame.size.height)
                let newTextFieldFrame = CGRect(x: textField.frame.origin.x,
                                                y: textField.frame.origin.y - self.keyboardDisplacement,
                                                width: textField.frame.size.width, height: textField.frame.size.height)
                lv.frame = newLVFrame
                
                textField.frame = newTextFieldFrame
                if let saveButton = self.saveButton {
                    let newButtonFrame = CGRect(x:saveButton.frame.origin.x,
                                                y: saveButton.frame.origin.y - self.keyboardDisplacement,
                                                width:saveButton.frame.size.width,
                                                height: saveButton.frame.size.height)
                    saveButton.frame = newButtonFrame
                }

            }
        }

        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.setBottomBorder(color: UIColor.TLLightGrey())
        return true
    }
    
    func saveButtonPressed(sender: UIButton!) {
        let PARTNER_ARDUINO_ID = "FAKE_ARDUINO"
        if let name = self.deviceNameTextField?.text {
            let partnerArduino = Arduino(id: PARTNER_ARDUINO_ID, name: name)
            LocalStorageManager.shared.updatePartnerArduino(partnerArduino: partnerArduino)
        }

        self.present(TabBarController(), animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
