//
//  YQRestaurantReviewViewController.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/4/7.
//

import UIKit

// Swift 添加常量的方法
private struct ReviewViewControllerConstants {
    static let leftMarginOfCloseButton: CGFloat = 20
    static let widthOfCloseButton: CGFloat = 22
    static let numberOfRateButtons = 5
    static let leftMarginOfRateButton: CGFloat = 60
}

protocol YQRestaurantReviewControllDelegate {
    func handleRateButtonInReviewVC(rate: RateModel)
}

class YQRestaurantReviewViewController: UIViewController {

    public var delegate: YQRestaurantReviewControllDelegate!
    
    public var restaurant: RestaurantMO!
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        if let restaurantImage = restaurant.image {
            image.image = UIImage(data: restaurantImage as Data)
        }
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        image.addSubview(blurEffectView)
        return image
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeButton"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    private var rateButtons: Array<UIButton>!
    private var rateModels: Array<RateModel>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initData()
        initSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var interval: TimeInterval = 0.1
        for index in 0...self.rateButtons.count - 1 {
            UIView.animate(withDuration: 2.0, delay: interval, options: [],animations:  {
                let button = self.rateButtons[index]
                button.alpha = 1.0
                button.transform = .identity
            }, completion:nil)
            interval += 0.1
        }
    }
    
    private func initData() {
        rateModels = Array()

        do {
            let rateModel = RateModel(title: "Love", image: "love")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Cool", image: "cool")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Happy", image: "happy")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Sad", image: "sad")
            rateModels.append(rateModel)
        }
        
        do {
            let rateModel = RateModel(title: "Angry", image: "angry")
            rateModels.append(rateModel)
        }
    }

    
    private func initSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(closeButton)
        
        rateButtons = Array()
        var maxY: CGFloat = 80.0
        let moveRightTransForm = CGAffineTransform(translationX: UIScreen.main.bounds.width, y: 0)
        let scaleUpTransform = CGAffineTransform(scaleX: 5.0, y: 1.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransForm)
        
        for index in 0...rateModels.count - 1 {
            let rateButton = UIButton(frame: CGRect(x: ReviewViewControllerConstants.leftMarginOfRateButton, y: maxY, width: UIScreen.main.bounds.width - ReviewViewControllerConstants.leftMarginOfRateButton * 2, height: 60.0))
            let rateModel = rateModels[index]
            rateButton.setTitle(rateModel.title, for: .normal)
            rateButton.setImage(UIImage(named: rateModel.image), for: .normal)
            rateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50)
            rateButton.sizeToFit()
            rateButton.alpha = 0
            rateButton.transform = moveScaleTransform
            rateButton.tag = index
            rateButton.addTarget(self, action: #selector(handleRateButton), for: .touchUpInside)
            
            rateButtons.append(rateButton)
            view.addSubview(rateButton)
            
            maxY = rateButton.frame.maxY + 20
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: ScreenWidth(), height: ScreenHeight())
        closeButton.frame = CGRect(x: ScreenWidth() - ReviewViewControllerConstants.leftMarginOfCloseButton - ReviewViewControllerConstants.widthOfCloseButton, y: 30, width: ReviewViewControllerConstants.widthOfCloseButton, height: ReviewViewControllerConstants.widthOfCloseButton)
    }
    
    @objc func handleRateButton(view: UIView) {
        if view.isKind(of: UIButton.self) {
            self.delegate.handleRateButtonInReviewVC(rate: self.rateModels[view.tag])
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }

}
