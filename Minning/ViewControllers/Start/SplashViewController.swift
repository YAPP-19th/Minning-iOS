//
//  SplashViewController.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

class SplashViewController: UIViewController {
    private let appLogoView: UIImageView = {
        $0.image = UIImage(sharedNamed: "AppIcon80")
        return $0
    }(UIImageView())
    
    private let appTextLogoView: UIImageView = {
        $0.image = UIImage(sharedNamed: "LogoText")
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.text = "나만을 위한 의미있는 아침"
        $0.font = .font16P
        $0.textColor = .primaryWhite
        return $0
    }(UILabel())
    
    private let viewModel: SplashViewModel
    
    public init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryBlue
        [appLogoView, appTextLogoView, titleLabel].forEach {
            view.addSubview($0)
        }
        
        appLogoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(132)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        appTextLogoView.snp.makeConstraints { make in
            make.top.equalTo(appLogoView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(appTextLogoView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.viewModel.goToLogin()
        })
    }
}
