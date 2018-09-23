//
//  HouseCell.swift
//  Westeros
//
//  Created by David Braga  on 19/9/18.
//  Copyright © 2018 David Braga . All rights reserved.
//

import UIKit

class HouseCell: UITableViewCell {
    static let reuseIdentifierCell = String(describing: self)

    @IBOutlet weak var sigilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var wordsLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sigilImageView.image = nil
        nameLabel.text = nil
        wordsLabel.text = nil
    }

}
    

