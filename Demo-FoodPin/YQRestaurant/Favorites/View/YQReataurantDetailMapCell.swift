//
//  YQReataurantDetailMapCell.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/29.
//

import UIKit
import MapKit

// Swift 添加常量的方法
private struct DetailMapCellConstants {
    static let leftMarginOfLabel: CGFloat = 12
    static let topMarginOfLabel: CGFloat = 10
    static let marginOfTitleAndSeparator: CGFloat = 6
    static let heightOfMapView: CGFloat = 215
}

class YQReataurantDetailMapCell: UITableViewCell {

    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "HOW TO GET HERE"
        label.sizeToFit()
        return label
    }()
    
    private lazy var separatorView : UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var mapView : MKMapView = {
        let map = MKMapView()
        map.isScrollEnabled = false
        map.isPitchEnabled = false
        map.isZoomEnabled = false
        map.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(handleClickMapView)))
        return map
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(mapView)
    }
    
    override func layoutSubviews() {
        titleLabel.frame = CGRect(x: DetailMapCellConstants.leftMarginOfLabel, y: DetailMapCellConstants.topMarginOfLabel, width: ScreenWidth() - DetailMapCellConstants.leftMarginOfLabel * 2, height: titleLabel.height())

        separatorView.frame = CGRect(x: titleLabel.left() , y: titleLabel.right() + DetailMapCellConstants.marginOfTitleAndSeparator, width: ScreenWidth() - DetailMapCellConstants.leftMarginOfLabel * 2, height: 0.5)
        
        mapView.frame = CGRect(x: 0, y: separatorView.bottom() + DetailMapCellConstants.marginOfTitleAndSeparator, width: ScreenWidth(), height: DetailMapCellConstants.heightOfMapView)
    }
    
    @objc private func handleClickMapView() {
        
    }
    
    private func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) ->UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
