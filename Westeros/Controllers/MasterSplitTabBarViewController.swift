//
//  MasterSplitTabBarViewController.swift
//  Westeros
//
//  Created by David Braga  on 26/09/2018.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class MasterSplitTabBarViewController: UITabBarController{
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        let navigationViewControllers = viewControllers?.map{$0.wrappedInNavigation()}
        super.setViewControllers(navigationViewControllers, animated: true)
    }

}


