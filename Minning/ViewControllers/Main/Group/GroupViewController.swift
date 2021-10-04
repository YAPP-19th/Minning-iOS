//
//  GroupViewController.swift
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

final class GroupViewController: BaseViewController {
    private let myGroupTabButton: UIButton = {
        $0.setTitle("내 그룹", for: .normal)
        $0.titleLabel?.font = .font20PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let groupListTabButton: UIButton = {
        $0.setTitle("둘러보기", for: .normal)
        $0.titleLabel?.font = .font20PExBold
        $0.addTarget(self, action: #selector(onClickTabButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let viewModel: GroupViewModel
    
    public init(viewModel: GroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func bindViewModel() {
        viewModel.tabType.bindAndFire { [weak self] type in
            guard let `self` = self else { return }
            self.myGroupTabButton.setTitleColor(type == .myGroup ? .primaryBlack : .primaryGray, for: .normal)
            self.groupListTabButton.setTitleColor(type == .groupList ? .primaryBlack : .primaryGray, for: .normal)
            
            // SAMPLE
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                if type == .myGroup {
                    self.viewModel.goToNewGroup()
                } else {
                    self.viewModel.showDetail()
                }
            })
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .grayF6F7F9
        
        [myGroupTabButton, groupListTabButton].forEach {
            view.addSubview($0)
        }
        
        myGroupTabButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(19)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
        
        groupListTabButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(19)
            make.leading.equalTo(myGroupTabButton.snp.trailing).offset(26)
            make.height.equalTo(44)
            make.width.greaterThanOrEqualTo(44)
        }
    }
    
    @objc
    private func onClickTabButton(_ sender: UIButton) {
        switch sender {
        case myGroupTabButton:
            viewModel.tabType.accept(.myGroup)
        case groupListTabButton:
            viewModel.tabType.accept(.groupList)
        default:
            break
        }
    }
}
