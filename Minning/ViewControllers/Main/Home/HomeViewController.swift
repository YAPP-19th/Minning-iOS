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
    private let alertText = "명언 작성 후 루틴을 시작할 수 있습니다.\n지금 명언 작성 페이지로 이동하시겠습니까?"
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
}

extension HomeViewController: RoutineViewDelegate {
    func didSelectSection(_ section: RoutineView.TableViewSection) {
        switch section {
        case .header:
            return
        case .phraseGuide:
            viewModel.showPhraseModally()
        case .routine:
            showAlert(title: "루틴", message: alertText) { _ in
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
