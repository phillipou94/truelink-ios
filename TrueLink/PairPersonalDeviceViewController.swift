//
//  PairPersonalDeviceViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/17/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class PairPersonalDeviceViewController: UIViewController {
    var emptyView : EmptyView?
    var button : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initDefaultState()


        // Do any additional setup after loading the view.
    }
    
    private func initDefaultState() {
        showEmptyState(viewType: .NoConnections)
        
        if let emptyView = self.emptyView {
            let buttonPadding = CGFloat(70.0)
            let buttonFrame = CGRect(x:buttonPadding, y: emptyView.frame.maxY, width:self.view.frame.width - 2*buttonPadding, height:40)
            self.button = UIButton(frame: buttonFrame)
            if let button = self.button {
                button.titleLabel?.font =  UIFont.TLFontOfSize(size: 20)
                button.setTitleColor(UIColor.white, for: UIControlState.normal)
                button.backgroundColor = UIColor.TLOrange()
                
                button.layer.shadowRadius = 3.0;
                button.layer.shadowColor = UIColor.black.cgColor;
                button.layer.shadowOffset =  CGSize(width: 0.0, height: 1.0)
                button.layer.shadowOpacity = 0.5;
                button.layer.masksToBounds = false;
                button.isUserInteractionEnabled = true
                button.setTitle("Activate", for: UIControlState.normal)
                
                button.setBackgroundColor(UIColor.TLOrangeDarkened(), for: UIControlState.highlighted)
                
                self.view.addSubview(button)
                
                button.addTarget(self, action: #selector(activateButtonPressed), for: UIControlEvents.touchDown)
            }

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
        self.button?.isHidden = true
        
        let loadingView = LoadingView.init(parentView: self.view, message: "Finding plugged in devices")
        loadingView.startLoadingAnimation()
        
        self.view.addSubview(loadingView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func activateButtonPressed(sender: UIButton!) {
        self.showLoadingState()
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
