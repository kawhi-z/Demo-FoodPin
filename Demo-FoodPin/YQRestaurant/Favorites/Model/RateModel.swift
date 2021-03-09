//
//  RateModel.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/7.
//

import Foundation

class RateModel {
    var title: String
    var image: String
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
    
    convenience init() {
        self.init(title: "", image: "")
    }
}
