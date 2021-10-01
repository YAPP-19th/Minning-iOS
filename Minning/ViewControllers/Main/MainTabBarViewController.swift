//
//  MainTabBarViewController.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

protocol MainTabBarDelegate: AnyObject {
    func hideTabBar()
    func showTabBar()
}

public class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private let tabBarBorderView: UIView = {
        $0.backgroundColor = .grayE5E5E5
        return $0
    }(UIView())
    
    private var tabViewControllers: [UIViewController] = [UIViewController]()
    private let coordinator: MainCoordinator
    
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tabBarBorderView.frame = CGRect(x: self.tabBar.frame.origin.x, y: self.tabBar.frame.origin.y, width: self.tabBar.frame.width, height: 1.5)
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupTabBarItems()
        self.view.insertSubview(tabBarBorderView, aboveSubview: self.tabBar)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupTabBarItems() {
        tabViewControllers.removeAll()
        
        if let homeNC = createNavController(for: nil,
                                            normalImage: UIImage(sharedNamed: "tab_home_un.png"),
                                            selectedImage: UIImage(sharedNamed: "tab_home.png")) as? UINavigationController {
            tabViewControllers.append(homeNC)
            
            let homeDIContainer = HomeDIContainer()
            let homeCoordinator = HomeCoordinator(navigationController: homeNC, dependencies: homeDIContainer, coordinator: coordinator)
            homeCoordinator.start()
        }
        
        if let reportNC = createNavController(for: nil,
                                              normalImage: UIImage(sharedNamed: "tab_report_un.png"),
                                              selectedImage: UIImage(sharedNamed: "tab_report.png")) as? UINavigationController {
            tabViewControllers.append(reportNC)
            
            let reportDIContainer = ReportDIContainer()
            let reportCoordinator = ReportCoordinator(navigationController: reportNC, dependencies: reportDIContainer, coordinator: coordinator)
            reportCoordinator.start()
        }
        
        if let groupNC = createNavController(for: nil,
                                             normalImage: UIImage(sharedNamed: "tab_group_un.png"),
                                             selectedImage: UIImage(sharedNamed: "tab_group.png")) as? UINavigationController {
            tabViewControllers.append(groupNC)
            
            let groupDIContainer = GroupDIContainer()
            let groupCoordinator = GroupCoordinator(navigationController: groupNC, dependencies: groupDIContainer, coordinator: coordinator)
            groupCoordinator.start()
        }
        
        tabBar.barTintColor = .primaryWhite
        tabBar.tintColor = .primaryBlue
        
        if #available(iOS 13, *) {
            let appearance = tabBar.standardAppearance
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            tabBar.standardAppearance = appearance
        } else {
            tabBar.shadowImage = UIImage()
            tabBar.backgroundImage = UIImage()
        }

        viewControllers = tabViewControllers
    }

    public func tabBarController(_: UITabBarController, didSelect _: UIViewController) {
        DebugLog("tabBarController didSelect update Navigation Title")
    }
    
    fileprivate func createNavController(for rootViewController: BaseViewController?,
                                         normalImage: UIImage?,
                                         selectedImage: UIImage?) -> UIViewController {
        let navController = UINavigationController(navigationBarClass: PlainUINavigationBar.self, toolbarClass: nil)
        navController.tabBarItem = UITabBarItem(title: "", image: normalImage, selectedImage: selectedImage)
        
        if let rootVC = rootViewController {
            navController.viewControllers = [rootVC]
        }
        
        return navController
    }
}
