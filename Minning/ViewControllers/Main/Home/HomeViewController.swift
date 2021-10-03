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
    
    private let contentView: UIView = UIView()
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.viewModel.showPhraseModally()
        })
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryWhite
        [contentView, profileView].forEach {
            view.addSubview($0)
        }
        
        contentView.backgroundColor = .primaryLightGray
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        profileView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    override func bindViewModel() {
        
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
