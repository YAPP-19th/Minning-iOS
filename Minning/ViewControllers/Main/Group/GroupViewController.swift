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
    
    private let filterStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    private var filterCollectionView: UICollectionView!
    private var groupListCollectionView: UICollectionView!
    
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
            self.myGroupTabButton.setTitleColor(type == .myGroup ? .primaryBlack : .minningGray100, for: .normal)
            self.groupListTabButton.setTitleColor(type == .groupList ? .primaryBlack : .minningGray100, for: .normal)
            
            // SAMPLE
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                if type == .myGroup {
//                    self.viewModel.goToNewGroup()
                } else {
                    self.viewModel.showDetail()
                }
            })
        }
    }
    
    override func setupViewLayout() {
        setupFilterCollectionView()
        setupGroupListCollectionView()
        
        view.backgroundColor = .minningLightGray100
        
        [myGroupTabButton, groupListTabButton, filterStackView, groupListCollectionView].forEach {
            view.addSubview($0)
        }
        filterStackView.addArrangedSubview(filterCollectionView)
        
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
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalTo(myGroupTabButton.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        filterCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
        }
        
        groupListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupFilterCollectionView() {
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        filterCollectionView.backgroundColor = .systemGreen
    }
    
    private func setupGroupListCollectionView() {
        groupListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        filterCollectionView.backgroundColor = .systemOrange
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
