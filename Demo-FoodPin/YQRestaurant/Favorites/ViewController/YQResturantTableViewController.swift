//
//  YQResturantTableViewController.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/7.
//

import UIKit
import CoreData

class YQResturantTableViewController: UIViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
   
    var searchController : UISearchController!
    
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    
    var resturantView : YQRestaurtantView!
    
    var resturantInfoArray : [RestaurantMO] = []
    
    var searchResult : [RestaurantMO] = []
    // Resturant 是一个过渡的 model，不是最终使用的 model
    // ResturantMO 才是最终 view 使用的model ，结合 coreData 可以持久化
    var restaurantOriginalArray: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "232-923423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at 9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "cafedeadend.jpg", isVisited: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phone: "348-233423", description: "A little gem hidden at the corner of the street is nothing but fantastic! This place is warm and cozy. We open at 7 every morning except Sunday, and close at 9 PM. We offer a variety of coffee drinks and specialties including lattes, cappuccinos, teas, and more. We serve breakfast, lunch, and dinner in an airy open setting. Come over, have a coffee and enjoy a chit-chat with our baristas.", image: "homei.jpg", isVisited: false)]
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Resturant"
        self.view.backgroundColor = .systemBlue
        
        initData()
        
        configNav()
        
        initSearchBar()
        initResturantView()
        
    }
    
    func initData() {
        for index in 0...restaurantOriginalArray.count - 1 {
            let resatutrantOriginal = restaurantOriginalArray[index]
            
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let restaurantMO = RestaurantMO(context: appDelegate.persisentContainer.viewContext)
                
                restaurantMO.name = resatutrantOriginal.name
                restaurantMO.type = resatutrantOriginal.type
                restaurantMO.location = resatutrantOriginal.location
                restaurantMO.phone = resatutrantOriginal.phone
                restaurantMO.summary = resatutrantOriginal.description
                restaurantMO.rating = ""
                if let restaurantImage = UIImage(named: resatutrantOriginal.name) {
                    let imageData = restaurantImage.pngData()
                    restaurantMO.image = imageData
                }
                restaurantMO.isVisited = resatutrantOriginal.isVisited
                resturantInfoArray.append(restaurantMO)
            }
            
        }
    }
    
    func configNav() {
        navigationController?.navigationBar.topItem?.title = " Food Pin"
        
        navigationController?.navigationBar.tintColor = UIColor.orange

        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        if let customFont = UIFont(name: "PingFangSC-Medium", size: 40.0) {
            navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.orange,
                                                                            NSAttributedString.Key.font : customFont]
        }
        
        let leftItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = leftItem
        
        let rightItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handleClickRightButton))
        self.navigationItem.rightBarButtonItem = rightItem
        
        navigationController?.hidesBarsOnSwipe = false
    }
    
    func initSearchBar() {
        searchController = UISearchController.init(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search restaurants..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.tintColor = .orange
        
        self.navigationItem.searchController = searchController
        
    }
    
    func initResturantView() {
        resturantView = YQRestaurtantView.init(frame: CGRect(x: 0, y: 0, width: self.view.width(), height: self.view.height()))
        resturantView?.restaurantInfoArray = self.resturantInfoArray
        self.view.addSubview(resturantView!)
    }
    
    @objc func handleClickRightButton() {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
