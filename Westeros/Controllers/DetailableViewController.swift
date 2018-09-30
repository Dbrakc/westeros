//
//  DetailableViewController.swift
//  Westeros
//
//  Created by David Braga  on 28/09/2018.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class DetailableViewController: UIViewController, Detailable {
    // MARK:  - Properties

    private let _detailViewController : UIViewController
    
    //
    init(withDetailViewController detailViewController: UIViewController){
        _detailViewController = detailViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var detailViewController: UIViewController{
        return _detailViewController
    }

}
