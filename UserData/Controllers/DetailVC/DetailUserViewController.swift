//
//  DetailUserViewController.swift
//  UserData
//
//  Created by Pasha Moroz on 7/12/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//

import UIKit
import Nuke

class DetailUserViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameUserLabel: UILabel!
    
    var nameUser = ""
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameUserLabel.text = nameUser
        downloadImage()
        print("Тест:\(nameUser)")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.layer.cornerRadius = imageView.frame.height / 2
    }
    
    private func downloadImage() {
        
        guard let imageURL = URL(string: imageUrl) else {
            
            return
        }
        Nuke.loadImage(with: imageURL, into: imageView)
    }

}
