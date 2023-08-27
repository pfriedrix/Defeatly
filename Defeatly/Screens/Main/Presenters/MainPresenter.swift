//
//  MainPresenter.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

protocol MainPresentationLogic: AnyObject {
    func presentData(model: MainModel)
    func presentPrevData(model: MainModel)
    func presentLimits(dates: (Date, Date))
}

class MainPresenter: MainPresentationLogic {
    var view: MainDisplayLogic?

    func presentData(model: MainModel) {
        view?.displayData(model: model)
    }
    
    func presentPrevData(model: MainModel) {
        view?.displayPrevData(model: model)
    }
    
    func presentLimits(dates: (Date, Date)) {
        view?.displayLimits(dates)
    }
}
