//
//  MainViewModel.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var day = Date.distantFuture
    @Published var showContent = false
    @Published var model: MainModel?
    @Published var prevModel: MainModel?
    @Published var range: ClosedRange<Date> = Date(timeIntervalSince1970: 0)...Date()
    
    var limits: (Date, Date)? {
        didSet {
            if let limits = limits {
                DispatchQueue.main.async { [ weak self ] in
                    self?.showContent = true
                    self?.day = limits.1
                    self?.range = limits.0...limits.1
                }
            }
        }
    }

    var disableNextButton: Bool {
        guard let limitDate = limits?.1 else { return true }
        let limitDay = Calendar.current.startOfDay(for: limitDate)
        let currentDay = Calendar.current.startOfDay(for: day)
        return limitDay <= currentDay
    }
}
