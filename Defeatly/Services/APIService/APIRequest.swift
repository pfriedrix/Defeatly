//
//  APIRequest.swift
//  Defeatly
//
//  Created by Pfriedrix on 24.08.2023.
//

import Foundation

enum Page: String {
    case equipment = "russia_losses_equipment",
         personnel = "russia_losses_personnel",
         oryx = "russia_losses_equipment_oryx"
}

enum APIRequestError: Error {
    case invalidURL
}

class APIRequest {
    static let shared = APIRequest()
    private static let baseURLString = "https://raw.githubusercontent.com/PetroIvaniuk/2022-Ukraine-Russia-War-Dataset/main/data/"
    
    private init() { }
    
    func buildURL(_ page: Page) -> Result<URL, Error> {
        let urlString = APIRequest.baseURLString + "\(page.rawValue).json"
        if let url = URL(string: urlString) {
            return .success(url)
        } else {
            return .failure(APIRequestError.invalidURL)
        }
    }
}
