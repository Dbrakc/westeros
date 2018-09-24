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
            tableView.delegate = self
        }
    }
    
    // MARK: - Initializers
    init(withSeasonsList seasons: [Season]){
        self.seasons = seasons
        super.init(nibName: nil, bundle: nil)
        title = Constants.seasonListNavigationViewControllerTitle
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
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        //Sincronizar modelo-vista
        cell?.textLabel?.text = season.name
       
        
        return cell!
    }
    
}

extension SeasonListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSeason = season (at:  indexPath.row)
        let seasonDetailViewController = SeasonDetailViewController(withSeason: selectedSeason)
        self.navigationController?.pushViewController(seasonDetailViewController, animated: true)
        
    }
    
    func season(at index: Int)->Season{
        return seasons[index]
    }
}
