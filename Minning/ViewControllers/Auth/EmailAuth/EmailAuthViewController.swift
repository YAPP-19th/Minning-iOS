//
//  EmailAuthViewController.swift
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

final class EmailAuthViewController: BaseViewController {
    private let titleLabel: UILabel = {
        $0.text = "인증번호를 입력해주세요"
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
        $0.text = ""
        $0.textColor = .primaryRed
        return $0
    }(UILabel())
    
    private let authCodeTextField: PlainTextField = {
        $0.placeholder = "4자리 숫자"
        $0.isDeleteHidden = true
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let reRequestButton: UIButton = {
        let reReqStr = NSMutableAttributedString(string: "재발송하기", attributes: [.underlineStyle: 1.0])
        $0.setAttributedTitle(reReqStr, for: .normal)
        $0.titleLabel?.font = .font14P
        $0.setTitleColor(.primaryBlack, for: .normal)
        $0.addTarget(self, action: #selector(onClickReRequestCodeButon(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let authButton: PlainButton = {
        $0.isActive = false
        $0.setTitle("다음", for: .normal)
        $0.addTarget(self, action: #selector(onClickAuthButon(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let viewModel: EmailAuthViewModel
    
    public init(viewModel: EmailAuthViewModel) {
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
            navBar.titleContent = "비밀번호 찾기"
            navBar.removeDefaultShadowImage()
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryLightGray
        view.addSubview(titleLabel)
        view.addSubview(findPasswordStackView)
        isHiddenStatusBarBGView = false
        
        [hintLabel, authCodeTextField, authButton].forEach {
            findPasswordStackView.addArrangedSubview($0)
        }
        
        authCodeTextField.addSubview(reRequestButton)
        reRequestButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
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
    private func onClickAuthButon(_ sender: PlainButton) {
        viewModel.goToNewPassword()
    }
    
    @objc
    private func onClickReRequestCodeButon(_ sender: PlainButton) {
        
    }
    
    @objc
    private func textFieldDidChange(_ sender: PlainTextField) {
        authButton.isActive = sender.text?.count ?? 0 > 0
    }
}
