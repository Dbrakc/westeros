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
    let season : Season
    
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
        syncModelWithView()
    }
    
    
    // MARK: - Methods
    
    func syncModelWithView(){
        nameLabel.text = season.name
        releaseDateLabel.text = season.releaseDate.onlyDateDescription
        episodesNumberLabel.text = season.episodesCount.description
    }


   

}
