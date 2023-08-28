//
//  DetailInteractor.swift
//  Defeatly
//
//  Created by Pfriedrix on 28.08.2023.
//

import Foundation

protocol DetailBusinessLogic: AnyObject {
    func getEquipmentLosses(type: MainModel.CodingKeys)
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
    
    func getEquipmentLosses(type: MainModel.CodingKeys) {
//        let losses = repo.equipments.compactMap {
//            return EquipmentLosses(date: $0.date, value: $0[keyPath: ])
//        }
    }
}
