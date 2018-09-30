//
//  HouseListDetailableViewController.swift
//  Westeros
//
//  Created by David Braga  on 28/09/2018.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit
protocol HouseListDetailableViewControllerDelegate {
    //Should
    //Will
    //Did
    //El primer parametro de las funciones del Delegate es SIEMPRE el objeto
    func houseListDetailableViewController(_ vc: HouseListDetailableViewController, didSelectedHouse house: House)
    
}



class HouseListDetailableViewController: UIViewController {
    // MARK: - Properties
    let model : [House]
    var delegate : HouseListDetailableViewControllerDelegate?
    
    // MARK: -IBOutlets
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    
    // MARK: - Initialization
    init(model: [House]){
        self.model = model
        super.init(nibName: nil, bundle: nil)
        title = "Westeros"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Siempre que creamos celdas personalizadas tenemos que registrarlas

        registerCustomCell()
        
    }
    
    func registerCustomCell(){
        let nib = UINib(nibName: "HouseCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: HouseCell.reuseIdentifierCell)
    }
    
}

extension HouseListDetailableViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = HouseCell.reuseIdentifierCell
        
        // Descubrir el item (casa) que tenemos que mostar
        let house = model[indexPath.row]
        
        // Crear una celda o que nos la den del caché
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId ) as? HouseCell
        if cell == nil {
            cell = HouseCell(style: .default, reuseIdentifier: cellId)
        }
        
        // Sincronizar celda (view) y casa (model)
        cell?.sigilImageView.image = house.sigil.image
        cell?.nameLabel.text = house.name
        cell?.wordsLabel.text = house.words
        
        // Devolver la celda
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Westeros"
    }
}
    
extension HouseListDetailableViewController: UITableViewDelegate{
    //MARK: - Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Averiguar la casa en cuestión
        let theHouse = house(at: indexPath.row)
        
        if splitViewController!.viewControllers.count > 1{
    
        //Siempre emitir las notificaciones a través de los dos métodos.
        
        //Avisar al delegado
        delegate?.houseListDetailableViewController(self, didSelectedHouse: theHouse)
        
        // Enviar una notifiación
        let notificationCenter = NotificationCenter.default
        let notification = Notification(name: .houseDidChangeNotification, object: self , userInfo: [Constants.houseKey: theHouse])
        notificationCenter.post(notification)
        
        //Guardamos la ultima casa seleccionada
        saveLastSelectedHouse(at: indexPath.row)
        }else{
            let houseDetailViewController = HouseDetailViewController(model: theHouse)
            self.navigationController?.pushViewController(houseDetailViewController, animated: true)
        }
    
        
    }
    
}

//MARK: - Persistence
// (UserDefaults) Solo sirve para persistir pequeñas cantidades de objetos
// los objetos tienen que ser sendillos: String, Int, Array
extension HouseListDetailableViewController {
    
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

extension HouseListDetailableViewController : Detailable{

    var detailViewController: UIViewController {
        return (delegate as! UIViewController).wrappedInNavigation()
    }
    
    
}



