//
//  PasswordViewController.swift
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

final class PasswordViewController: BaseViewController {
    private let titleLabel: UILabel = {
        $0.text = "비밀번호를 입력해주세요"
        $0.textColor = .primaryBlack
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
        $0.isSecureTextEntry = true
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let loginButton: PlainButton = {
        $0.isActive = false
        $0.addTarget(self, action: #selector(onClickLoginButon(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let findPasswordButton: UIButton = {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.setTitleColor(.primaryBlack, for: .normal)
        $0.titleLabel?.font = .font16PMedium
        $0.contentHorizontalAlignment = .left
        $0.addTarget(self, action: #selector(onClickFindPassword(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let viewModel: PasswordViewModel
    
    public init(viewModel: PasswordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onClickFindPassword(_ sender: UIButton) {
        viewModel.goToFindPassword()
    }
    
    @objc
    private func onClickLoginButon(_ sender: PlainButton) {
        if viewModel.passwordViewType.value == .login {
//            viewModel.goToMain()
            viewModel.processLogin()
        } else {
            viewModel.goToNickname()
        }
    }
    
    @objc
    private func textFieldDidChange(_ sender: PlainTextField) {
        loginButton.isActive = sender.text?.count ?? 0 > 0
        viewModel.passwordValue.accept(sender.text)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        updateViewContent()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    private func updateViewContent() {
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = viewModel.passwordViewType.value.title
            navBar.removeDefaultShadowImage()
        }
        
        loginButton.buttonContent = viewModel.passwordViewType.value.buttonContent
        loginTextField.placeholder = viewModel.passwordViewType.value.textFieldHint
        findPasswordButton.isHidden = !(viewModel.passwordViewType.value == .login)
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(titleLabel)
        view.addSubview(loginStackView)
        
        [hintLabel, loginTextField, loginButton, findPasswordButton].forEach {
            loginStackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(36)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        loginStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
    }
    
    override func bindViewModel() {
        viewModel.passwordViewType.bind { [weak self] _ in
            guard let `self` = self else { return }
            self.updateViewContent()
        }
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
}
