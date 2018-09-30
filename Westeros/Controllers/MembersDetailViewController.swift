//
//  MembersDetailViewController.swift
//  Westeros
//
//  Created by David Braga  on 29/09/2018.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class MembersDetailViewController: UIViewController {
    
    
    // MARK:  Porperties
    let person: Person
    
    
    // MARK:  IBOutlets

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    
    // MARK:  Initializers
    init(withPerson person : Person){
        self.person = person
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
        title = self.person.name
        nameLabel.text = self.person.name
        aliasLabel.text = self.person.alias
        houseLabel.text = self.person.house.name
    }


}
