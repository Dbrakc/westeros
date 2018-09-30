//
//  AppDelegate.swift
//  Westeros
//
//  Created by David Braga  on 6/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .cyan

        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
        
    
        let houseListDetailableViewController = HouseListDetailableViewController(model: houses)
        let lastHouseSelected = houseListDetailableViewController.lastSelectedHouse()
        let houseDetailWiewController = HouseDetailViewController(model: lastHouseSelected)
       
        
        let seasonListViewControler = SeasonListViewController(withSeasonsArray: seasons)
        let lastSeasonSelected = seasonListViewControler.lastSelectedSeason()
        let seasonDetailViewControler = SeasonDetailViewController(withSeason: lastSeasonSelected)
        
        
        houseListDetailableViewController.delegate = houseDetailWiewController
        seasonListViewControler.delegate = seasonDetailViewControler
        
        
        
        let tabBarViewController = UITabBarController ()
        tabBarViewController.viewControllers = [houseListDetailableViewController.wrappedInNavigation(), seasonListViewControler.wrappedInNavigation()]
        
        let splitViewController = SplitViewController()
        tabBarViewController.delegate = splitViewController
        splitViewController.delegate = houseDetailWiewController
      
        
        splitViewController.viewControllers = [tabBarViewController, houseDetailWiewController.wrappedInNavigation()]
        
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        return true
    }

    


}

