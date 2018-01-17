//
//  LoadingView.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/17/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import M13Checkbox

class LoadingView: UIView {
    
    var activityIndicator : NVActivityIndicatorView?
    var finishedLoadingMessage : String?
    var textView : UITextView?

    init(parentView: UIView, loadingMessage:String, finishedLoadingMessage:String?) {
        super.init(frame:CGRect(x:parentView.frame.origin.x,
                                 y:parentView.frame.origin.y,
                                 width:parentView.frame.size.width,
                                 height:parentView.frame.size.height/2))
        
        let indicatorWidth = 150.0
        let verticalPadding = 100.0
        let x = (Double(parentView.frame.size.width) - indicatorWidth) / 2
        let activityIndicatorFrame = CGRect(x: x, y: verticalPadding, width: indicatorWidth, height: indicatorWidth)
        self.activityIndicator = NVActivityIndicatorView(frame: activityIndicatorFrame, type: .circleStrokeSpin, color: UIColor.TLOrange(), padding: 20)
        if let activityIndicator = self.activityIndicator {
            self.addSubview(activityIndicator)
            self.bringSubview(toFront: activityIndicator)
        }
        let textViewWidth = indicatorWidth + 100
        let textViewX = (Double(self.frame.size.width) - textViewWidth) / 2
        let pairingTextViewFrame = CGRect(x:textViewX, y:Double(activityIndicatorFrame.maxY + 20.0), width:textViewWidth, height: 60.0)
        self.textView = UITextView(frame: pairingTextViewFrame)
        if let textView = self.textView {
            textView.text = loadingMessage
            textView.font = UIFont.TLFontOfSize(size: 20)
            textView.isEditable = false
            textView.textAlignment = .center
            
            self.finishedLoadingMessage = finishedLoadingMessage
            
            self.addSubview(textView)
        }

        
        
    }
    
    func startLoadingAnimation() {
        self.activityIndicator?.startAnimating()
    }
    
    func finishedLoading() {
        self.activityIndicator?.stopAnimating()
        let checkbox = M13Checkbox(frame: (self.activityIndicator?.frame)!)
        
        self.addSubview(checkbox)
        checkbox.animationDuration = 1.0
        // The background color of the veiw.
        checkbox.backgroundColor = .white
        // The tint color when in the selected state.
        checkbox.tintColor = UIColor.TLOrange()
        // The tint color when in the unselected state.
        checkbox.secondaryTintColor = UIColor.TLOrange()
        // The color of the checkmark when the animation is a "fill" style animation.
        checkbox.secondaryCheckmarkTintColor = .white
        
        // Whether or not to display a checkmark, or radio mark.
        checkbox.markType = .checkmark
        // The line width of the checkmark.
        checkbox.checkmarkLineWidth = 2.0
        
        // The line width of the box.
        checkbox.boxLineWidth = 2.0
        // The corner radius of the box if it is a square.
        checkbox.cornerRadius = 4.0
        // Whether the box is a square, or circle.
        checkbox.boxType = .circle
        // Whether or not to hide the box.
        checkbox.hideBox = false
        checkbox.stateChangeAnimation = .bounce(.fill)
        checkbox.setCheckState(.checked, animated: true)
        
        if let textView = self.textView {
            textView.text = finishedLoadingMessage
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
