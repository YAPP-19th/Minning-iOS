//
//  HomeViewController.swift
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

final class HomeViewController: BaseViewController {
    lazy var profileView: ProfileView = {
        $0.delegate = self
        return $0
    }(ProfileView())
    
    lazy var routineView: RoutineView = {
        $0.delegate = self
        return $0
    }(RoutineView())
    
    private let contentView: UIView = UIView()
    private let routineAlertTitle = "알림"
    private let routineAlertText = "루틴 활성화를 위해 오늘의 명언 따라쓰기를 완료해주세요!"
    private let viewModel: HomeViewModel
    
    public init(viewModel: HomeViewModel) {
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
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryWhite
        [contentView, profileView].forEach {
            view.addSubview($0)
        }
        contentView.addSubview(routineView)
        contentView.backgroundColor = .minningLightGray100
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        routineView.snp.makeConstraints { make in
            make.top.equalTo(profileView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        viewModel.tabType.bind { [weak self] type in
            guard let self = self else { return }
            self.routineView.tabType = type
            self.routineView.updateView()
        }
    }
}

extension HomeViewController: ProfileViewDelegate {
    func didSelectAdd() {
        viewModel.goToAdd()
    }
    
    func didSelectNoti() {
        viewModel.goToNotification()
    }
    
    func didSelectProfile() {
        viewModel.goToMyPage()
    }
}

extension HomeViewController: RoutineViewDelegate {
    func didSelectSection(_ section: RoutineView.TableViewSection) {
        switch section {
        case .header:
            return
        case .phraseGuide:
            viewModel.showPhraseModally()
        case .routine:
            showAlert(title: routineAlertTitle, message: routineAlertText) { _ in
                self.viewModel.showPhraseModally()
                return
            }
        case .review:
            viewModel.goToReview()
        }
    }
    
    func didSelectEditOrder() {
        viewModel.goToEditOrder()
    }
    
    func didSelectTab(_ tabType: HomeViewModel.RoutineTabType) {
        viewModel.tabType.accept(tabType)
    }
}
