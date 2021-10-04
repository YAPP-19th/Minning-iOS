//
//  GroupDetailViewController.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class GroupDetailViewController: BaseViewController {
    private let navigationBar: PlainUINavigationBar = PlainUINavigationBar()
    private let contentView: UIView = UIView()
    private let joinButton: PlainButton = {
        $0.setTitle("참여하기", for: .normal)
        $0.addTarget(self, action: #selector(onClickJoinButton(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let viewModel: GroupDetailViewModel
    
    public init(viewModel: GroupDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // SAMPLE
        viewModel.groupItem.accept(Group(title: "새벽 운동 그룹"))
    }
    
    override func bindViewModel() {
        viewModel.groupItem.bind { [weak self] group in
            guard let `self` = self else { return }
            self.navigationBar.titleContent = group?.title ?? ""
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryWhite
        contentView.backgroundColor = .grayF6F7F9
        
        [navigationBar, contentView].forEach {
            view.addSubview($0)
        }
        
        [joinButton].forEach {
            contentView.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        joinButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func setupNavigationBar() {
        navigationBar.removeDefaultShadowImage()
        
        let navigationItem = UINavigationItem()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "close"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onClickJoinButton(_ sender: Any?) {
        viewModel.showJoinGroup()
    }
}
