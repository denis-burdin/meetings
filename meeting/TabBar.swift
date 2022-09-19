//
//  TabBar.swift
//  meeting
//
//  Created by Denis Burdin on 17.09.2022.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                         title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
    
    func setupVCs() {
        let inputMeetingVC: UIViewController = InputMeetingAssembly.build()
        inputMeetingVC.title = "create_tab".localized
        let displayMeetingVC: UIViewController = DisplayMeetingAssembly.build()
        displayMeetingVC.title = "display_tab".localized

        viewControllers = [
            createNavController(for: inputMeetingVC, title: "main_page".localized, image: UIImage(systemName: "person")!),
            createNavController(for: displayMeetingVC, title: "info_page".localized, image: UIImage(systemName: "externaldrive")!),
        ]
    }
}
