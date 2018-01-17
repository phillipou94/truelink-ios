//
//  DefaultNavBar.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

protocol SettingsButtonDelegate {
    func settingsButtonPressed()
}

class DefaultNavBar: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var settingsButtonDelegate : SettingsButtonDelegate?
    
    static func height() -> CGFloat {
        return 45.0;
    }
    
    init(width: CGFloat) {
        let topPadding = 30.0
        let navBarHeight = Double(DefaultNavBar.height())
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: Double(width), height: navBarHeight+topPadding))
        
        self.backgroundColor = UIColor.TLOffWhite()
        self.addBorder(toSide: ViewSide.Bottom, withColor: UIColor.TLBlack().cgColor, andThickness: 1.0)
        
        // initialize logo
        let logoImageViewFrame = CGRect(x: 20, y: topPadding, width: 28, height: 25)
        
        let logoImageView = UIImageView.init(frame: logoImageViewFrame)
        logoImageView.image = UIImage(named: "TrueLinkIcon")
        
        
        // initialize title
        let titleLabelFrame = CGRect(x: logoImageViewFrame.origin.x + logoImageView.frame.size.width + 10,
                                      y: CGFloat(topPadding),
                                      width: 100,
                                      height: logoImageViewFrame.size.height)
        let navbarTitleLabel = UILabel.init(frame: titleLabelFrame)
        navbarTitleLabel.text = "truelink"
        navbarTitleLabel.font = UIFont.TLFontOfSize(size: 30)
        navbarTitleLabel.textColor = UIColor.TLBlack()
        
        // initialize settings button
        let settingsButton = UIButton.init(frame: CGRect(x:width - 30, y:CGFloat(topPadding), width: 25, height: 25))
        settingsButton.setImage(UIImage.init(named: "SettingsIcon"), for: UIControlState.normal)
        settingsButton.addTarget(self, action: #selector(didPressSettingsButton(sender:)), for: UIControlEvents.touchUpInside)

       
        self.addSubview(logoImageView)
        self.addSubview(navbarTitleLabel)
        self.addSubview(settingsButton)
    }
    
    func didPressSettingsButton(sender:UIButton) {
        //TODO: Navigate to Settings Page
        self.settingsButtonDelegate?.settingsButtonPressed()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
