//
//  APIModel.swift
//  Defeatly
//
//  Created by Pfriedrix on 27.08.2023.
//

import Foundation

struct APIEquipmentModel: Codable {
    let equipmentOryx, model: String
    let manufacturer: String
    let lossesTotal: Int
    let equipmentUA: EquipmentUA
    
    enum CodingKeys: String, CodingKey {
        case equipmentOryx = "equipment_oryx"
        case model, manufacturer
        case lossesTotal = "losses_total"
        case equipmentUA = "equipment_ua"
    }
}

enum EquipmentUA: String, Codable {
    case aircrafts = "Aircrafts"
    case antiAircraftWarfareSystems = "Anti-aircraft Warfare Systems"
    case armouredPersonnelCarriers = "Armoured Personnel Carriers"
    case artillerySystems = "Artillery Systems"
    case helicopters = "Helicopters"
    case multipleRocketLaunchers = "Multiple Rocket Launchers"
    case specialEquipment = "Special Equipment"
    case tanks = "Tanks"
    case unmannedAerialVehicles = "Unmanned Aerial Vehicles"
    case vehicleAndFuelTank = "Vehicle and Fuel Tank"
    case warshipsBoats = "Warships, Boats"
}
