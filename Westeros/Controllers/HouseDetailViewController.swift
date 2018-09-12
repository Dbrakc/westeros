//
//  HouseDetailViewController.swift
//  Westeros
//
//  Created by David Braga  on 12/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class HouseDetailViewController: UIViewController {
    
    //MARK: - Properties
    let model: House

    //MARK: - Outlets
    @IBOutlet weak var houseNameLable: UILabel!
    
    @IBOutlet weak var sigilImageView: UIImageView!
    
    @IBOutlet weak var wordsLable: UILabel!
    
    //MARK: - Initialization
    
    init(model: House) {
        //Primero le doy valor a mis propias propiedad
        self.model = model
        //Despues llamamos a super
        super.init(nibName: nil, bundle: nil)
    }
    
    //Este init es el que utilizan los Storyboards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Syncronizar modelo y vista
        syncModelWithView()
    }
    
    func syncModelWithView(){
        houseNameLable.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLable.text = model.words
    }
    
 
}
