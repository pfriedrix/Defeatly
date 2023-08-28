//
//  DetailInteractor.swift
//  Defeatly
//
//  Created by Pfriedrix on 28.08.2023.
//

import Foundation

protocol DetailBusinessLogic: AnyObject {
    func getLosses(type: MainModel.CodingKeys)
    func getTotalValue(type: MainModel.CodingKeys)
    func getModels(type: MainModel.CodingKeys)
}

class DetailInteractor: DetailBusinessLogic {
    var presenter: DetailPresentationLogic?
    var repo: DataRepository
    
    init(repo: DataRepository) {
        self.repo = repo
    }
    
    func getTotalValue(type: MainModel.CodingKeys) {
        guard let last = repo.models.last, let total = last.getValue(with: type) else { return }
        presenter?.presentTotalValue(value: total)
    }
    
    func getModels(type: MainModel.CodingKeys) {
        let models = repo.getModelsByType(type: type).sorted { $0.total > $1.total }
        presenter?.presentEquipmentModels(models: models)
    }
    
    func getLosses(type: MainModel.CodingKeys) {
        let lastDays = repo.models.suffix(7).compactMap { model in
            if let value = model.getValue(with: type), let prev = repo.models.first(where: {
                $0.day == model.day - 1
            })?.getValue(with: type) {
                let diff = abs(value - prev)
                return Loss(date: String(model.date.suffix(5)), value: diff)
            }
            return Loss(date: String(model.date.suffix(5)), value: 0)
        }
        presenter?.presentLosses(losses: lastDays)
    }
}
