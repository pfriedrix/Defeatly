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
        case date, personnel, day, aircraft = "aircrafts", helicopter = "helicopters", tank = "tanks"
        case apc
        case fieldArtillery = "field artillery"
        case mrl
        case militaryAuto = "military auto"
        case fuelTank = "fuel tank"
        case drone
        case navalShip = "naval ship"
        case antiAircraftWarfare = "anti-aircraft warfare"
        case specialEquipment = "special equipment"
        case mobileSRBMSystem = "mobile SRBM system"
        case vehiclesAndFuelTanks = "vehicles and fuel tanks"
        case cruiseMissiles = "cruise missiles"
    }
    
    func getValue(with type: MainModel.CodingKeys) -> Int? {
        switch type {
        case .aircraft: return self.aircraft
        case .antiAircraftWarfare: return self.antiAircraftWarfare
        case .apc: return self.apc
        case .cruiseMissiles: return self.cruiseMissiles
        case .drone: return self.drone
        case .fieldArtillery: return self.fieldArtillery
        case .fuelTank: return self.fuelTank
        case .helicopter: return self.helicopter
        case .militaryAuto: return self.militaryAuto
        case .mobileSRBMSystem: return self.mobileSRBMSystem
        case .mrl: return self.mrl
        case .navalShip: return self.navalShip
        case .tank: return self.tank
        case .specialEquipment: return self.specialEquipment
        case .vehiclesAndFuelTanks: return self.vehiclesAndFuelTanks
        case .personnel: return self.personnel
        default: return nil
        }
    }
}
