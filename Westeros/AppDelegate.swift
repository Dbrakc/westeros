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
        
        //Creamos los modelo
        let houses = Repository.local.houses;
        //creamos los controlador
        /*var controllers = [UIViewController]()
        
        for house in houses{
           controllers.append(HouseDetailViewController(model: house).wrappedInNavigation())
        }*/
        /*let controllers = houses
            .map{HouseDetailViewController(model: $0)}
            .map{$0.wrappedInNavigation()}
        
        
        //Creamos el combinador
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = controllers*/
        
      
        //Master
        let houseListViewController = HouseListViewController(model: houses)
        let lastHouseSelected = houseListViewController.lastSelectedHouse()
        //Detail
        let houseDetailWiewController = HouseDetailViewController(model: lastHouseSelected)
        
        
        //Asignar delegados
        //Un objeto solo puede tener un delegado
        //Un objeto sí puede ser delegado de varios otros
        houseListViewController.delegate = houseDetailWiewController 
        
        
        //Crear el combinador
        
        let splitViewController = UISplitViewController()
        
        splitViewController.viewControllers = [houseListViewController.wrappedInNavigation(), houseDetailWiewController.wrappedInNavigation()]
        
    
        
        //Asignamos el RootViewController
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        return true
    }

    


}

