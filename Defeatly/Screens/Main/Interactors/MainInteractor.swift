//
//  MainInteractor.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

protocol MainBusinessLogic: AnyObject {
    func getLimits()
    func getByDay(by day: Date, isPrevDay: Bool)
}

class MainInteractor: MainBusinessLogic {
    var presenter: MainPresentationLogic?
    var api: APIService
    
    init(api: APIService) {
        self.api = api
        fetchPersonnelData()
        fetchEquipmentData()
    }
    
    private var personnels = [APIPersonnel]() {
        didSet {
            getLimits(personnels)
        }
    }
    
    private var equipments = [APIEquipment]() {
        didSet {
            getLimits(equipments)
        }
    }
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func getLimits() {
        getLimits(personnels)
        getLimits(equipments)
    }
    
    func getLimits(_ models: [Dateable]) {
        guard
            let first = models.first,
            let last = models.last,
            let firstDate = formatter.date(from: first.date),
            let lastDate = formatter.date(from: last.date)
        else { return }
        presenter?.presentLimits(dates: (firstDate, lastDate))
    }
    
    func getByDay(by day: Date, isPrevDay: Bool) {
        let dateString = formatter.string(from: day)
        guard let personnel = personnels.first(where: { $0.date == dateString }),
              let equipment = equipments.first(where: { $0.date == dateString }) else {
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
    
    private func fetchPersonnelData() {
        api.fetchList(with: .personnel) { [weak self] (result: Result<[APIPersonnel], Error>) in
            switch result {
            case .success(let personnels):
                self?.personnels = personnels
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchEquipmentData() {
        api.fetchList(with: .equipment) { [weak self] (result: Result<[APIEquipment], Error>) in
            switch result {
            case .success(let equipments):
                self?.equipments = equipments
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
