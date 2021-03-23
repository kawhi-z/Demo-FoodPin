//
//  YQResturantTableViewController.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/7.
//

import UIKit
import CoreData

class YQResturantTableViewController: UIViewController {

    var searchController : UISearchController!
    
    var fetchResultController: NSFetchedResultsController<RestaurantMO>!
    
    var resturantView : YQRestaurtantView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Resturant"
        self.view.backgroundColor = .systemBlue
        ///
    }
}
