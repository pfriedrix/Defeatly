//
//  DetailPresenter.swift
//  Defeatly
//
//  Created by Pfriedrix on 28.08.2023.
//

import Foundation

protocol DetailPresentationLogic: AnyObject {
    func presentTotalValue(value: Int)
    func presentEquipmentModels(models: [EquipmentModel])
}

class DetailPresenter: DetailPresentationLogic {
    var view: DetailDisplayLogic?
    
    func presentTotalValue(value: Int) {
        view?.displayTotalValue(value: value)
    }
    
    func presentEquipmentModels(models: [EquipmentModel]) {
        view?.displayEquipmentModels(models: models)
    }
}
