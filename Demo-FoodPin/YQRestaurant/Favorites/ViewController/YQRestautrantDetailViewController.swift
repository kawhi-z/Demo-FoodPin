//
//  YQRestautrantDetailViewController.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/7.
//

import UIKit

class YQRestautrantDetailViewController: UIViewController {

    var restaurant: RestaurantMO!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(restaurant: RestaurantMO) {
        super.init(nibName: nil, bundle: nil)
        self.restaurant = restaurant
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


