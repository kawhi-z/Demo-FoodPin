//
//  SceneDelegate.swift
//  Demo-FoodPin
//
//  Created by Kawhi on 2021/2/21.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var tabBarControllers : [UIViewController] = []
    var baseTabBarController : UITabBarController!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        baseTabBarController = UITabBarController(nibName: nil, bundle: nil)
        tabBarControllers.append(favoritesViewController())
        tabBarControllers.append(discoverViewController())
        tabBarControllers.append(aboutViewController())
        
        baseTabBarController.setViewControllers(tabBarControllers, animated: false)
        
        configureTabBarItems()
        
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.backgroundColor = .white
        window?.rootViewController = baseTabBarController
        window?.makeKeyAndVisible()
        
        let backButtonImage = UIImage(named: "back")
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
        
        UITabBar.appearance().tintColor = .orange
        UITabBar.appearance().barTintColor = .black
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func favoritesViewController() ->UIViewController {
        let rootViewController = YQResturantTableViewController()
        return UINavigationController(rootViewController: rootViewController)
    }
        
    func discoverViewController() ->UIViewController {
        let rootViewController = YQDiscoverViewController()
        return UINavigationController(rootViewController: rootViewController)
    }
    
    func aboutViewController() ->UIViewController {
        let rootViewController = YQResturantAboutViewController()
        return UINavigationController(rootViewController: rootViewController)
    }
    
    
    func configureTabBarItems() {
        let tabBarItems = baseTabBarController.tabBar.items
        let itemsCount : Int = tabBarItems?.count ?? 0
        if itemsCount > 0 {
            for index in 0...itemsCount - 1 {
                var title = ""
                var image = ""
                switch index {
                case 0:
                    title = "Favorites"
                    image = "favorite"
                case 1:
                    title = NSLocalizedString("Discover", comment: "Discover")
                    image = "discover"
                case 2:
                    title = NSLocalizedString("About", comment: "About")
                    image = "about"
                default:
                    return
                }
                
                if let tabBarItem = tabBarItems?[index] {
                    tabBarItem.title = title
                    tabBarItem.image = UIImage(named: image)
                }
            }
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    
    
}

