//
//  MainModel.swift
//  Defeatly
//
//  Created by Pfriedrix on 27.08.2023.
//

import Foundation

protocol Dateable: Codable {
    var date: String { get set }
}

struct MainModel: Dateable {
    var date: String
    var personnel: Int
    var day, aircraft, helicopter, tank: Int
    var apc, fieldArtillery, mrl: Int
    var militaryAuto, fuelTank: Int?
    var drone, navalShip, antiAircraftWarfare: Int
    var specialEquipment, mobileSRBMSystem: Int?
    var vehiclesAndFuelTanks, cruiseMissiles: Int?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case date, personnel, day, aircraft, helicopter, tank
        case apc, fieldArtillery, mrl, militaryAuto, fuelTank
        case drone, navalShip, antiAircraftWarfare
        case specialEquipment, mobileSRBMSystem, vehiclesAndFuelTanks, cruiseMissiles
    }
}
