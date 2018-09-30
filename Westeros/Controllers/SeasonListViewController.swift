//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by David Braga  on 24/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

protocol SeasonListDetailableViewControllerDelegate {
    //Should
    //Will
    //Did
    //El primer parametro de las funciones del Delegate es SIEMPRE el objeto
    func SeasonListDetailableViewController(_ vc: SeasonListViewController, didSelectedSeason season: Season)
    
}

class SeasonListViewController: UIViewController {
    
    // MARK: - Properties
    let seasons : [Season]
    var delegate: SeasonListDetailableViewControllerDelegate?
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: - Initializers
    init(withSeasonsArray seasons: [Season]){
        self.seasons = seasons
        super.init(nibName: nil, bundle: nil)
        title = Constants.seasonListNavigationViewControllerTitle
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SeasonListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        let season = seasons(at: indexPath.row)
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        //Sincronizar modelo-vista
        cell?.textLabel?.text = season.name
       
        
        return cell!
    }
    func seasons(at index: Int)->Season{
        return seasons[index]
    }
    
}

extension SeasonListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSeason = seasons (at:  indexPath.row)
        if splitViewController!.viewControllers.count > 1 {
        //Siempre emitir las notificaciones a través de los dos métodos.
        
        //Avisar al delegado
        delegate?.SeasonListDetailableViewController(self, didSelectedSeason: selectedSeason)
        
        // Enviar una notifiación
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: .seasonDidChangeNotification, object: self , userInfo: [Constants.seasonKey: selectedSeason])
        notificationCenter.post(notification)
        
        //Guardamos la ultima casa seleccionada
        saveLastSelectedSeason(at: indexPath.row)
        }else{
             let seasonDetailViewController = SeasonDetailViewController(withSeason: selectedSeason)
        self.navigationController?.pushViewController(seasonDetailViewController, animated: true)
        }
        
    }
}
    
extension SeasonListViewController {
    func saveLastSelectedSeason (at index: Int){
        //Aquí vamos a guar
        let userDefaults  = UserDefaults.standard
            
        //lo insertamos en el diccionario de userDefaults
        userDefaults.set(index, forKey: Constants.lastSeasonKey)
            
        //guardar
        userDefaults.synchronize()
            
            
    }
        
    func lastSelectedSeason () -> Season {
            //Averiguar cual es la ultima row sel
        let index = UserDefaults.standard.integer(forKey: Constants.lastSeasonKey) //Value 0 es default
        return seasons(at: index)
    }
        
}

extension SeasonListViewController : Detailable{
    var detailViewController: UIViewController {
        return (delegate as! UIViewController).wrappedInNavigation()
    }
    
    
}


    
    

