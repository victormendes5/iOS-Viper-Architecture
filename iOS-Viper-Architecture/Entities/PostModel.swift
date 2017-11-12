//
//  PostModel.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 18/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

import Foundation

struct PostModel: Codable {
    
    var id: Int
    var title: String
    var imageUrl: String
    var thumbImageUrl: String
    
    private enum CodingKeys : String, CodingKey {
        case id, title, imageUrl = "url", thumbImageUrl = "thumbUrl"
    }
    
}

