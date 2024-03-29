//
//  TableViewController.swift
//  UserData
//
//  Created by Pasha Moroz on 7/11/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//

import UIKit
import Lottie

class TableViewController: BaseTableViewController, TableViewPresenterProtocol, UIViewControllerPreviewingDelegate {
 
    let viewFooter = UIView()
    let activityIndicator = UIActivityIndicatorView()
    var indexSelectedRow = 0
    
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
        title = "User of Telegram"
        
        presenter = TableViewPresenter()
        custPresenter?.userView = self
        viewFooter.isHidden = true
        viewFooter.addSubview(activityIndicator)
        setupActivityIndicator()
        custPresenter?.downloadMoreData()
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
    
    //MARK: - TableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

        isDataLoading = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailUserVC: DetailUserViewController = DetailUserViewController()
        guard let userInfo = custPresenter?.usersData[indexPath.row] else {

            return
        }
        detailUserVC.nameUser = userInfo.name ?? ""
        detailUserVC.imageUrl = userInfo.image ?? ""
        self.navigationController?.pushViewController(detailUserVC, animated: true)
    }

    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        indexSelectedRow = indexPath.row
        return true
    }
    
    //Pagination
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height)
        {
            if !isDataLoading {
                guard let countOfUser = custPresenter?.usersData.count else {
                    
                    return
                }
                if Links.offset + Links.limit - countOfUser == Links.limit {
                    
                    viewFooter.isHidden = false
                    isDataLoading.toggle()
                    custPresenter?.downloadMoreData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return viewFooter
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 20
    }
    
    //MARK: - TableViewDataSourse
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return custPresenter?.usersData.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self))
            as? TableViewCell else { return UITableViewCell() }
        
        self.registerForPreviewing(with: self, sourceView: cell)
        
        guard let usersData = custPresenter?.usersData[indexPath.row] else { return cell }
        cell.configFavoriteCell(user: usersData)
        
        viewFooter.isHidden = true
        
        return cell
    }
    
    //MARK: - UIViewControllerPreviewingDelegate
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = tableView.indexPathForRow(at: location) {
            previewingContext.sourceRect = tableView.rectForRow(at: indexPath)
            print("\(indexSelectedRow)")
            return detailViewController(for: indexSelectedRow)
        }
        
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }

    func detailViewController(for index: Int) -> DetailUserViewController {
        
        let detailUserVC: DetailUserViewController = DetailUserViewController()
        guard let userInfo = custPresenter?.usersData[index] else {
            
            return detailUserVC
        }
        detailUserVC.nameUser = userInfo.name ?? ""
        detailUserVC.imageUrl = userInfo.image ?? ""
        
        return detailUserVC
    }
    
}
