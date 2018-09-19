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
        let theHouse = house(at: indexPath.row)
    

        //Siempre emitir las notificaciones a través de los dos métodos.
        
        // Avisar al delegado
        delegate?.houseListViewController(self, didSelectedHouse: theHouse)
        
        // Enviar una notifiación
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: .houseDidChangeNotification, object: self , userInfo: [Constants.houseKey: house])
        notificationCenter.post(notification)
        
        //Guardamos la ultima casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
        
    }

}

//MARK: - Persistence
// (UserDefaults) Solo sirve para persistir pequeñas cantidades de objetos
// los objetos tienen que ser sendillos: String, Int, Array
extension HouseListViewController {
    
    func saveLastSelectedHouse (at index: Int){
        //Aquí vamos a guar
        let userDefaults  = UserDefaults.standard
        
        //lo insertamos en el diccionario de userDefaults
        userDefaults.set(index, forKey: Constants.lastHouseKey)
        
        //guardar
        userDefaults.synchronize()
    
        
    }
    
    func lastSelectedHouse () -> House {
        //Averiguar cual es la ultima row sel
        let index = UserDefaults.standard.integer(forKey: Constants.lastHouseKey) //Value 0 es default
        return house(at: index)
    }
    
    func house(at index: Int)->House{
        return model[index]
    }
    
}


