//
//  MenuModel.swift
//  Peretz
//
//  Created by Рамазан on 28.08.2020.
//  Copyright © 2020 Рамазан. All rights reserved.
//

import Foundation

struct MenuItem: Codable {
    var id: Int
    //var date: String
    var name: String
    var description: String
    var new: Bool
    //var variations: []
    var price: Int
    //var image_app: String
    var image: String
    //var sort: Int
}
