//
//  LoadingView.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/17/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingView: UIView {
    
    var activityIndicator : NVActivityIndicatorView?

    init(parentView: UIView, message:String) {
        super.init(frame:CGRect(x:parentView.frame.origin.x,
                                 y:parentView.frame.origin.y,
                                 width:parentView.frame.size.width,
                                 height:parentView.frame.size.height/2))
        
        let indicatorWidth = 150.0
        let verticalPadding = 100.0
        let x = (Double(self.frame.size.width) - indicatorWidth) / 2
        let activityIndicatorFrame = CGRect(x: x, y: verticalPadding, width: indicatorWidth, height: indicatorWidth)
        self.activityIndicator = NVActivityIndicatorView(frame: activityIndicatorFrame, type: .circleStrokeSpin, color: UIColor.TLOrange(), padding: 20)
        if let activityIndicator = self.activityIndicator {
            self.addSubview(activityIndicator)
            self.bringSubview(toFront: activityIndicator)
        }
        let textViewWidth = indicatorWidth + 100
        let textViewX = (Double(self.frame.size.width) - textViewWidth) / 2
        let pairingTextViewFrame = CGRect(x:textViewX, y:Double(activityIndicatorFrame.maxY + 20.0), width:textViewWidth, height: 60.0)
        let textView = UITextView(frame: pairingTextViewFrame)
        textView.text = message
        textView.font = UIFont.TLFontOfSize(size: 20)
        textView.isEditable = false
        textView.textAlignment = .center
        
        self.addSubview(textView)
        
        
    }
    
    func startLoadingAnimation() {
        self.activityIndicator?.startAnimating()
    }
    
    func stopLoadingAnimation() {
        self.activityIndicator?.stopAnimating()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
