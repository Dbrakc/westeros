//
//  UIViewController+Navigation.swift
//  Westeros
//
//  Created by David Braga  on 12/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit
extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        return UINavigationController(rootViewController: self)
    }
    
}
