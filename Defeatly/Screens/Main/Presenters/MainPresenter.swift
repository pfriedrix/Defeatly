//
//  MainPresenter.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

protocol MainPresentationLogic: AnyObject {
    func presentPersonnel(personnel: Personnel)
    func presentEquipment(equipment: Equipment)
    func presentFirstAndLastDaysPersonnel(dates: (Date, Date))
    func presentFirstAndLastDaysEquipment(dates: (Date, Date))
}

class MainPresenter: MainPresentationLogic {
    var view: MainDisplayLogic?
    
    func presentPersonnel(personnel: Personnel) {
        
    }
    
    func presentEquipment(equipment: Equipment) {
        
    }
    
    func presentFirstAndLastDaysPersonnel(dates: (Date, Date)) {
        view?.displayLimitPersonnel(dates)
    }
    
    func presentFirstAndLastDaysEquipment(dates: (Date, Date)) {
        view?.displayLimitEquipment(dates)
    }
}
