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
    var model: House
    
    var collapsed: Bool = false

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

      
        title = model.name
    }
    
    //Este init es el que utilizan los Storyboards
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        //Syncronizar modelo y vista
        syncModelWithView()
    }
    
    
    //Mark: Sync
    func syncModelWithView(){
        houseNameLable.text = "House \(model.name)"
        sigilImageView.image = model.sigil.image
        wordsLable.text = model.words
        title = model.name
        
    }
    
    func setupUI() {
        //Crear los botones
        let wikiButton = UIBarButtonItem(title: "Wiki", style: .plain, target: self, action: #selector(displayWiki))
        
        let membersButton = UIBarButtonItem(title: "Members", style: .plain, target: self, action: #selector(displayMembers))
        
        
        
       
        
        //Añadir el botón
        navigationItem.setRightBarButtonItems([membersButton,wikiButton], animated: true)
       
        
    }
    
    
    @objc func displayWiki(){
        //Crear el VC destion
        let wikiViewController = WikiViewController(model: model)
        
    
        
        //Navegar a el push
        navigationController?.pushViewController(wikiViewController, animated: true)
        
    }
    
    @objc func displayMembers(){
        //Crear el VC destion
        let memberListViewController = MemberListViewController(model: model.sortedMember)
        
        
        //Navergar a el push
        navigationController?.pushViewController(memberListViewController, animated: true)
    }
    
}


extension HouseDetailViewController : HouseListDetailableViewControllerDelegate{
    func houseListDetailableViewController(_vc: UIViewController, willChangeViewController: Bool) -> UIViewController {
        return self
    }
    
   
    func houseListDetailableViewController(_ vc: HouseListDetailableViewController, didSelectedHouse house: House) {
        
        self.model = house
        syncModelWithView()
    }
    
    
}

extension HouseDetailViewController : UISplitViewControllerDelegate{
    
  
    func splitViewController(_ svc: UISplitViewController, willChangeTo displayMode: UISplitViewController.DisplayMode) {
        switch displayMode {
        case .primaryHidden:
            self.navigationItem.setLeftBarButton(svc.displayModeButtonItem, animated: true)
        default:
            break
        }
        
    }
   
}

