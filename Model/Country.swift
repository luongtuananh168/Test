//
//  Country.swift
//  Test
//
//  Created by Admin on 4/26/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

struct failableDecod <Base : Decodable> : Decodable {
    let base : Base?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

struct Country : Decodable{
    let name: String
    let capital: String
    let population : Double
    let area : Double
    let flag : String?
}
