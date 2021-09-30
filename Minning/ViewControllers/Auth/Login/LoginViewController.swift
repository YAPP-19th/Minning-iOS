//
//  LoginViewController.swift
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

final class LoginViewController: UIViewController {
    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = UIView()
    private let titleLabel: UILabel = {
        $0.text = "의미있는 아침을 시작해볼까요?"
        $0.textColor = .primaryBlue
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let loginStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        return $0
    }(UIStackView())
    
    private let hintLabel: UILabel = {
        $0.font = .font16PMedium
        $0.text = "샘플 힌트 텍스트입니다"
        $0.textColor = .primaryRed
        return $0
    }(UILabel())
    
    private let loginTextField: PlainTextField = {
        $0.placeholder = "이메일을 입력해주세요"
        return $0
    }(PlainTextField())
    
    private let loginButton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = "계속하기"
//        $0.addTarget(self, action: #selector(toggleButtonStatus(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let simpleLoginButton: UIButton = {
        $0.setTitle("간편하게 로그인하기", for: .normal)
        $0.setTitleColor(.primaryTextGray, for: .normal)
        $0.titleLabel?.textAlignment = .center
        $0.titleLabel?.font = .font16PMedium
        return $0
    }(UIButton())
    
    private let kakaoLoginutton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = "카카오로 계속하기"
        $0.plainButtonType = .kakao
//        $0.addTarget(self, action: #selector(toggleButtonStatus(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let appleLoginButton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = "Apple로 계속하기"
        $0.plainButtonType = .apple
//        $0.addTarget(self, action: #selector(toggleButtonStatus(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let footerLoginContainerView: UIView = UIView()
    private let footerLoginStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        return $0
    }(UIStackView())
    
    private let viewModel: LoginViewModel
    
    public init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview().priority(250)
            make.width.equalToSuperview()
        }
        
        [titleLabel, loginStackView, footerLoginContainerView].forEach {
            contentView.addSubview($0)
        }
        
        [hintLabel, loginTextField, loginButton].forEach {
            loginStackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        footerLoginContainerView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(loginStackView.snp.bottom)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalToSuperview().offset(-36)
        }
        
        footerLoginContainerView.addSubview(footerLoginStackView)
        footerLoginStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [simpleLoginButton, kakaoLoginutton, appleLoginButton].forEach {
            footerLoginStackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
            }
        }
    }
}

extension LoginViewController: UIScrollViewDelegate {
    
}
