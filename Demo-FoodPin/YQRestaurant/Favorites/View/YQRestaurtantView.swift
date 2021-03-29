//
//  YQResturtantView.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/7.
//

import UIKit
import CoreData

class YQRestaurtantView: UIView , UITableViewDataSource, UITableViewDelegate{

    let celldentifiter = "YQResturantCellTableViewCell"

    var restaurantInfoArray : [RestaurantMO]!
    
    var searchResults : [RestaurantMO]!
    
    var mainTableView : UITableView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTableView() {
        mainTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.frame.width , height: self.frame.height) , style: UITableView.Style.plain)
        mainTableView.backgroundColor = .white
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(YQRestaurantCellTableViewCell.self, forCellReuseIdentifier: celldentifiter)
//        mainTableView.separatorStyle = .none


        self.addSubview(mainTableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchControllerIsActive() {
            return searchResults.count
        } else {
            return restaurantInfoArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: YQRestaurantCellTableViewCell = tableView.dequeueReusableCell(withIdentifier: celldentifiter, for: indexPath) as! YQRestaurantCellTableViewCell
        
        if indexPath.row < (searchControllerIsActive() ? searchResults.count : restaurantInfoArray.count) {
            cell.setData(restautrant: searchControllerIsActive() ? searchResults[indexPath.row] : restaurantInfoArray[indexPath.row])
            
            let restaurant = searchControllerIsActive() ? searchResults[indexPath.row] : restaurantInfoArray[indexPath.row]
            if restaurant.isVisited {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    func searchControllerIsActive() ->Bool {
        var searchIsActive = false
        if let currentVC = self.currentViewController() as? UISearchController {
            if currentVC.isActive {
                searchIsActive = true
            }
        }
        return searchIsActive
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = YQRestautrantDetailViewController.init(restaurant: searchControllerIsActive() ? searchResults[indexPath.row] : restaurantInfoArray[indexPath.row])
        
        currentNavigationController().pushViewController(detailViewController, animated: true)
    }
    
    func currentNavigationController() ->UINavigationController {
        if let appDelegate = (UIApplication.shared.delegate as? SceneDelegate) {
            return appDelegate.baseTabBarController.selectedViewController as? UINavigationController ?? UINavigationController()
        }
        return UINavigationController()
    }
    
    func currentViewController (base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) ->UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let present = base?.presentingViewController {
            return currentViewController(base: present)
        }
        return base
    }
}

