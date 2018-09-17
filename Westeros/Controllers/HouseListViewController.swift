//
//  HouseListViewController.swift
//  Westeros
//
//  Created by David Braga  on 17/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

protocol HouseListViewControllerDelegate {
    //Should
    //Will
    //Did
    //El primer parametro de las funciones del Delegate es SIEMPRE el objeto
    func houseListViewController(_ vc: HouseListViewController, didSelectedHouse house: House)
    
}



class HouseListViewController: UITableViewController {
    
    // MARK: - Properties
    let model : [House]
    var delegate : HouseListViewControllerDelegate?
    
    // MARK: - Initialization
    init(model: [House]){
        self.model = model
        super.init(nibName:nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return model.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "HouseCell"
        
        // Descubrir el item (casa) que tenemos que mostar
        let house = model[indexPath.row]
        
        // Crear una celda o que nos la den del caché
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId )
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda (view) y casa (model)
        cell?.imageView?.image = house.sigil.image
        cell?.textLabel?.text = house.name
        
        // Devolver la celda
        return cell!

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Westeros"
    }
    
    //MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Averiguar la casa en cuestión
        let house = model [indexPath.row]
    

        //Siempre emitir las notificaciones a través de los dos métodos.
        
        // Avisar al delegado
        delegate?.houseListViewController(self, didSelectedHouse: house)
        
        // Enviar una notifiación
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: Notification.Name(rawValue: HouseDidChangeNoficationName), object: self , userInfo: [HouseKey: house])
        notificationCenter.post(notification)
        
    }

}


