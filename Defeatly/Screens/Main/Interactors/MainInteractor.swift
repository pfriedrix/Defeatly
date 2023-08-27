//
//  MainInteractor.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation
import Combine

protocol MainBusinessLogic: AnyObject {
    func getLimits()
    func getByDay(by day: Date, isPrevDay: Bool)
}

class MainInteractor: MainBusinessLogic {
    var presenter: MainPresentationLogic?
    var repo: DataRepository
    
    var store = Set<AnyCancellable>()
    
    init(repo: DataRepository) {
        self.repo = repo
    }
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func getLimits() {
        repo.personnelsSubscribe { [ weak self ] _ in
            if let limits = self?.repo.getLimits(.equipment) {
                self?.presenter?.presentLimits(dates: limits)
            }
        }
        .store(in: &store)
        repo.equipmentsSubscribe { [ weak self ] _ in
            if let limits = self?.repo.getLimits(.personnel) {
                self?.presenter?.presentLimits(dates: limits)
            }
        }
        .store(in: &store)
    }
    
    func getByDay(by day: Date, isPrevDay: Bool) {
        let dateString = formatter.string(from: day)
        guard let personnel: APIPersonnel = repo.getByDateString(dateString: dateString),
              let equipment: APIEquipment = repo.getByDateString(dateString: dateString) else {
            if !isPrevDay, let prevDay = Calendar.current.date(byAdding: .day, value: -1, to: day) {
                getByDay(by: prevDay, isPrevDay: true)
            }
            return
        }

        let model = MainModel(
            date: dateString,
            personnel: personnel.personnel,
            day: personnel.day,
            aircraft: equipment.aircraft,
            helicopter: equipment.helicopter,
            tank: equipment.tank,
            apc: equipment.apc,
            fieldArtillery: equipment.fieldArtillery,
            mrl: equipment.mrl,
            militaryAuto: equipment.militaryAuto,
            fuelTank: equipment.fuelTank,
            drone: equipment.antiAircraftWarfare,
            navalShip: equipment.drone,
            antiAircraftWarfare: equipment.navalShip,
            specialEquipment: equipment.specialEquipment,
            mobileSRBMSystem: equipment.mobileSRBMSystem,
            vehiclesAndFuelTanks: equipment.vehiclesAndFuelTanks,
            cruiseMissiles: equipment.cruiseMissiles
        )
        
        if isPrevDay {
            presenter?.presentPrevData(model: model)
        } else {
            presenter?.presentData(model: model)
        }
        
    }
}
