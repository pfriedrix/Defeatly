//
//  MainView+MainDisplayLogic.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

protocol MainDisplayLogic {
    func displayData(model: MainModel)
    func displayPrevData(model: MainModel)
    func displayLimits(_ dates: (Date, Date))
}

extension MainView: MainDisplayLogic {
    
    func displayData(model: MainModel) {
        DispatchQueue.main.async {
            viewModel.model = model
        }
    }
    
    func displayPrevData(model: MainModel) {
        DispatchQueue.main.async {
            viewModel.prevModel = model
        }
    }
    
    func displayLimits(_ dates: (Date, Date)) {
        if let oldLimits = viewModel.limits {
            viewModel.limits?.0 = oldLimits.0 > dates.0 ? dates.0 : oldLimits.0
            viewModel.limits?.1 = oldLimits.1 < dates.1 ? dates.1 : oldLimits.1
        } else {
            viewModel.limits = dates
        }
    }
}
