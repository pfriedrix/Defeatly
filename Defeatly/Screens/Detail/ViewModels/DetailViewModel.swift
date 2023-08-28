//
//  DetailViewModel.swift
//  Defeatly
//
//  Created by Pfriedrix on 28.08.2023.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var losses = [Loss]()
    @Published var totalValue: Int = 0
    @Published var equipmentModels = [EquipmentModel]()
    
}
