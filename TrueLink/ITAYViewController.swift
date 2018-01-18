//
//  ITAYViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class ITAYViewController: UIViewController, SlideButtonDelegate {

    @IBOutlet weak var connectionCard: UIView!
    @IBOutlet weak var slider: MMSlidingButton!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLogoLabel: UILabel!
    @IBOutlet weak var homeIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var phoneIconImageView: UIImageView!
    @IBOutlet weak var heart1: UIImageView!
    @IBOutlet weak var heart2: UIImageView!
    @IBOutlet weak var heart3: UIImageView!
    @IBOutlet weak var heart4: UIImageView!
    @IBOutlet weak var heart5: UIImageView!
    
    var emptyView = UIView()
    
    var isSending : Bool = false
    var hasConnections = false
    var pairDeviceButton : UIButton?
    var lamp : Lamp?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.connectionCard.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.TLOffWhite()
        self.profileView.makeCircular()
        self.profileView.backgroundColor = UIColor.TLSpecialGreen()
        self.slider.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.reset()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hasConnections = LocalStorageManager.shared.getConnections().count > 0
        
        self.timestampLabel.text = "Local Time: "+self.getTimeString()+" HKT"
        
        let connections = LocalStorageManager.shared.getConnections()
        if (connections.count > 0) {
            self.lamp = connections[0]
        }
 
        if (!hasConnections) {
            self.showEmptyState(viewType: EmptyView.EmptyViewType.PartnerDevicePairing)
        }
        
        if let lamp = self.lamp {
            self.nameLabel.text = lamp.nickname
            if let name = lamp.nickname {
                let index = name.characters.index(name.startIndex, offsetBy: 0)
                let startChar = name[index]
                self.nameLogoLabel.text = String(startChar)
            }

        }
    }
    
    private func getTimeString() -> String {
        let calendar = Calendar.current
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date as Date)
    }
    
    private func showEmptyState(viewType: EmptyView.EmptyViewType) {
        if !(self.view.subviews.contains(self.emptyView)) {
            self.connectionCard.isHidden = true
            self.emptyView = EmptyView(view: self.view, viewType: viewType)
            self.view.addSubview(self.emptyView)
            let buttonPadding = CGFloat(70.0)
            let buttonFrame = CGRect(x:buttonPadding, y: emptyView.frame.maxY, width:self.view.frame.width - 2*buttonPadding, height:40)
            self.pairDeviceButton = UIButton(frame: buttonFrame)
            if let button = self.pairDeviceButton {
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
                
                button.addTarget(self, action: #selector(pairDeviceButtonPressed), for: UIControlEvents.touchDown)
            }

        }
    }
    
    func reset() {
        self.phoneIconImageView.isHighlighted = false
        self.homeIconImageView.isHighlighted = false
        self.slider.reset()
        self.heart1.isHighlighted = false
        self.heart2.isHighlighted = false
        self.heart3.isHighlighted = false
        self.heart4.isHighlighted = false
        self.heart5.isHighlighted = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func itaySent(){
        self.homeIconImageView.isHighlighted = true
        self.phoneIconImageView.isHighlighted = true
        self.slider.dragPointButtonLabel.text = "Sent!"
        self.isSending = false
        
        if let userLampId = LocalStorageManager.shared.getLamp()?.lampId {
            
            if let partnerLampId = self.lamp?.lampId {
                ItayRequest.shared.sendItay(userLampId: userLampId, recipientLampId: partnerLampId, success: { (itayId) in
                    
                    let vcs = self.tabBarController?.viewControllers
                    if let targetVC = vcs?[1] {
                        if let tabBarController = self.tabBarController {
                            tabBarController.delegate?.tabBarController!(tabBarController, shouldSelect: targetVC)
                        }
                        
                    }
                }) { (error) in
                    
                }

            }
        }
        
        
        

        
    }
    
    //MARK: - SlideButtonDelegate
    
    func buttonStatus(status: SlideButtonStatus, sender: MMSlidingButton) {
        let connectionId = "testConnectionId"
        let mainQueue = DispatchQueue.main
        self.isSending = true
        self.animateLoadingLabel()
        if (status == .Finished) {
//            ItayRequest.shared.sendItay(connectionId: connectionId, success: { (result) in
//                mainQueue.async {
//                    self.itaySent()
//                }
//            }, failure: { (error) in
//                
//            })
            let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.itaySent()
            }
            
            
        }
    }
    
    
    func hasMoved(percentage: Double, sender: MMSlidingButton) {
        //TODO: CHANGE BACK HEARTS TO GREY WHEN SLIDER IS RELASED BACK
        self.heart1.isHighlighted = percentage > 0
        self.heart2.isHighlighted = percentage > 0.2
        self.heart3.isHighlighted = percentage > 0.4
        self.heart4.isHighlighted = percentage > 0.6
        self.heart5.isHighlighted = percentage > 0.8
    }
    
    func animateLoadingLabel() {
        if self.isSending {
            if self.slider.dragPointButtonLabel.text == "Sending..." {
                self.slider.dragPointButtonLabel.text = "Sending"
            } else if (self.slider.dragPointButtonLabel.text == "Sending") {
                self.slider.dragPointButtonLabel.text = "Sending."
            } else if (self.slider.dragPointButtonLabel.text == "Sending.") {
                self.slider.dragPointButtonLabel.text = "Sending.."
            } else if (self.slider.dragPointButtonLabel.text == "Sending..") {
                self.slider.dragPointButtonLabel.text = "Sending..."
            }
            
            perform(#selector(animateLoadingLabel), with: nil, afterDelay: 0.5)
        }

        
    }
    
    func pairDeviceButtonPressed(sender: UIButton!) {
        let pairPartnerVC = PairPartnerDeviceViewController(nibName: "PairPartnerDeviceViewController", bundle: nil)
        self.present(pairPartnerVC, animated: false, completion: nil)
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
