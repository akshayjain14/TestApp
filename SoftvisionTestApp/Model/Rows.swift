//
//  Rows.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation
/// Details Object Model
struct Rows: Codable {
    /// Subdetail title
    let title: String?
    /// Description for country subdetail
    let description: String?
    /// Image url path
    let imageHref: String?
 /// Coding key with respect to response parsing string
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageHref 
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        imageHref = try values.decodeIfPresent(String.self, forKey: .imageHref)
    }

}
