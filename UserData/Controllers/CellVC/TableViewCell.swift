//
//  TableViewCell.swift
//  UserData
//
//  Created by Pasha Moroz on 7/11/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//

import UIKit
import Nuke

class TableViewCell: UITableViewCell {
    
    @IBOutlet private var imageLabel: UIImageView! {
        didSet {
            imageLabel.layer.cornerRadius = imageLabel.frame.height / 2
        }
    }
    @IBOutlet private var nameOfUserLabel: UILabel!
    
    func configFavoriteCell(user: UserData) {
        
        nameOfUserLabel.text = user.name
        guard let articleImage = user.image else {
            
            return
        }
        guard let imageURL = URL(string: articleImage) else {
            
            return
        }
        Nuke.loadImage(with: imageURL, into: imageLabel)
    }
}
