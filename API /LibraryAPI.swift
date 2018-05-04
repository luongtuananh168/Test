//
//  LibraryAPI.swift
//  Test
//
//  Created by Admin on 5/2/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import Alamofire

protocol protocolReloadTBV {
    func reloadTableView(countries:[Country])
    func requestAPIError(statusError: Int)
}

class LibraryAPI {
    
    var delegate: protocolReloadTBV?
    
    static let shared = LibraryAPI()
    
    func getData(url : String) {
        //GET
        Alamofire.request(url).response { response in
            
            if let data = response.data {
                do{
                    //Request Error
                    if let jsonError = try? JSONDecoder().decode(DataError.self, from: data){
                        
                        DispatchQueue.main.async {
                            self.delegate?.requestAPIError(statusError: jsonError.status)
                        }
                        
                    }else{
                        // Request Success
                        let jsonData = try JSONDecoder().decode([failableDecod<Country>].self, from: data).flatMap { $0.base }
                        
                        DispatchQueue.main.async {
                            self.delegate?.reloadTableView(countries: jsonData)
                        }
                    }
                    
                }catch let err {
                    print(err)
                }
            }
        }
    }
    
}
