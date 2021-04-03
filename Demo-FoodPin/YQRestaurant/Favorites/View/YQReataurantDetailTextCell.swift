//
//  YQReataurantDetailTextCell.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/3/27.
//

import UIKit

private struct DetailTextCellConstants {
    static let leftMarginOfLabel : CGFloat = 12
    static let topMarginOfLabel : CGFloat = 10
}


class YQReataurantDetailTextCell: UITableViewCell {

    private lazy var detailLabel : UILabel = {
        let  label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        initSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubviews() {
        contentView.addSubview(detailLabel)
    }
    
    public func render(withData detailText: String) {
        detailLabel.text = detailText
        let labelSize = detailLabel.sizeThatFits(CGSize(width: contentView.width() - DetailTextCellConstants.leftMarginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        
        detailLabel.frame = CGRect(x: DetailTextCellConstants.leftMarginOfLabel, y: DetailTextCellConstants.topMarginOfLabel, width: contentView.width() - DetailTextCellConstants.leftMarginOfLabel * 2, height: labelSize.height)
    }
    
    public class func heightForTextCell(restautrant: RestaurantMO) ->CGFloat {
        let label = UILabel(frame: CGRect.zero)
        label.text = restautrant.summary!
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        let labelSize = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - DetailTextCellConstants.leftMarginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        
        return labelSize.height + DetailTextCellConstants.topMarginOfLabel * 2
    }
    
    /// 类方法返回cell的高
    class func heightForTextCell(restaurant: RestaurantMO) -> CGFloat {
        
        let label = UILabel(frame: CGRect.zero)
        label.text = restaurant.summary!
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        let labelSize = label.sizeThatFits(CGSize(width: ScreenWidth() - DetailTextCellConstants.leftMarginOfLabel * 2, height: CGFloat(MAXFLOAT)))
        
        return labelSize.height + DetailTextCellConstants.topMarginOfLabel * 2
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
