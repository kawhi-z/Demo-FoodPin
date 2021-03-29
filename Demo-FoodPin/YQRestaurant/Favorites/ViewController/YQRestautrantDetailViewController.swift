//
//  YQRestautrantDetailViewController.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/7.
//

private struct Constants {
    static let nameLabelX : CGFloat = 12
    static let leftMarginOfRateButton : CGFloat = 15
}

import UIKit

class YQRestautrantDetailViewController: UIViewController {

    var restaurant: RestaurantMO!

    var detailTabelView : UITableView!
    var headerView : UIImageView!
    var headerMaskView : UIView!
    var nameLabel : UILabel!
    var typeLabel : UILabel!
    var headerImageView : UIImageView!
    var ratingImageView : UIImageView!
    
    init(restaurant: RestaurantMO) {
        super.init(nibName: nil, bundle: nil)
        self.restaurant = restaurant
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configNav()
        initDetailTableView()
    }
    
    func configNav() {
        
    }
    
    func initDetailTableView() {
        
    }
    
    
}


