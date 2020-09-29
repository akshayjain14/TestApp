//
//  Rows.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation
struct Rows: Codable {
    let title: String?
    let description: String?
    let imageHref: String?

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
