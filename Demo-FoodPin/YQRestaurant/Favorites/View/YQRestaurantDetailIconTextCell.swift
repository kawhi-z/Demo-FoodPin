//
//  YQRestaurantDetailIconTextCell.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/27.
//

import UIKit

private struct Constants {
    static let marginOfLabel : CGFloat = 10
    static let leftMarginOfIconImage : CGFloat = 12
    static let topMarginOfLabel : CGFloat = 12
}

class YQRestaurantDetailIconTextCell: UITableViewCell {
    
    private lazy var iconImageView : UIImageView = {
        let uv = UIImageView()
        uv.contentMode = .scaleAspectFit
        return uv
    }()
    
    private lazy var detailLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(detailLabel)
    }
    
    public func render(withData imageName: String, detailText: String) {
        iconImageView.image = UIImage(named: imageName)
        detailLabel.text = detailText
        setNeedsLayout()
    }
    
    /// 类方法返回cell的高
    class func heightForIconTextCell(image: String, text: String) -> CGFloat {
        let iconImageView = UIImageView(frame: CGRect.zero)
        iconImageView.image = UIImage(named: image)
        iconImageView.sizeToFit()
        iconImageView.frame = CGRect(x: Constants.leftMarginOfIconImage, y: 0, width: iconImageView.width(), height: iconImageView.height())

        
        let detailLabel = UILabel(frame: CGRect.zero)
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        detailLabel.text = text
        detailLabel.numberOfLines = 0
        let labelSize = detailLabel.sizeThatFits(CGSize(width: ScreenWidth() - iconImageView.right() - Constants.marginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        
        
        return labelSize.height + Constants.topMarginOfLabel * 2
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconImageView.sizeToFit()
        detailLabel.sizeToFit()
        
        iconImageView.frame = CGRect(x:Constants.leftMarginOfIconImage, y: 0, width: iconImageView.width(), height: iconImageView.height())
        iconImageView.center = CGPoint(x: iconImageView.center.x, y: self.contentView.height() * 0.5)
        
        let labelSize = detailLabel.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - iconImageView.right() - Constants.marginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        
        detailLabel.frame = CGRect(x: iconImageView.right() + Constants.marginOfLabel , y: Constants.topMarginOfLabel, width: UIScreen.main.bounds.width - iconImageView.right() - Constants.marginOfLabel * 2, height: labelSize.height)
    }
}
