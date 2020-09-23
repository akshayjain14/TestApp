//
//  ModelDataRequest.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation

final class ModelDataRequest {

private let apiClient: NetworkServices!
typealias CompletionHandler = (_ success:Bool) -> Void

init(apiClient: NetworkServices) {
self.apiClient = apiClient
}

func getImageModelData(UrlString:String, completion: @escaping ((Result<ImageModel>) -> Void)) {

let resource = Resource(url: URL(string:UrlString)!)
apiClient.apiCall(resource) { (result) in
    switch result {
    case .success(let data):
        do {
            guard let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
                return
            }
            let items = try JSONDecoder().decode(ImageModel.self, from: utf8Data)
            DispatchQueue.main.async {
                completion(.success(items))
            }
        } catch {
            completion(.failure(error))
        }
    case .failure(let error):
        completion(.failure(error))
    }
}
}
}
