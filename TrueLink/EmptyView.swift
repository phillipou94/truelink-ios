//
//  EmptyView.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit


protocol EmptyViewButtonDelegate{
    func emptyViewButtonPressed(sender:EmptyView)
}

class EmptyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var delegate : EmptyViewButtonDelegate? 
    
    enum EmptyViewType {
        case NoITAYs, NoConnections
    }
    
    var button : UIButton = UIButton()

    
    convenience init(view:UIView, viewType: EmptyViewType) {
        
        let image = viewType == .NoITAYs ? UIImage(named: "ConnectionsIconFull") : UIImage(named:"HomeDeviceIcon")
        let title = viewType == .NoITAYs ? "Send Some Love" : "Activate Your Device"
        let noItaysMessage = "You have not reached out to anyone yet. Let that special someone know that you're thinking about them"
        let noConnectionsMessage = "Connect your device to your smart lamp so you can let that special someone know that you’re still thinking about them."
        let body = viewType == .NoITAYs ? noItaysMessage : noConnectionsMessage
        let buttonTitle = viewType == .NoITAYs ? "Send Love" : "Activate"
        self.init(view: view, image: image, title: title, body: body, buttonTitle: buttonTitle)
        
    }
    
    init(view: UIView, image: UIImage?, title: String, body : String, buttonTitle: String) {
        let horizontalMargin = 15.0
        let verticalMargin = 100.0
        let width = Double(view.frame.size.width) - 2*horizontalMargin
        super.init(frame: CGRect(x: horizontalMargin,
                                 y: Double(DefaultNavBar.height())+verticalMargin,
                                 width: width,
                                 height: 200))
        
        let imageViewWidth = CGFloat(80)
        let logoImageViewFrame = CGRect(x: (self.frame.size.width - imageViewWidth)/2, y: 0, width: imageViewWidth, height: 65)
        let logoImageView = UIImageView(frame: logoImageViewFrame)
        logoImageView.image = image
        
        let titleLabelFrame = CGRect(x: 0, y: logoImageView.frame.maxY + 10.0, width: self.frame.width, height: 25)
        let titleLabel = UILabel(frame: titleLabelFrame)
        titleLabel.text = title
        titleLabel.font = UIFont.TLFontOfSize(size: 25)
        titleLabel.textColor = UIColor.TLBlack()
        titleLabel.textAlignment = NSTextAlignment.center
        
        let bodyTextviewFrame = CGRect(x:0, y: titleLabel.frame.maxY + 5.0, width:self.frame.width, height: 100)
        let bodyTextview = UITextView(frame:bodyTextviewFrame)
        bodyTextview.text = body
        bodyTextview.font = UIFont.TLFontOfSize(size: 20)
        bodyTextview.textColor = UIColor.TLDarkGrey()
        bodyTextview.textAlignment = NSTextAlignment.center
        bodyTextview.isEditable = false
        
        //TODO: Change Button Color when highlighted
//        let buttonPadding = CGFloat(70.0)
//        let buttonFrame = CGRect(x:buttonPadding, y: bodyTextview.frame.maxY, width:self.frame.width - 2*buttonPadding, height:40)
//        let button = UIButton(frame: buttonFrame)
//        button.titleLabel?.font =  UIFont.TLFontOfSize(size: 20)
//        button.setTitleColor(UIColor.white, for: UIControlState.normal)
//        button.backgroundColor = UIColor.TLOrange()
//
//        button.layer.shadowRadius = 3.0;
//        button.layer.shadowColor = UIColor.black.cgColor;
//        button.layer.shadowOffset =  CGSize(width: 0.0, height: 1.0)
//        button.layer.shadowOpacity = 0.5;
//        button.layer.masksToBounds = false;
//        button.isUserInteractionEnabled = true
//        button.setTitle(buttonTitle, for: UIControlState.normal)
//        
//        self.isUserInteractionEnabled = false
//        button.addTarget(self, action: #selector(buttonPressed), for: UIControlEvents.touchDown)
        
        
        self.addSubview(logoImageView)
        self.addSubview(titleLabel)
        self.addSubview(bodyTextview)
//        self.addSubview(button)
        self.bringSubview(toFront: button)
        
    }
    
    func buttonPressed(sender:UIButton!) {
        
        self.delegate?.emptyViewButtonPressed(sender: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
