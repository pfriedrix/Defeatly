//
//  DetailView+DetailDisplayLogic.swift
//  Defeatly
//
//  Created by Pfriedrix on 28.08.2023.
//

import Foundation

protocol DetailDisplayLogic {
    func displayTotalValue(value: Int)
    func displayEquipmentModels(models: [EquipmentModel])
}

extension DetailView: DetailDisplayLogic {
    func displayTotalValue(value: Int) {
        viewModel.totalValue = value
    }
    
    func displayEquipmentModels(models: [EquipmentModel]) {
        viewModel.equipmentModels = models
    }
}
