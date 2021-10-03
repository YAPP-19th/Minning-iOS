//
//  ReviewViewController.swift
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

final class ReviewViewController: BaseViewController {
    private let navigationBar: PlainUINavigationBar = PlainUINavigationBar()
    private let viewModel: ReviewViewModel
    
    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupNavigationBar() {
        navigationBar.titleContent = "돌아보기"
        navigationBar.removeDefaultShadowImage()
        
        let navigationItem = UINavigationItem()
        let textBarButton = MUIBarButtonItem(title: "작성", style: .plain, target: self, action: #selector(onClickPostButton(_:)))
        textBarButton.textFont = .font16PBold
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "close"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationItem.setRightPlainBarButtonItem(textBarButton, animated: false)
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    private func setupViewLayout() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onClickPostButton(_ sender: Any?) {
        DebugLog("Did Click Post Button")
    }
}
