//
//  NewPasswordViewController.swift
//  Minning
//
//  Created by denny on 2021/10/28.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class NewPasswordViewController: BaseViewController {
    private let titleLabel: UILabel = {
        $0.text = "새로운 비밀번호를 설정해주세요"
        $0.textColor = .primaryBlack
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let findPasswordStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 12
        return $0
    }(UIStackView())
    
    private let hintLabel: UILabel = {
        $0.font = .font16PMedium
        $0.text = "올바른 비밀번호입니다."
        $0.textColor = .minningBlue100
        return $0
    }(UILabel())
    
    private let passwordTextField: PlainTextField = {
        $0.isSecureTextEntry = true
        $0.placeholder = "숫자, 특수문자 포함 8자리 이상"
        $0.isDeleteHidden = true
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let doneButton: PlainButton = {
        $0.isActive = false
        $0.setTitle("비밀번호 설정 완료", for: .normal)
        $0.addTarget(self, action: #selector(onClickDoneButon(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let viewModel: NewPasswordViewModel
    
    public init(viewModel: NewPasswordViewModel) {
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
    
    private func updateViewContent() {
        if let navBar = navigationController?.navigationBar as? PlainUINavigationBar {
            navBar.titleContent = "새 비밀번호 설정"
            navBar.removeDefaultShadowImage()
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(titleLabel)
        view.addSubview(findPasswordStackView)
        isHiddenStatusBarBGView = false
        
        [hintLabel, passwordTextField, doneButton].forEach {
            findPasswordStackView.addArrangedSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(36)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        findPasswordStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
    
    @objc
    private func onClickDoneButon(_ sender: PlainButton) {
        viewModel.goToLogin()
    }
    
    @objc
    private func textFieldDidChange(_ sender: PlainTextField) {
        doneButton.isActive = sender.text?.count ?? 0 > 0
    }
}