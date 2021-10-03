//
//  NotificationViewController.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class NotificationViewController: BaseViewController {
    private let viewModel: NotificationViewModel
    
    init(viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "알림"
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
}
