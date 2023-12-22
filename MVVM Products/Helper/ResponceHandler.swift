//
//  ResponceHandler.swift
//  MVVM Products
//
//  Created by XP India on 20/12/23.
//

import Foundation

protocol ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: @escaping Handler<T>)
}

class ResponseHandler: ResponseHandlerDelegate {
    func fetchModel<T: Codable>(type: T.Type, data: Data, completion: @escaping Handler<T>) {
        let success = try? JSONDecoder().decode(type.self, from: data)
        if let success {
            completion(.success(success))
        } else {
            completion(.failure(.invalidData))
        }
    }
}
