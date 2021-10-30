//
//  MyPageViewController.swift
//  Minning
//
//  Created by denny on 2021/10/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class MyPageViewController: BaseViewController {
    lazy var myPageTableView: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        $0.register(ProfileSettingCell.self, forCellReuseIdentifier: ProfileSettingCell.identifier)
        $0.register(NormalSettingCell.self, forCellReuseIdentifier: NormalSettingCell.identifier)
        $0.register(SwitchSettingCell.self, forCellReuseIdentifier: SwitchSettingCell.identifier)
        return $0
    }(UITableView())
    
    private let viewModel: MyPageViewModel
    
    public init(viewModel: MyPageViewModel) {
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
            navBar.titleContent = "마이 페이지"
            navBar.removeDefaultShadowImage()
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(myPageTableView)
        isHiddenStatusBarBGView = false
        
        myPageTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
}

extension MyPageViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getRowCount(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
