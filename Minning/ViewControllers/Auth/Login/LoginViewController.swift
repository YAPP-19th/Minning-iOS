//
//  LoginViewController.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import AuthenticationServices
import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class LoginViewController: BaseViewController {
    private let scrollView: UIScrollView = {
        $0.keyboardDismissMode = .interactive
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = UIView()
    private let titleLabel: UILabel = {
        $0.text = "의미있는 아침을 시작해볼까요?"
        $0.textColor = .minningBlue100
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
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let loginButton: PlainButton = {
        $0.isActive = false
        $0.buttonContent = "계속하기"
        $0.addTarget(self, action: #selector(onClickLoginButon(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let socialLoginLabel: UILabel = {
        $0.text = "간편하게 로그인하기"
        $0.textColor = .primaryTextGray
        $0.textAlignment = .center
        $0.font = .font16PMedium
        return $0
    }(UILabel())
    
    private let kakaoLoginutton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = "카카오로 로그인"
        $0.plainButtonType = .kakao
//        $0.addTarget(self, action: #selector(toggleButtonStatus(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let appleLoginButton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = " Apple로 로그인"
        $0.plainButtonType = .apple
        $0.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress(_:)), for: .touchUpInside)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc
    private func onClickLoginButon(_ sender: PlainButton) {
        // MARK: Server API
//        viewModel.goToPassword(isLogin: false)
        viewModel.goToPassword(isLogin: true)
    }
    
    @objc
    private func handleAuthorizationAppleIDButtonPress(_ sender: PlainButton) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    @objc
    private func textFieldDidChange(_ sender: PlainTextField) {
        loginButton.isActive = sender.text?.count ?? 0 > 0
        viewModel.emailValue.accept(sender.text)
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.addSubview(contentView)
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
//        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
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
            make.leading.equalTo(38)
            make.trailing.equalTo(-38)
            make.bottom.equalToSuperview().offset(-56)
        }
        
        footerLoginContainerView.addSubview(footerLoginStackView)
        footerLoginStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        [socialLoginLabel, appleLoginButton, kakaoLoginutton].forEach {
            footerLoginStackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
            }
        }
    }
    
    @objc
    private func hideKeyboard() {
        loginTextField.resignFirstResponder()
    }
}

extension LoginViewController: UIScrollViewDelegate { }

extension LoginViewController: ASAuthorizationControllerDelegate,
                                ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if let authorizationCode = appleIDCredential.authorizationCode,
               let identityToken = appleIDCredential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
                DebugLog("authorizationCode: \(authorizationCode)")
                DebugLog("identityToken: \(identityToken)")
                DebugLog("authString: \(authString)")
                DebugLog("tokenString: \(tokenString)")
            }
            
            DebugLog("useridentifier: \(userIdentifier)")
            DebugLog("fullName: \(String(describing: fullName))")
            DebugLog("email: \(String(describing: email))")
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            DebugLog("username: \(username)")
            DebugLog("password: \(password)")
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        ErrorLog("Login Error")
    }
}
