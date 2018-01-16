//
//  PageViewController.swift
//  TrueLink
//
//  Created by Phillip Ou on 1/15/18.
//  Copyright © 2018 Phillip Ou. All rights reserved.
//

import Foundation

import UIKit

// PageViewController used for swipeable onboarding
class PageViewController: UIViewController, UIPageViewControllerDataSource {
    var viewControllers : [UIViewController] = []
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.horizontal, options: nil)
        
        let initialViewController = self.viewControllers[0]
        let startViewControllers:[UIViewController] = [initialViewController]
        
        
        self.pageViewController.setViewControllers(startViewControllers, direction: .forward, animated: true, completion: nil)
        self.pageViewController.dataSource = self
        
        self.addChildViewController(self.pageViewController)
        self.pageViewController.view.frame = self.view.frame
        self.view.addSubview(self.pageViewController.view)
        
        self.pageViewController.didMove(toParentViewController: self)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: data source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        return nil
    }
    
    
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0
        
    }
    
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        
        return 0
        
    }
    


}
