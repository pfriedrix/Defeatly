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
        guard let model: MainModel = repo.getByDateString(dateString: dateString) else {
            return
        }
        
        if !isPrevDay, let prevDay = Calendar.current.date(byAdding: .day, value: -1, to: day) {
            getByDay(by: prevDay, isPrevDay: true)
        }
        
        if isPrevDay {
            presenter?.presentPrevData(model: model)
        } else {
            presenter?.presentData(model: model)
        }
        
    }
}
