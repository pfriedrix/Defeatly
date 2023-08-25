//
//  MainView+MainDisplayLogic.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

protocol MainDisplayLogic {
    func displayPersonnel(personnel: Personnel)
    func displayEquipment(equipment: Equipment)
    func displayLimitPersonnel(_ dates: (Date, Date))
    func displayLimitEquipment(_ dates: (Date, Date))
}

extension MainView: MainDisplayLogic {
    func displayLimitPersonnel(_ dates: (Date, Date)) {
        if let oldLimits = viewModel.limits {
            viewModel.limits?.0 = oldLimits.0 > dates.0 ? dates.0 : oldLimits.0
            viewModel.limits?.1 = oldLimits.1 < dates.1 ? dates.1 : oldLimits.1
        } else {
            viewModel.limits = dates
        }
    }
    
    func displayLimitEquipment(_ dates: (Date, Date)) {
        if let oldLimits = viewModel.limits {
            viewModel.limits?.0 = oldLimits.0 > dates.0 ? dates.0 : oldLimits.0
            viewModel.limits?.1 = oldLimits.1 < dates.1 ? dates.1 : oldLimits.1
        } else {
            viewModel.limits = dates
        }
    }
    
    func displayPersonnel(personnel: Personnel) {
        
    }
    func displayEquipment(equipment: Equipment) {
        
    }
}
