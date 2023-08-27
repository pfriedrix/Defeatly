//
//  MainViewModel.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var day = Date.distantFuture
    @Published var showContent = false
    @Published var model: MainModel?
    @Published var prevModel: MainModel?
    @Published var range: ClosedRange<Date> = Date(timeIntervalSince1970: 0)...Date()
    
    var limits: (Date, Date)? {
        didSet {
            if let limits = limits {
                DispatchQueue.main.async { [ weak self ] in
                    self?.showContent = true
                    self?.day = limits.1
                    self?.range = limits.0...limits.1
                }
            }
        }
    }
    
    func getValue(by type: MainModel.CodingKeys, _ model: MainModel?) -> Int? {
        return model.flatMap { getValue(from: $0, with: type) }
    }
    
    private func getValue(from model: MainModel, with type: MainModel.CodingKeys) -> Int? {
        switch type {
        case .aircraft: return model.aircraft
        case .antiAircraftWarfare: return model.antiAircraftWarfare
        case .apc: return model.apc
        case .cruiseMissiles: return model.cruiseMissiles
        case .drone: return model.drone
        case .fieldArtillery: return model.fieldArtillery
        case .fuelTank: return model.fuelTank
        case .helicopter: return model.helicopter
        case .militaryAuto: return model.militaryAuto
        case .mobileSRBMSystem: return model.mobileSRBMSystem
        case .mrl: return model.mrl
        case .navalShip: return model.navalShip
        case .tank: return model.tank
        case .specialEquipment: return model.specialEquipment
        case .vehiclesAndFuelTanks: return model.vehiclesAndFuelTanks
        case .personnel: return model.personnel
        default: return nil
        }
    }
    
    var disableNextButton: Bool {
        guard let limitDate = limits?.1 else { return true }
        let limitDay = Calendar.current.startOfDay(for: limitDate)
        let currentDay = Calendar.current.startOfDay(for: day)
        return limitDay <= currentDay
    }
}
