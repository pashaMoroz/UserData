//
//  TableViewController.swift
//  UserData
//
//  Created by Pasha Moroz on 7/11/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//

import UIKit
import Lottie

class TableViewController: BaseTableViewController, TableViewPresenterProtocol {
    
    let viewFooter = UIView()
    let activityIndicator = UIActivityIndicatorView()
    
    private var isDataLoading: Bool = false

        private var custPresenter: TableViewPresenter? {
        
        return presenter as? TableViewPresenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: TableViewCell.self),
                                 bundle: nil), forCellReuseIdentifier: String(describing: TableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter = TableViewPresenter()
        custPresenter?.userView = self
        title = "User of Telegram"
        viewFooter.isHidden = true
        viewFooter.addSubview(activityIndicator)
        setupActivityIndicator()

    }
   
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isDataLoading = false
    }

    //Pagination
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
            if !isDataLoading {
                
                viewFooter.isHidden = false
                isDataLoading.toggle()
                custPresenter?.downloadMoreData()
            }
        }
    }

    //MARK: - TableViewDataSourse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return custPresenter?.usersData.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self))
            as? TableViewCell else { return UITableViewCell() }
    
       guard let usersData = custPresenter?.usersData[indexPath.row] else { return cell }
        cell.configFavoriteCell(user: usersData)
        
        viewFooter.isHidden = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return viewFooter
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    private func setupActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: viewFooter.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: viewFooter.centerYAnchor).isActive = true
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
