//
//  EpisodeListViewController.swift
//  Westeros
//
//  Created by David Braga  on 24/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class EpisodeListViewController: UIViewController {
    
    // MARK:  - Properties
    var episodes : [Episode]
    var lastSeasonDeatilViewController : SeasonDetailViewController?
    
    
    // MARK:  - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK:  - Initializers
    
    init(withEpisodeArray episodes: [Episode]){
        self.episodes = episodes
        super.init(nibName: nil, bundle:  nil)
        title = "Episodes"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK:  LifeCycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Subscribirse a la notificacion
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(seasonDidChange), name: .seasonDidChangeNotification, object: nil)
        
    }
    
    
    //Mark: Notifications
    
    @objc func seasonDidChange(notification: Notification){
        guard let info = notification.userInfo,
            let season : Season = info[Constants.seasonKey] as? Season else {return}

        self.episodes = season.episodesSorted
        lastSeasonDeatilViewController = SeasonDetailViewController(withSeason: season)
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: season.name, style: .plain, target: self, action: #selector(backButtonPress))
        tableView.reloadData()
        
    }
    
    @objc func backButtonPress (){
        guard let viewController = lastSeasonDeatilViewController else{
            return
        }
        self.navigationController?.pushViewController(viewController, animated: true)
    }


}

extension EpisodeListViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "SeasonCell"
        let episode = episodes[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil{
            cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
        
        //Sincronizar modelo-vista
        cell?.textLabel?.text = episode.title
        
        
        return cell!
    }
    
    func episodes(at index: Int)->Episode{
        return episodes[index]
    }
    
}

extension EpisodeListViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEpisode = episodes (at:  indexPath.row)
        let episodeDetailViewController = EpisodeDetailViewController(withEpisode: selectedEpisode)
        self.navigationController?.pushViewController(episodeDetailViewController, animated: true)
    }

}
