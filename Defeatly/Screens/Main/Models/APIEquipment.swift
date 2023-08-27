//
//  Equipment.swift
//  Defeatly
//
//  Created by Pfriedrix on 24.08.2023.
//

import Foundation

struct APIEquipment: Dateable {
    var date: String
    var day, aircraft, helicopter, tank: Int
    var apc, fieldArtillery, mrl: Int
    var militaryAuto, fuelTank: Int?
    var drone, navalShip, antiAircraftWarfare: Int
    var specialEquipment, mobileSRBMSystem: Int?
    var greatestLossesDirection: String?
    var vehiclesAndFuelTanks, cruiseMissiles: Int?
    
    enum CodingKeys: String, CodingKey {
        case date, day, aircraft, helicopter, tank
        case apc = "APC"
        case fieldArtillery = "field artillery"
        case mrl = "MRL"
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case greatestLossesDirection = "greatest losses direction"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
}
