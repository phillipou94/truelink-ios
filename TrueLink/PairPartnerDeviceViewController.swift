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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoadingState()
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.showFinishedLoadingState()
            self.saveDeviceFlow()
        }
        
        // Do any additional setup after loading the view.
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
        let buttonPadding = CGFloat(70.0)
        if let loadingView = self.loadingView {
            let textFieldFrame = CGRect(x:buttonPadding, y: self.loadingView!.frame.maxY, width:self.view.frame.width - 2*buttonPadding, height:40)
            self.deviceNameTextField = UITextField(frame: textFieldFrame)
            self.deviceNameTextField?.setBottomBorder(color: UIColor.TLLightGrey())
            self.deviceNameTextField?.delegate = self
            
            let buttonFrame = CGRect(x:buttonPadding, y: textFieldFrame.maxY + 40, width:self.view.frame.width - 2*buttonPadding, height:40)
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
            
            if let textField = self.deviceNameTextField {
                self.view.addSubview(textField)
            }
            
            self.view.addSubview(button)
            
            button.addTarget(self, action: #selector(saveButtonPressed), for: UIControlEvents.touchDown)
        }
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.setBottomBorder(color: UIColor.TLOrange())
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.setBottomBorder(color: UIColor.TLLightGrey())
        return true
    }
    
    func saveButtonPressed(sender: UIButton!) {
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
