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

class YQRestautrantDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    public var restaurant: RestaurantMO!
    
    private lazy var detailTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.register(YQRestaurantDetailIconTextCell.self, forCellReuseIdentifier: String(describing: YQRestaurantDetailIconTextCell.self))
        table.register(YQReataurantDetailMapCell.self, forCellReuseIdentifier: String(describing: YQReataurantDetailMapCell.self))
        table.register(YQReataurantDetailTextCell.self, forCellReuseIdentifier: String(describing: YQReataurantDetailTextCell.self))
        table.contentInsetAdjustmentBehavior = .never
        return table
    }()
    
    private lazy var headerView: UIImageView = {
        let header = UIImageView()
        header.contentMode = .scaleAspectFill
        header.layer.masksToBounds = true
        return header
    }()
    
    private lazy var headerMaskView: UIView = {
        let mask = UIView()
        mask.backgroundColor = .black
        mask.alpha = 0.2
        return mask
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 35)
        label.text = restaurant.name
        label.textColor = .white
        label.sizeToFit()
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.text = restaurant.type
        label.textColor = .white
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = .orange
        return label
    }()
    
    private lazy var heartImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "heart-tick")
        image.isHidden = !restaurant.isVisited
        return image
    }()
    
    private  var ratingImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
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
        view.addSubview(detailTableView)
        initHeaderView()
        initFooterView()
    }
    
    private func initHeaderView() {
        headerView.addSubview(headerMaskView)
        headerView.addSubview(typeLabel)
        headerView.addSubview(heartImageView)
//        heartImageView.isHidden = !restaurant.isVisited
        headerView.addSubview(nameLabel)
        refreshRatingImageView(rateImage: restaurant.rating!)
        headerView.addSubview(ratingImageView)
        
        detailTableView.tableHeaderView = headerView
    }

    private func initFooterView() {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth(), height: 100))
        
        let rateButton = UIButton(frame: CGRect(x: Constants.leftMarginOfRateButton, y: 0, width: footerView.width() - Constants.leftMarginOfRateButton * 2, height: 47))
        rateButton.center = CGPoint(x: rateButton.center.x, y: footerView.height() * 0.5)
        rateButton.setTitle("Rate it", for: .normal)
        rateButton.titleLabel?.font = .boldSystemFont(ofSize: 18)
        rateButton.titleLabel?.textColor = .white
        rateButton.backgroundColor = .red
        rateButton.layer.masksToBounds = true
        rateButton.layer.cornerRadius = rateButton.frame.height * 0.5
        rateButton.addTarget(self, action: #selector(handleClickRateButton), for: .touchUpInside)
        footerView.addSubview(rateButton)
        
        detailTableView.tableFooterView = footerView
    }

    private func refreshRatingImageView(rateImage: String) {
        self.restaurant.rating = rateImage
        self.ratingImageView.image = UIImage(named: rateImage)
        self.ratingImageView.sizeToFit()
        self.view.setNeedsLayout()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantDetailIconTextCell.self), for: indexPath) as! YQRestaurantDetailIconTextCell
            cell.render(withData: "phone", detailText: restaurant.phone!)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQRestaurantDetailIconTextCell.self), for: indexPath) as! YQRestaurantDetailIconTextCell
            cell.render(withData: "map", detailText: restaurant.location!)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQReataurantDetailTextCell.self), for: indexPath) as! YQReataurantDetailTextCell
            cell.render(withData: restaurant.summary!)
            cell.selectionStyle = .none
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: YQReataurantDetailMapCell.self), for: indexPath) as! YQReataurantDetailMapCell
//            cell.
            cell.selectionStyle = .none
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controoler")
        }

    }
    
    
    @objc func handleClickRateButton() {
        
    }
        
}


