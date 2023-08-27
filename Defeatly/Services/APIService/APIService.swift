//
//  APIRequest.swift
//  Defeatly
//
//  Created by Pfriedrix on 22.08.2023.
//

import Foundation

protocol APIService: AnyObject {
    func fetchList<T: Codable>(with page: Page, completion: @escaping(Result<T, Error>) -> Void)
}

enum APIServiceError: Error {
    case invalidData, invalidResponse, invalidModel(Error)
}

class API: APIService {
    private let session: URLSession
    static let shared = API()
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        session = URLSession(configuration: configuration)
    }
    
    func fetchList<T: Codable>(with page: Page, completion: @escaping(Result<T, Error>) -> Void) {
        let result = APIRequest.shared.buildURL(page)
        switch result {
        case .success(let url):
            session.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                    completion(.failure(APIServiceError.invalidResponse))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(APIServiceError.invalidData))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(APIServiceError.invalidModel(error)))
                }
            }.resume()
        case .failure(let error): completion(.failure(error))
        }
    }
    
    func testPersonnel() {
        fetchList(with: .personnel) { (result: Result<[APIPersonnel], Error>) in
            switch result {
            case .success(let personnels):
                print(personnels.isEmpty ? "ERROR: NO PERSONNELS": "PERSONNELS TEST PASSED")
            case .failure(let error): print(error.localizedDescription)
            }
        }
        fetchList(with: .personnel) { (result: Result<[APIPersonnel], Error>) in
            switch result {
            case .success(let personnels):
                print(personnels.isEmpty ? "ERROR: NO PERSONNELS": "PERSONNELS TEST PASSED")
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
    
    func testEquipment() {
        fetchList(with: .equipment) { (result: Result<[APIEquipment], Error>) in
            switch result {
            case .success(let personnels):
                print(personnels.isEmpty ? "ERROR: NO EQUIPMENTS": "EQUIPMENTS TEST PASSED")
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
