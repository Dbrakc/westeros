//
//  SplitViewController.swift
//  Westeros
//
//  Created by David Braga  on 27/09/2018.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

protocol Detailable{
    var detailViewController : UIViewController { get }
}




class SplitViewController: UISplitViewController{
    
    func showDetail(ofDetailable detailable: Detailable){
        viewControllers[1]=detailable.detailViewController
    }
    
}


extension SplitViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationViewController = viewController as? UINavigationController, let detailable  = navigationViewController.visibleViewController as? Detailable else {
            return
        }
        showDetail(ofDetailable: detailable)
    }
}





