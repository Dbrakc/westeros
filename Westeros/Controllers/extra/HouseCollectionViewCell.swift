//
//  HouseCollectionViewCell.swift
//  Westeros
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class HouseCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = String (describing: self)
    
    //Hacer los outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
