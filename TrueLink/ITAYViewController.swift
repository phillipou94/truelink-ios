//
//  ITAYViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit
import CoreBluetooth

class ITAYViewController: UIViewController, SlideButtonDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {

    @IBOutlet weak var connectionCard: UIView!
    @IBOutlet weak var slider: MMSlidingButton!
    @IBOutlet weak var homeIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!

    @IBOutlet weak var imageView: UIImageView!
    
    var emptyView = UIView()
    
    var isSending : Bool = false
    var hasConnections = false
    var pairDeviceButton : UIButton?
    var lamp : Lamp?
    
    var centralManager: CBCentralManager!
    var arduinoPeripheral: CBPeripheral!
    
    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var imageContainerView: UIView!
    
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
    
    //
    // Begin actual itay view controller stuff now.
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.infoContainerView.frame.size.width, height: self.infoContainerView.frame.height + 1))
        //Change 2.1 to amount of spread you need and for height replace the code for height
        
        self.infoContainerView.layer.cornerRadius = 5
        self.infoContainerView.layer.shadowColor = UIColor.black.cgColor
        self.infoContainerView.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
        self.infoContainerView.layer.shadowOpacity = 0.5
        self.infoContainerView.layer.shadowRadius = 5.0 //Here your control your blur
        self.infoContainerView.layer.masksToBounds =  false
        self.infoContainerView.layer.shadowPath = shadowPath.cgPath
        
        
        self.imageContainerView.layer.cornerRadius = 10
        let shadowPath2 = UIBezierPath(rect: CGRect(x: 0, y: 0, width: self.imageContainerView.frame.size.width, height: self.imageContainerView.frame.height + 1))
        //Change 2.1 to amount of spread you need and for height replace the code for height
        
        self.imageContainerView.layer.cornerRadius = 10
        self.imageContainerView.layer.shadowColor = UIColor.black.cgColor
        self.imageContainerView.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)  //Here you control x and y
        self.imageContainerView.layer.shadowOpacity = 0.5
        self.imageContainerView.layer.shadowRadius = 5.0 //Here your control your blur
        self.imageContainerView.layer.masksToBounds =  false
        self.imageContainerView.layer.shadowPath = shadowPath2.cgPath
        
        self.imageView.layer.cornerRadius = 10
        self.imageView.layer.masksToBounds = true
        
        self.view.backgroundColor = UIColor.TLDarkGrey()
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
        self.homeIconImageView.isHighlighted = false
        self.slider.reset()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func itaySent(){
        self.homeIconImageView.isHighlighted = true
        self.slider.dragPointButtonLabel.text = "Sent!"
        self.isSending = false
        
        if let userLampId = LocalStorageManager.shared.getLamp()?.lampId {
            
            if let partnerLampId = self.lamp?.lampId {
                
                centralManager = CBCentralManager(delegate: self, queue: nil)
                
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
