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
        let houses = Repository.local.houses
        let seasons = Repository.local.seasons
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
        let houseListDetailableViewController = HouseListDetailableViewController(model: houses)
        let lastHouseSelected = houseListDetailableViewController.lastSelectedHouse()
        //Detail
        let houseDetailWiewController = HouseDetailViewController(model: lastHouseSelected)
        
        
        //Asignar delegados
        //Un objeto solo puede tener un delegado
        //Un objeto sí puede ser delegado de varios otros
        
        
        
        //Crear el combinador
        
       
        let seasonListViewControler = SeasonListViewController(withSeasonsArray: seasons)
        let lastSeasonSelected = seasonListViewControler.lastSelectedSeason()
        let seasonDetailViewControler = SeasonDetailViewController(withSeason: lastSeasonSelected)
        let episodesListViewControler = EpisodeListViewController(withEpisodeArray: seasons[0].episodesSorted)
        
        houseListDetailableViewController.delegate = houseDetailWiewController
        seasonListViewControler.delegate = seasonDetailViewControler
        
        
        //Asignamos el RootViewController
        let houseCollectionVC = HouseCollectionViewController(withModel: houses)
        
        let tabBarViewController = UITabBarController ()
        tabBarViewController.viewControllers = [houseListDetailableViewController.wrappedInNavigation(), seasonListViewControler.wrappedInNavigation()]
        
        let splitViewController = SplitViewController()
        tabBarViewController.delegate = splitViewController
        
        splitViewController.viewControllers = [tabBarViewController, houseDetailWiewController.wrappedInNavigation()]
        
        window?.rootViewController = splitViewController
        window?.makeKeyAndVisible()
        return true
    }

    


}

