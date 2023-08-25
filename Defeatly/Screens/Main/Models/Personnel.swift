//
//  Personal.swift
//  Defeatly
//
//  Created by Pfriedrix on 24.08.2023.
//

import Foundation

struct Personnel: Codable {
    let date: String
    let day, personnel: Int
    let personnel_: String
    let pow: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, personnel
        case personnel_ = "personnel*"
        case pow = "POW"
    }
}
