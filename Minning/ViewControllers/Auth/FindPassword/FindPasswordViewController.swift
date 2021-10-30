//
//  FindPasswordViewController.swift
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

final class FindPasswordViewController: BaseViewController {
    private let titleLabel: UILabel = {
        $0.text = "인증번호를 받을 이메일을 입력해주세요"
        $0.textColor = .black
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
    
    private let emailTextField: PlainTextField = {
        $0.placeholder = "이메일을 입력해주세요"
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let requestCodeButton: PlainButton = {
        $0.isActive = false
        $0.setTitle("인증번호 발송", for: .normal)
        $0.addTarget(self, action: #selector(onClickRequestCodeButon(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let viewModel: FindPasswordViewModel
    
    public init(viewModel: FindPasswordViewModel) {
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
        
        [hintLabel, emailTextField, requestCodeButton].forEach {
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
    private func onClickRequestCodeButon(_ sender: PlainButton) {
        viewModel.goToEmailAuth()
    }
    
    @objc
    private func textFieldDidChange(_ sender: PlainTextField) {
        requestCodeButton.isActive = sender.text?.count ?? 0 > 0
    }
}
