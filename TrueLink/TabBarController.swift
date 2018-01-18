//
//  TabBarController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit
import CoreBluetooth

class TabBarController: UITabBarController, UITabBarControllerDelegate, SettingsButtonDelegate, LogoDelegate, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var centralManager: CBCentralManager!
    var arduinoPeripheral: CBPeripheral!
    
    
    //light up YOUR machine (TAP ICON THEN PULL-TO-REFRESH YOU BIG DUMMY)
    let serviceId = "19B10000-E8F2-537E-4F6C-D104768A1214"
    let characteristicId = "19B10001-E8F2-537E-4F6C-D104768A1214"

    override func viewDidLoad() {
        super.viewDidLoad();
        self.initTabBarAttributes()
        
        let navBar = DefaultNavBar.init(width: self.view.frame.size.width)
        navBar.settingsButtonDelegate = self
        navBar.logoDelegate = self
        self.view.addSubview(navBar)
        
        
        let itayViewController = ITAYViewController();
        itayViewController.tabBarItem.image = UIImage(named: "HeartIcon")
        itayViewController.extendedLayoutIncludesOpaqueBars = true
        itayViewController.tabBarItem.title = "Send Love"
        
        let connectionsViewController = ConnectionsViewController()
        connectionsViewController.tabBarItem.image = UIImage(named: "ConnectionsIcon");
        connectionsViewController.extendedLayoutIncludesOpaqueBars = true
        connectionsViewController.tabBarItem.title = "Connections"
        
        self.viewControllers = [itayViewController, connectionsViewController]
        self.delegate = self
        
    }
    
    func initTabBarAttributes() {
        self.selectedIndex = 0;
        self.tabBar.barTintColor = UIColor.TLOffWhite()
        self.tabBar.tintColor = UIColor.TLOrange()
        self.tabBar.isOpaque = true;
        self.tabBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        if selectedViewController == nil || viewController == selectedViewController {
            return false
        }
        
        let fromView = selectedViewController!.view
        let toView = viewController.view
        
        UIView.transition(from: fromView!, to: toView!, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        if let selectedIndex = self.viewControllers?.index(of: viewController) {
            self.selectedIndex = selectedIndex
        }
        
        return true
    }
    
    func settingsButtonPressed() {
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        LocalStorageManager.shared.deleteSession()
        self.navigationController?.pushViewController(vc, animated: false)
//        self.present(vc, animated: false, completion: { 
//            LocalStorageManager.shared.deleteSession()
//        })
        
    }
    
    func logoPressed() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
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

            centralManager.scanForPeripherals(withServices: [CBUUID(string: serviceId)])
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
        arduinoPeripheral.discoverServices([CBUUID(string: serviceId)])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else {return}
        
        let arduinoService = services[0]
        peripheral.discoverCharacteristics([CBUUID(string: characteristicId)], for: arduinoService)
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
