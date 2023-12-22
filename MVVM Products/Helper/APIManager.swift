//
//  APIManager.swift
//  MVVM Products
//
//  Created by XP India on 18/10/23.
//

import UIKit

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
}

typealias Handler<T> = (Result<T, DataError>) -> Void

// Singleton Design Pattern
// final :- inhertance can't possible

final class APIManager {
    
    static let shared = APIManager()
    
    let aPIHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    private init(aPIHandler: APIHandlerDelegate = APIHandler(),
                 responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.aPIHandler = aPIHandler
        self.responseHandler = responseHandler
    }
    
    func request<T: Codable>(modelType: T.Type,
                             type: EndPointType,
                             completion: @escaping Handler<T>) {
        
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        aPIHandler.fetchData(_with: url) { [weak self] result in
            guard let self = self else { return}
            
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: modelType, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                        
                    case .failure(let error):
                        completion(.failure(.network(error)))
                    }
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
