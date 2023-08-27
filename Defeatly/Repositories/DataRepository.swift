//
//  DataRepository.swift
//  Defeatly
//
//  Created by Pfriedrix on 27.08.2023.
//

import Foundation
import Combine

protocol DataRepository {
    func setSource(_ source: APIService)
    func getLimits(_ page: Page) -> (Date, Date)?
    func getByDateString<T: Dateable>(dateString: String) -> T?
    func personnelsSubscribe(_ subscriber: @escaping (Bool) -> Void) -> AnyCancellable
    func equipmentsSubscribe(_ subscriber: @escaping (Bool) -> Void) -> AnyCancellable
    func modelsSubscribe(_ subscriber: @escaping (Bool) -> Void) -> AnyCancellable
}

class DefaultDataRepository: DataRepository {
    static let shared: DataRepository = DefaultDataRepository()
    
    @Published var isPersonnelsLoaded = false
    @Published var isEquipmentsLoaded = false
    @Published var isModelsLoaded = false
    
    private var personnels = [APIPersonnel]()
    private var equipments = [APIEquipment]()
    private var models = [APIModel]()
    
    private var api: APIService? {
        didSet {
            fetchAll()
        }
    }
    
    func setSource(_ source: APIService) {
        api = source
    }
    
    func getLimits(_ page: Page) -> (Date, Date)? {
        switch page {
        case .equipment: return processDateableModels(equipments)
        case .personnel: return processDateableModels(personnels)
        case .oryx: return nil
        }
    }
    
    func getByDateString<T: Dateable>(dateString: String) -> T? {
        if let equipment = equipments.first(where: { $0.date == dateString }) as? T {
            return equipment
        }
        
        if let personnel = personnels.first(where: { $0.date == dateString }) as? T {
            return personnel
        }
        
        return nil
    }
    
    func personnelsSubscribe(_ subscriber: @escaping (Bool) -> Void) -> AnyCancellable {
        return $isPersonnelsLoaded.sink {
            subscriber($0)
        }
    }
    
    func equipmentsSubscribe(_ subscriber: @escaping (Bool) -> Void) -> AnyCancellable {
        return $isEquipmentsLoaded.sink {
            subscriber($0)
        }
    }
    
    func modelsSubscribe(_ subscriber: @escaping (Bool) -> Void) -> AnyCancellable {
        return $isModelsLoaded.sink {
            subscriber($0)
        }
    }
    
    private func processDateableModels<T: Dateable>(_ models: [T]) -> (Date, Date)? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let sortedModels = models.compactMap {
            dateFormatter.date(from: $0.date)
        }.sorted { date1, date2 in
            date1 < date2
        }
        guard let first = sortedModels.first, let last = sortedModels.last else { return nil }
        return (first, last)
    }
    
    private init() { }
    
    private func fetchAll() {
        isPersonnelsLoaded = false
        isEquipmentsLoaded = false
        isModelsLoaded = false
        
        fetchPersonnels { [ weak self ] result in
            guard let self = self else { return }
            self.handleData(in: &self.personnels, by: result)
            isPersonnelsLoaded = true
        }
        fetchEquipments { [ weak self ] result in
            guard let self = self else { return }
            self.handleData(in: &self.equipments, by: result)
            isEquipmentsLoaded = true
        }
        fetchModels { [ weak self ] result in
            guard let self = self else { return }
            self.handleData(in: &self.models, by: result)
            isModelsLoaded = true
        }
    }
    
    private func handleData<T: Codable>(in array: inout [T], by result: Result<[T], Error>) {
        switch result {
        case .success(let data): array = data
        case .failure(let error): print(error.localizedDescription)
        }
    }
    
    private func fetchPersonnels(completion: @escaping (Result<[APIPersonnel], Error>) -> Void) {
        api?.fetchList(with: .personnel, completion: completion)
    }
    
    private func fetchEquipments(completion: @escaping (Result<[APIEquipment], Error>) -> Void) {
        api?.fetchList(with: .equipment, completion: completion)
    }
    
    private func fetchModels(completion: @escaping (Result<[APIModel], Error>) -> Void) {
        api?.fetchList(with: .oryx, completion: completion)
    }
}
