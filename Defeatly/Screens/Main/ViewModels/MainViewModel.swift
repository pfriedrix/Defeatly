//
//  MainViewModel.swift
//  Defeatly
//
//  Created by Pfriedrix on 25.08.2023.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var day = Date()
    @Published var showHeader = false
    @Published var personnel: Personnel?
    @Published var equipment: Equipment?
    @Published var range: ClosedRange<Date> = Date(timeIntervalSince1970: 0)...Date()
    
    var limits: (Date, Date)? {
        didSet {
            if let limits = limits {
                DispatchQueue.main.async { [ weak self ] in
                    self?.showHeader = true
                    self?.range = limits.0...limits.1
                }
            }
        }
    }
}
