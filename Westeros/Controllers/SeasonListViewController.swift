//
//  SeasonListViewController.swift
//  Westeros
//
//  Created by David Braga  on 24/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class SeasonListViewController: UIViewController {
    
    // MARK: - Properties
    let seasons : [Season]
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
        }
    }
    
    // MARK: - Initializers
    init(withSeasonsList seasons: [Season]){
        self.seasons = seasons
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SeasonListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        let season = seasons[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        }
        
        //Sincronizar modelo-vista
        cell?.textLabel?.text = season.name
        cell?.detailTextLabel?.text = season.description
        
        return cell!
    }
    
    
}
