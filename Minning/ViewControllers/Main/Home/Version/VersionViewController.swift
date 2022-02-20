//
//  VersionViewController.swift
//  Minning
//
//  Created by denny on 2021/10/31.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class VersionViewController: BaseViewController {
    private lazy var versionLogoView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(sharedNamed: "versionInfoLogo")
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "미닝"
        label.textAlignment = .center
        label.font = .font20PBold
        label.textColor = .minningBlue100
        return label
    }()
    
    private lazy var recentVersionLabel: UILabel = {
        let label = UILabel()
        label.font = .font16P
        label.textAlignment = .center
        label.textColor = .minningDarkGray100
        label.text = "최신 버전"
        return label
    }()
    
    private lazy var curVersionLabel: UILabel = {
        let label = UILabel()
        label.font = .font16P
        label.textAlignment = .center
        label.textColor = .minningDarkGray100
        label.text = "최신 버전"
        return label
    }()
    
    private lazy var infoContainerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let viewModel: VersionViewModel
    
    public init(viewModel: VersionViewModel) {
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
    
    override func setupViewLayout() {
        view.backgroundColor = .minningLightGray100
        view.addSubview(infoContainerView)
        
        [versionLogoView, titleLabel, recentVersionLabel, curVersionLabel].forEach {
            infoContainerView.addSubview($0)
        }
        
        infoContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        versionLogoView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(110)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(versionLogoView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
        recentVersionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        curVersionLabel.snp.makeConstraints { make in
            make.top.equalTo(recentVersionLabel.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func updateViewContent() {
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "버전 정보"
            navBar.removeDefaultShadowImage()
        }
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
}
