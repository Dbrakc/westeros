//
//  HouseListDetailableViewController.swift
//  Westeros
//
//  Created by David Braga  on 28/09/2018.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit
protocol HouseListDetailableViewControllerDelegate {
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
        let house = model[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId ) as? HouseCell
        if cell == nil {
            cell = HouseCell(style: .default, reuseIdentifier: cellId)
        }
        cell?.sigilImageView.image = house.sigil.image
        cell?.nameLabel.text = house.name
        cell?.wordsLabel.text = house.words
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
        let theHouse = house(at: indexPath.row)
        if splitViewController!.viewControllers.count > 1{
            delegate?.houseListDetailableViewController(self, didSelectedHouse: theHouse)
            let notificationCenter = NotificationCenter.default
            let notification = Notification(name: .houseDidChangeNotification, object: self , userInfo: [Constants.houseKey: theHouse])
            notificationCenter.post(notification)
            saveLastSelectedHouse(at: indexPath.row)
        }else{
            let houseDetailViewController = HouseDetailViewController(model: theHouse)
        self.navigationController?.pushViewController(houseDetailViewController, animated: true)
        }
    
        
    }
    
}

//MARK: - Persistence
extension HouseListDetailableViewController {
    
    func saveLastSelectedHouse (at index: Int){
        let userDefaults  = UserDefaults.standard
        userDefaults.set(index, forKey: Constants.lastHouseKey)
        userDefaults.synchronize()
    }
    
    func lastSelectedHouse () -> House {
        let index = UserDefaults.standard.integer(forKey: Constants.lastHouseKey)
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



