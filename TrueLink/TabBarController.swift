//
//  TabBarController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate, SettingsButtonDelegate, LogoDelegate {

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
        self.present(vc, animated: false, completion: { 
            LocalStorageManager.shared.deleteSession()
        })
        
    }
    
    func logoPressed() {
        
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
