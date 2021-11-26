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

final class GroupViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private let category: [String] = ["전체", "미라클모닝", "자기개발", "건강", "생활"]
    
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
    
    private var filterOnGoingStackView: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    private let layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())
    
    private let verticalLayout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .vertical
        return $0
    }(UICollectionViewFlowLayout())
    
    lazy var filterCollectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    lazy var groupListCollectionView: UICollectionView = {
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: verticalLayout))
    
    private let onGoingButton: UIButton = {
            $0.setTitle("진행중 0", for: .normal)
            $0.titleLabel?.font = .font16PBold
            $0.setTitleColor(.primaryBlack, for: .selected)
            $0.setTitleColor(.grayB5B8BE, for: .normal)
            $0.isSelected = true
//            $0.addTarget(self, action: #selector(onGoingButtonClicked), for: .touchUpInside)
            return $0
        }(UIButton())
        
        private let endedButton: UIButton = {
            $0.setTitle("종료 0", for: .normal)
            $0.titleLabel?.font = .font16PBold
            $0.setTitleColor(.primaryBlack, for: .selected)
            $0.setTitleColor(.grayB5B8BE, for: .normal)
//            $0.addTarget(self, action: #selector(onGoingButtonClicked), for: .touchUpInside)
            return $0
        }(UIButton())
        
        private let redAlertImageView: UIView = {
            $0.backgroundColor = .primaryRed
            $0.layer.cornerRadius = 2
            return $0
        }(UIView())
    
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
            
            if type == .myGroup {
                self.groupListCollectionView.isHidden = true
                self.setupOngoingFilterStackView()
                
            } else {
                self.filterStackView.isHidden = true
                self.setupCategoryCollectionView()
            }
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .minningLightGray100
        
        [myGroupTabButton, groupListTabButton, filterStackView, groupListCollectionView].forEach {
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
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalTo(myGroupTabButton.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        

        
        groupListCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupOngoingFilterStackView() {
        print("Pressed 내그룹")
        filterStackView.addArrangedSubview(filterOnGoingStackView)
        
        [onGoingButton, endedButton, redAlertImageView].forEach {
            filterOnGoingStackView.addSubview($0)
        }
        
        onGoingButton.snp.makeConstraints { make in
                    make.height.equalTo(19)
                    make.leading.equalTo(12)
            make.top.equalTo(filterOnGoingStackView.snp.top).offset(6)
            
        }
        
        endedButton.snp.makeConstraints { make in
                    make.height.equalTo(19)
            make.leading.equalTo(onGoingButton.snp.trailing).offset(20)
            make.top.equalTo(filterOnGoingStackView.snp.top).offset(6)
            
        }
        
        redAlertImageView.snp.makeConstraints { make in
                    make.height.equalTo(4)
                    make.width.equalTo(4)
            make.leading.equalTo(endedButton.snp.trailing).offset(2)
            make.top.equalTo(filterOnGoingStackView.snp.top)
            
        }
    }
    
    private func setupCategoryCollectionView() {
        print("Pressed 둘러보기")
        filterStackView.addArrangedSubview(filterCollectionView)
        
        filterCollectionView.backgroundColor = .systemPink
        
        filterCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCategoryCell.identifier, for: indexPath) as? GroupCategoryCell {
            cell.label.text = category[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
}
