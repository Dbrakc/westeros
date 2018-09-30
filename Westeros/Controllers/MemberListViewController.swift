//
//  MemberListViewController.swift
//  Westeros
//
//  Created by David Braga  on 18/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class MemberListViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    var model: [Person]
    var lastHouseDetailViewController : HouseDetailViewController?
    
    // MARK: - Inicialization
    init (model: [Person]){
        self.model  =  model
        super.init(nibName: nil, bundle: nil)
        self.title = "Members"

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:  LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(houseDidChange), name: .houseDidChangeNotification, object: nil)
    }
    
  
    
    //Mark: Notifications
    
    @objc func houseDidChange(notification: Notification){
        guard let info = notification.userInfo,
            let house : House = info[Constants.houseKey] as? House else {return}
        self.model = house.sortedMember
        self.lastHouseDetailViewController = HouseDetailViewController(model: house)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: house.name, style: .plain, target: self, action: #selector(backButtonPress))
        tableView.reloadData()
    }
    
    @objc func backButtonPress (){
        guard let viewController = lastHouseDetailViewController else{
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    
}

extension MemberListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "PersonCell"
        let person = model[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        cell?.textLabel?.text = person.name
        cell?.detailTextLabel?.text = person.alias
        return cell!
    }
    
}

extension MemberListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMember = model [indexPath.row]
        let membersDetailViewController = MembersDetailViewController(withPerson: selectedMember)
        self.navigationController?.pushViewController(membersDetailViewController, animated: true)
    }
    
}


