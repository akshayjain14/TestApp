//
//  ImageModel.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation
/// Root structure For API Response
struct ImageModel: Codable {
    /// Country name title
    let title: String?
     /// List of coutry detail object
    let rows: [Rows]?

    enum CodingKeys: String, CodingKey {

        case title
        case rows 
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        rows = try values.decodeIfPresent([Rows].self, forKey: .rows)
    }
}
