//
//  NetworkManager.swift
//  UserData
//
//  Created by Pasha Moroz on 7/11/19.
//  Copyright © 2019 Pavel Moroz. All rights reserved.
//

import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func fetchDataWithAlamofire(url: String, completion: @escaping (Data) -> ()) {
        
        request(url).responseData { (dataResponse) in
            
            switch dataResponse.result {
            case .success(let data):
                guard let data = try? JSONDecoder().decode(Data.self, from: data) else {
                    return
                }
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
