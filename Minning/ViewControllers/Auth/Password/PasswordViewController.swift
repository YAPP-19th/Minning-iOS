//
//  PasswordViewController.swift
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

final class PasswordViewController: UIViewController {
    private let viewModel: PasswordViewModel
    
    public init(viewModel: PasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "로그인"
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        navigationController?.popViewController(animated: true)
    }
}
