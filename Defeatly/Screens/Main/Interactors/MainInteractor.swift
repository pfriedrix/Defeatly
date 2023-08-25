//
//  MainInteractor.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

protocol MainBusinessLogin: AnyObject {
    func getLastDay()
}

class MainInteractor: MainBusinessLogin {
    var presenter: MainPresentationLogic?
    var api: APIService?
    
    private var personnels = [Personnel]() {
        didSet {
            guard let first = personnels.first,
                  let last = personnels.last,
                  let firstDate = formatter.date(from: first.date),
                  let lastDate = formatter.date(from: last.date)
            else { return }
            print(first, firstDate, last, lastDate)
            presenter?.presentFirstAndLastDaysPersonnel(dates: (firstDate, lastDate))
        }
    }
    private var equipments = [Equipment]() {
        didSet {
            guard let first = equipments.first,
                  let last = equipments.last,
                  let firstDate = formatter.date(from: first.date),
                  let lastDate = formatter.date(from: last.date)
            else { return }
            print(first, firstDate, last, lastDate)
            presenter?.presentFirstAndLastDaysEquipment(dates: (firstDate, lastDate))
        }
    }
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func getLastDay() {
        getAllPersonnelDays { [ weak self ] result in
            switch result {
            case .success(let personnels):
                self?.personnels = personnels
                guard let last = personnels.last else { return }
                self?.presenter?.presentPersonnel(personnel: last)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        getAllEquipmentDays { [ weak self ] result in
            switch result {
            case .success(let equipments):
                self?.equipments = equipments
                guard let last = equipments.last else { return }
                self?.presenter?.presentEquipment(equipment: last)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getAllPersonnelDays(completion: @escaping (Result<[Personnel], Error>) -> Void) {
        api?.fetchList(with: .personnel, completion: completion)
    }
    private func getAllEquipmentDays(completion: @escaping (Result<[Equipment], Error>) -> Void) {
        api?.fetchList(with: .equipment, completion: completion)
    }
}
