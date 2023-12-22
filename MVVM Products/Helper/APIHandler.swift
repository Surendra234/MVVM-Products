//
//  APIHandler.swift
//  MVVM Products
//
//  Created by XP India on 20/12/23.
//

import Foundation

protocol APIHandlerDelegate {
    func fetchData(_with url: URL, completion: @escaping Handler<Data>)
}

class APIHandler: APIHandlerDelegate {
    func fetchData(_with url: URL, completion: @escaping Handler<Data>) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
