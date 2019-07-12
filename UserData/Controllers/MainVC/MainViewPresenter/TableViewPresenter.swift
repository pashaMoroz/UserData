//
//  TableViewPresenter.swift
//  UserData
//
//  Created by Pasha Moroz on 7/11/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//


import Alamofire

enum Number: Int {
    
    case one = 1
    
    var number: Int {
        return self.rawValue
    }
}

class TableViewPresenter: BasePresenter {
    
    static let shared = TableViewPresenter()
    weak var userView: TableViewPresenterProtocol!
    var usersData = [UserData]()
    
    private func fillingsUsersFromTheInternet() {
        NetworkManager.shared.fetchDataWithAlamofire(url: Links.link) { [weak self](data) in
            
            guard let dataData = data.data else {
                return
            }
            guard let dataUser = dataData.users else {
                return
            }
            if self?.usersData.isEmpty == true {
                
                self?.usersData = dataUser
            } else {
                
                self?.usersData += dataUser
            }
            
            self?.userView.reloadData()
        }
    }
    
    func downloadMoreData() {
        
        fillingsUsersFromTheInternet()
        Links.page += Number.one.number
        Links.link = "http://sd2-hiring.herokuapp.com/api/users?offset=\(Links.offset)&limit=\(Links.limit)"
    }
}

protocol TableViewPresenterProtocol: class {
    
    func reloadData()
}

