//
//  PlainButton.swift
//  DesignSystem
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import SharedAssets
import SnapKit
import UIKit

public class PlainButton: UIButton {
    public enum ButtonType {
        case normal
        case kakao
        case apple
        
        var backgroundColor: UIColor {
            switch self {
            case .normal:
                return .primaryBlue
            case .kakao:
                return .kakaoYellow
            case .apple:
                return .black
            }
        }
        
        var foregroundColor: UIColor {
            switch self {
            case .normal, .apple:
                return .primaryWhite
            case .kakao:
                return .kakaoBlack85
            }
        }
        
        var leftIcon: UIImage? {
            switch self {
            case .normal:
                return nil
            case .kakao:
                return UIImage(sharedNamed: "kakaoLogo")
            case .apple:
                return UIImage(sharedNamed: "appleLogo")
            }
        }
    }
    
    public var plainButtonType: PlainButton.ButtonType = .normal {
        didSet {
            updateButtonColor()
            updateLeftIcon()
        }
    }
    
    public var isActive: Bool = true {
        didSet {
            isEnabled = isActive
            isUserInteractionEnabled = isActive
            updateButtonColor()
        }
    }

    public var buttonContent: String = "" {
        didSet {
            setTitle(buttonContent, for: .normal)
        }
    }
    
    private let iconImageView: UIImageView = UIImageView()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    private func updateButtonColor() {
        backgroundColor = isActive ? plainButtonType.backgroundColor : .primaryGray
        setTitleColor(plainButtonType.foregroundColor, for: .normal)
    }
    
    private func updateLeftIcon() {
        iconImageView.image = plainButtonType.leftIcon
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewLayout() {
        layer.cornerRadius = Constant.Rounding.rad10
        layer.masksToBounds = true
        backgroundColor = .primaryBlue
        titleLabel?.font = .font16PBold
        
        addSubview(iconImageView)

        self.snp.makeConstraints {
            $0.height.equalTo(Constant.Height.textButton)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
