//
//  NetworkServices.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation
struct Resource {
let url: URL
let method: String = "GET"
}

enum Result<T> {
case success(T)
case failure(Error)
}

enum APIClientError: String, Error {
case noData = "Response returned with no data to decode."
    
}
extension URLRequest {

init(_ resource: Resource) {
    self.init(url: resource.url)
    self.httpMethod = resource.method
}

}
///Network Seervice Class
class NetworkServices: NSObject {
 /// URLsession Call to fetch data from API
func fetchData(_ resource: Resource, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(resource)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let `data` = data else {
                result(.failure(APIClientError.noData))
                return
            }
            if let `error` = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    
}
}
