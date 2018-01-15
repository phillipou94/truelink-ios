//
//  TabBarController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad();
        self.initTabBarAttributes()
        
        let navBar = DefaultNavBar.init(width: self.view.frame.size.width)
        self.view.addSubview(navBar)
        
        
        let itayViewController = ITAYViewController();
        itayViewController.tabBarItem.image = UIImage(named: "HeartIcon")
        itayViewController.extendedLayoutIncludesOpaqueBars = true
        itayViewController.tabBarItem.title = "Send Love"
        
        let connectionsViewController = ConnectionsViewController()
        connectionsViewController.tabBarItem.image = UIImage(named: "ConnectionsIcon");
        connectionsViewController.extendedLayoutIncludesOpaqueBars = true
        connectionsViewController.tabBarItem.title = "Connections"
        
        self.viewControllers = [itayViewController, connectionsViewController];
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
