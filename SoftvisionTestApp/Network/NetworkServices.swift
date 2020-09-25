//
//  NetworkServices.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation

class NetworkServices: NSObject {

func apiToData(completion : @escaping (ImageModel) -> ()) {
    
    guard let url = URL(string: CONSTANT.BASEURL.rawValue) else {
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, urlResponse, error) in
           if let data = data {
               
               let jsonDecoder = JSONDecoder()
               guard let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
                   return
               }
            
               let fetchedData = try! jsonDecoder.decode(ImageModel.self, from: utf8Data)
           
            completion(fetchedData)
           }
           
       }.resume()
   }
    
    
    
}
