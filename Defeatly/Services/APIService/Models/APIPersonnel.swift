//
//  Personal.swift
//  Defeatly
//
//  Created by Pfriedrix on 24.08.2023.
//

import Foundation

struct APIPersonnel: Dateable {
    var date: String
    var day, personnel: Int
    var personnel_: String
    var pow: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case personnel_ = "personnel*"
        case pow = "POW"
    }
}
