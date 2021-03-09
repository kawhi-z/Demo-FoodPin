//
//  YQRestaurantCellTableViewCell.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/7.
//

import UIKit

private struct Constants {
    static let marginOfLabel : CGFloat = 12
}

class YQRestaurantCellTableViewCell: UITableViewCell {

    var restautantName : String!
    var nameLabel : UILabel!
    var locationLabel : UILabel!
    var typeLabel : UILabel!
    var thumbnailImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubViews()
    }
    
    func initSubViews() {
        thumbnailImageView = UIImageView(frame: CGRect(x: 12, y: 12, width: 60, height: 60))
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.width * 0.5
        thumbnailImageView.layer.masksToBounds = true
        
//        nameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0 , height: 0))
        nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
//        locationLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        locationLabel = UILabel()
        
        typeLabel = UILabel()
        
        
        self.contentView.addSubview(thumbnailImageView)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(locationLabel)
        self.contentView.addSubview(typeLabel)
    }

    func setData(restautrant: RestaurantMO) {
        if let restautantImage = restautrant.image {
            thumbnailImageView.image = UIImage(data: restautantImage as Data)
        }
        
        let labelWidth = self.bounds.width - thumbnailImageView.frame.maxX - Constants.marginOfLabel * 2
        
        nameLabel.text = restautrant.name
        nameLabel.sizeToFit()
        nameLabel.frame = CGRect(x: thumbnailImageView.frame.origin.x + thumbnailImageView.frame.size.width + Constants.marginOfLabel, y: thumbnailImageView.frame.origin.y - 2, width: labelWidth, height: nameLabel.frame.size.height)
        
        locationLabel.text = restautrant.location
        locationLabel.sizeToFit()
        locationLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: nameLabel.frame.origin.y + nameLabel.frame.size.height, width: labelWidth, height: locationLabel.frame.size.height)
        
        typeLabel.text = restautrant.type
        typeLabel.sizeToFit()
        typeLabel.frame = CGRect(x: nameLabel.frame.origin.x, y: locationLabel.frame.origin.y + locationLabel.frame.size.height, width: labelWidth, height: typeLabel.frame.size.height)
        
    }
    
}
