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
        let homeViewModel = HomeViewModel(coordinator: coordinator)
        let homeVC = HomeViewController(viewModel: homeViewModel)
        homeVC.tabBarDelegate = self
        
        let reportViewModel = ReportViewModel(coordinator: coordinator)
        let reportVC = ReportViewController(viewModel: reportViewModel)
        reportVC.tabBarDelegate = self
        
        let groupViewModel = GroupViewModel(coordinator: coordinator)
        let groupVC = GroupViewController(viewModel: groupViewModel)
        groupVC.tabBarDelegate = self
        
        let homeNC = createNavController(for: homeVC,
                                         normalImage: UIImage(sharedNamed: "tab_home_un.png"),
                                         selectedImage: UIImage(sharedNamed: "tab_home.png"))
        
        let reportNC = createNavController(for: reportVC,
                                           normalImage: UIImage(sharedNamed: "tab_report_un.png"),
                                           selectedImage: UIImage(sharedNamed: "tab_report.png"))
        
        let groupNC = createNavController(for: groupVC,
                                          normalImage: UIImage(sharedNamed: "tab_group_un.png"),
                                          selectedImage: UIImage(sharedNamed: "tab_group.png"))
        
        tabViewControllers.removeAll()
        tabViewControllers.append(homeNC)
        tabViewControllers.append(reportNC)
        tabViewControllers.append(groupNC)
        
        tabBar.barTintColor = .primaryWhite
        tabBar.tintColor = .primaryBlue

        viewControllers = tabViewControllers
    }

    public func tabBarController(_: UITabBarController, didSelect _: UIViewController) {
        DebugLog("tabBarController didSelect update Navigation Title")
    }
    
    fileprivate func createNavController(for rootViewController: BaseViewController,
                                         normalImage: UIImage?,
                                         selectedImage: UIImage?) -> UIViewController {
        rootViewController.tabBarDelegate = self
        let navController = UINavigationController(navigationBarClass: PlainUINavigationBar.self, toolbarClass: nil)
        navController.tabBarItem = UITabBarItem(title: "", image: normalImage, selectedImage: selectedImage)
        navController.viewControllers = [rootViewController]
        return navController
    }
}

extension MainTabBarViewController: MainTabBarDelegate {
    func hideTabBar() {
        tabBarBorderView.isHidden = true
        self.tabBar.isHidden = true
    }
    
    func showTabBar() {
        tabBarBorderView.isHidden = false
        self.tabBar.isHidden = false
    }
}
