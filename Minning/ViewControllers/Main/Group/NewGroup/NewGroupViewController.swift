//
//  NewGroupViewController.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class NewGroupViewController: BaseViewController {
    private let viewModel: NewGroupViewModel
    
    public init(viewModel: NewGroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "그룹 추가하기"
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
    
    override func bindViewModel() {
        
    }
    
    override func setupViewLayout() {
        
    }
}
