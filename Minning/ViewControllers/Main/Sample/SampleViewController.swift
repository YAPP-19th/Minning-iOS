//
//  SampleViewController.swift
//  OurApp
//
//  Copyright © 2021 YappiOS1. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

class SampleViewController: UIViewController {
    private let titleLabel: UILabel = {
        $0.text = "Localized.HelloWorld".sharedLocalized
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return $0
    }(UILabel())
    
    private let sampleTextField: PlainTextField = {
        $0.placeholder = "샘플 텍스트입니다."
        return $0
    }(PlainTextField())
    
    private let sampleButton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = "계속하기"
//        $0.addTarget(self, action: #selector(toggleButtonStatus(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let sampleKakaoButton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = "카카오로 계속하기"
        $0.plainButtonType = .kakao
//        $0.addTarget(self, action: #selector(toggleButtonStatus(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let sampleAppleButton: PlainButton = {
        $0.isActive = true
        $0.buttonContent = "Apple로 계속하기"
        $0.plainButtonType = .apple
//        $0.addTarget(self, action: #selector(toggleButtonStatus(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    private let viewModel: SampleViewModel
    
    public init(viewModel: SampleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func toggleButtonStatus(_ sender: PlainButton) {
        sender.isActive = !sender.isActive
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .primaryLightGray
        
        [titleLabel, sampleButton, sampleTextField, sampleKakaoButton, sampleAppleButton].forEach {
            view.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        sampleButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        sampleKakaoButton.snp.makeConstraints { make in
            make.top.equalTo(sampleButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        sampleAppleButton.snp.makeConstraints { make in
            make.top.equalTo(sampleKakaoButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        sampleTextField.snp.makeConstraints { make in
            make.top.equalTo(sampleAppleButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
