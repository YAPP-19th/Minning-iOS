//
//  VersionViewController.swift
//  Minning
//
//  Created by denny on 2021/10/31.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class VersionViewController: BaseViewController {
    private let viewModel: VersionViewModel
    
    public init(viewModel: VersionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        updateViewContent()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    private func updateViewContent() {
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "버전 정보"
            navBar.removeDefaultShadowImage()
        }
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
}
