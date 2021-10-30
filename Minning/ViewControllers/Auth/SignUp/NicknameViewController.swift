//
//  NicknameViewController.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class NicknameViewController: BaseViewController {
    private let titleLabel: UILabel = {
        $0.text = "닉네임을 입력해주세요"
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
    
    private let nicknameTextField: PlainTextField = {
        $0.placeholder = "2글자 이상의 닉네임이 필요합니다"
        $0.isSecureTextEntry = false
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let signUpButton: PlainButton = {
        $0.isActive = false
        $0.buttonContent = "회원가입 완료"
        $0.addTarget(self, action: #selector(onClickSignUpButon(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let viewModel: NicknameViewModel
    
    public init(viewModel: NicknameViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onClickSignUpButon(_ sender: PlainButton) {
        viewModel.goToMain()
    }
    
    @objc
    private func textFieldDidChange(_ sender: PlainTextField) {
        signUpButton.isActive = sender.text?.count ?? 0 > 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "회원가입"
            navBar.removeDefaultShadowImage()
        }
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickBackButton(_:))))
    }
    
    override func bindViewModel() {
        
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(titleLabel)
        view.addSubview(loginStackView)
        isHiddenStatusBarBGView = false
        
        [hintLabel, nicknameTextField, signUpButton].forEach {
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
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
}
