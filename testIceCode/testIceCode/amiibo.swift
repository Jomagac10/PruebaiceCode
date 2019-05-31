//
//  Amiibo.swift
//  testIceCode
//
//  Created by Jose Manuel García Chávez on 5/30/19.
//  Copyright © 2019 Unam. All rights reserved.
//

import Foundation

//MARK: Model

struct amiibo: Decodable{
    let name: String
    let image: String
    let amiiboSeries: String
    let release: release?
}

struct release: Decodable{
    let au: String?
    let eu: String?
    let na: String?
    let jp: String?
}
