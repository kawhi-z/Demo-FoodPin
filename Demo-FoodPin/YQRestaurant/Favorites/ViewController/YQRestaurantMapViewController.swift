//
//  YQRestaurantMapViewController.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/4/4.
//

import UIKit
import MapKit


// Swift 添加常量的方法
private struct MapViewControllerConstants {
    static let leftMarginOfCloseButton: CGFloat = 20
    static let widthOfCloseButton: CGFloat = 22

}

class YQRestaurantMapViewController: UIViewController,MKMapViewDelegate {
    var restaurant: RestaurantMO!

    private lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.delegate = self
        map.showsTraffic = true
        map.showsScale = true
        map.showsCompass = true
        return map
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
        configure()
    }
    
    private func initSubviews() {
        view.addSubview(mapView)
        view.addSubview(closeButton)
    }

    func configure() {
        let geoCoder = CLGeocoder()
        
        print(restaurant.location!)
        
        geoCoder.geocodeAddressString(restaurant.location!, completionHandler: {placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                // Add annnotation
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 250, longitudinalMeters: 250)
                    self.mapView.setRegion(region, animated: false)
                }
            }
        })
    }
    
    @objc func handleCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        mapView.frame = CGRect(x: 0, y: 0, width: ScreenWidth(), height: ScreenHeight())
        closeButton.frame = CGRect(x: UIScreen.main.bounds.width - MapViewControllerConstants.leftMarginOfCloseButton - MapViewControllerConstants.widthOfCloseButton, y: 30, width: MapViewControllerConstants.widthOfCloseButton, height: MapViewControllerConstants.widthOfCloseButton)
    }

}
