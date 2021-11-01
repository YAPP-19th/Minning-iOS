//
//  ResetPasswordViewController.swift
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

final class ResetPasswordViewController: BaseViewController {
    private let oldTextField: PlainTextField = {
        $0.isSecureTextEntry = true
        $0.placeholder = "기존 비밀번호를 입력해주세요"
        $0.isDeleteHidden = true
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let newTextField: PlainTextField = {
        $0.isSecureTextEntry = true
        $0.placeholder = "새 비밀번호를 입력해주세요"
        $0.isDeleteHidden = true
        $0.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return $0
    }(PlainTextField())
    
    private let doneButton: PlainButton = {
        $0.isActive = false
        $0.setTitle("비밀번호 재설정", for: .normal)
        $0.addTarget(self, action: #selector(onClickDoneButon(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let viewModel: ResetPasswordViewModel
    
    public init(viewModel: ResetPasswordViewModel) {
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
            navBar.titleContent = "비밀번호 재설정"
            navBar.removeDefaultShadowImage()
        }
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .minningLightGray100
        [oldTextField, newTextField, doneButton].forEach {
            view.addSubview($0)
        }
        
        oldTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        newTextField.snp.makeConstraints { make in
            make.top.equalTo(oldTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        doneButton.snp.makeConstraints { make in
            make.top.equalTo(newTextField.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.goToBack()
    }
    
    @objc
    private func textFieldDidChange(_ sender: PlainTextField) {
        // 조건 추후 지정
    }
    
    @objc
    private func onClickDoneButon(_ sender: PlainButton) {
        // TODO: 서버 연동 후 성공 시 뒤로 이동
        viewModel.goToBack()
    }
}
