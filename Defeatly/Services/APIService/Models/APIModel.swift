//
//  APIModel.swift
//  Defeatly
//
//  Created by Pfriedrix on 27.08.2023.
//

import Foundation

struct APIModel: Codable {
    let equipmentOryx, model: String
    let manufacturer: String
    let lossesTotal: Int
    let equipmentUA: String
    
    enum CodingKeys: String, CodingKey {
        case equipmentOryx = "equipment_oryx"
        case model, manufacturer
        case lossesTotal = "losses_total"
        case equipmentUA = "equipment_ua"
    }
}
