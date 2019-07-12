//
//  BaseTableViewController.swift
//  UserData
//
//  Created by Pasha Moroz on 7/11/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController  {
    
    var presenter: BasePresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
}
