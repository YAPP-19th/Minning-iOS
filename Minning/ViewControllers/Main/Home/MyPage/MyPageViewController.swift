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
import UIKit

final class MyPageViewController: BaseViewController {
    lazy var myPageTableView: UITableView = {
        $0.delegate = self
        $0.dataSource = self
        $0.separatorStyle = .none
        $0.backgroundColor = .minningLightGray100
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
        
        viewModel.getUserData()
    }
    
    private func updateViewContent() {
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "마이 페이지"
            navBar.removeDefaultShadowImage()
        }
    }
    
    override func bindViewModel() {
        viewModel.myInfo.bind { _ in
            self.myPageTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(myPageTableView)
        
        myPageTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 196 : 51
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSettingCell.identifier) as? ProfileSettingCell {
                cell.profileData = viewModel.myInfo.value
                return cell
            }
        } else {
            let rowItem = viewModel.getSectionRowItems(section: indexPath.section)[indexPath.row]
            switch rowItem.type {
            case .push:
                if let cell = tableView.dequeueReusableCell(withIdentifier: SwitchSettingCell.identifier) as? SwitchSettingCell {
                    cell.rowItem = rowItem
                    cell.selectionStyle = .none
                    return cell
                }
            default:
                if let cell = tableView.dequeueReusableCell(withIdentifier: NormalSettingCell.identifier) as? NormalSettingCell {
                    cell.rowItem = rowItem
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let rowItem = viewModel.getSectionRowItems(section: indexPath.section)[indexPath.row]
            switch rowItem.type {
            case .logout:
                viewModel.goToLogin()
            case .deleteAccount:
                self.showAlert(title: "계정 삭제", message: "정말 이 계정을 삭제하시겠습니까?", okTitle: "삭제", handler: { _ in
                    // 계정 삭제 로직 진행
                    DebugLog("계정 삭제")
                })
            default:
                viewModel.goToSettingContent(type: rowItem.type)
            }
        }
    }
}
