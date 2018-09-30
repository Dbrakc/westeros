//
//  EpisodeDetailViewController.swift
//  Westeros
//
//  Created by David Braga  on 24/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class EpisodeDetailViewController: UIViewController {
    
    // MARK:  - Properties
    let episode : Episode
    
    // MARK:  - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var issueDateLabel: UILabel!
    @IBOutlet weak var resumeLabel: UILabel!
    
    // MARK:  - Initialization
    
    init(withEpisode episode: Episode){
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK:  - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        syncModelWithView()
    }
    
    // MARK:  - Methods
    func syncModelWithView(){
        title = self.episode.title
        nameLabel.text = self.episode.title
        issueDateLabel.text = self.episode.issueDate.onlyDateDescription
        resumeLabel.sizeToFit()
        resumeLabel.text = self.episode.resume
    }
   
}
