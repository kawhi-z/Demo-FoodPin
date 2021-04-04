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
        if let restaurantImage = restaurant.image {
            header.image = UIImage(data: restaurantImage as Data)
        }
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
//        image.isHidden = !restaurant.isVisited
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
        navigationItem.largeTitleDisplayMode = .never
        
        navigationController?.isNavigationBarHidden = false
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = UIColor.white
        
        self.hidesBottomBarWhenPushed = true
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
        heartImageView.isHidden = !restaurant.isVisited
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
            cell.selectionStyle = .none
            cell.render(withData: restaurant)
            return cell
        default:
            fatalError("Failed to instantiate the table view cell for detail view controoler")
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return YQRestaurantDetailIconTextCell.heightForIconTextCell(image: "photo", text: restaurant.phone!)
        case 1:
            return YQRestaurantDetailIconTextCell.heightForIconTextCell(image: "map", text: restaurant.location!)
        case 2:
            return YQReataurantDetailTextCell.heightForTextCell(restaurant: restaurant)
        case 3:
            return YQReataurantDetailMapCell.heightForMapCell()
        default:
            fatalError("Failed to instantiate the table view cell for detail view controoler")
        }
    }
    
    override func viewDidLayoutSubviews() {
        typeLabel.sizeToFit()
        nameLabel.sizeToFit()
        
        detailTableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth(), height: ScreenHeight())
        headerView.frame = CGRect(x: 0, y: 0, width: ScreenWidth(), height: 350)
        headerMaskView.frame = headerView.bounds
        heartImageView.frame = CGRect(x: typeLabel.frame.maxX + 6, y: 0, width: 15, height: 15)
        typeLabel.frame = CGRect(x: Constants.nameLabelX, y: headerView.frame.height - 15 - typeLabel.frame.height, width: typeLabel.frame.width + 10, height: typeLabel.frame.height)
        nameLabel.frame = CGRect(x: Constants.nameLabelX, y: typeLabel.frame.origin.y - 6 - nameLabel.frame.height, width: headerView.frame.width - Constants.nameLabelX - Constants.nameLabelX, height: nameLabel.frame.height)
        
        ratingImageView.frame = CGRect(x: ScreenWidth() - ratingImageView.width(), y: headerView.height() - ratingImageView.height(), width: ratingImageView.width(), height: ratingImageView.height())
        
    }
    
    @objc func handleClickRateButton() {
        
    }
        
}


