//
//  UserApi.swift
//  UserData
//
//  Created by Pasha Moroz on 7/11/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//

class Links  {

    static var offset: Int {
        return Links.page * Links.limit
    }
    
    static var limit: Int = 10
    static var page: Int = 0
    
    static var link: String = "http://sd2-hiring.herokuapp.com/api/users?offset=\(Links.offset)&limit=\(Links.limit)"

}
