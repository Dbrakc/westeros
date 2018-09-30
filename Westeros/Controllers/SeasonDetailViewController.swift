//
//  SeasonDetailViewController.swift
//  Westeros
//
//  Created by David Braga  on 24/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class SeasonDetailViewController: UIViewController {
    
    // MARK: - Properties
    var season : Season
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var episodesNumberLabel: UILabel!
    
    
    // MARK: - Initializers
    init(withSeason season: Season){
        self.season = season
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        syncModelWithView()
    }
    
    
    // MARK: - Methods
    
    func syncModelWithView(){
        title = season.name
        nameLabel.text = season.name
        releaseDateLabel.text = season.releaseDate.onlyDateDescription
        episodesNumberLabel.text = season.episodesCount.description
    }
    
    func setUpUI(){
        let episodesButton = UIBarButtonItem(title: "Episodes", style: .plain, target: self, action: #selector(displayEpisodes))
        
        //Añadir el botón
        navigationItem.setRightBarButton(episodesButton, animated: true)
    }
    
    @objc func displayEpisodes(){
        //Crear el VC destion
        let episodeListViewController = EpisodeListViewController(withEpisodeArray: season.episodesSorted)
        
        
        //Navergar a el push
        navigationController?.pushViewController(episodeListViewController, animated: true)
    }
}

extension SeasonDetailViewController : SeasonListDetailableViewControllerDelegate{
    func houseListDetailableViewController(_vc: UIViewController, willChangeViewController: Bool) -> UIViewController {
        return self
    }
    
    func SeasonListDetailableViewController(_ vc: SeasonListViewController, didSelectedSeason season: Season) {
        self.season = season
        syncModelWithView()
    }
}

extension SeasonDetailViewController : UISplitViewControllerDelegate{
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
        switch displayMode {
        case .primaryHidden:
            self.navigationItem.setLeftBarButton(svc.displayModeButtonItem, animated: true)
        default:
            break
        }
        
    }
    
    
    
}
