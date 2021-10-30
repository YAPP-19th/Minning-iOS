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
                return .minningBlue100
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
//                return UIImage(sharedNamed: "appleLogo")
                return nil
            }
        }
    }
    
    public var plainButtonType: PlainButton.ButtonType = .normal {
        didSet {
            updateButtonColor()
            updateLeftIcon()
            
            if plainButtonType != .normal {
                titleLabel?.font = .font19P
            } else {
                titleLabel?.font = .font16PBold
            }
        }
    }
    
    public var isActive: Bool = true {
        didSet {
            if plainButtonType == .normal {
                isEnabled = isActive
                isUserInteractionEnabled = isActive
                updateButtonColor()
            }
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
        backgroundColor = isActive ? plainButtonType.backgroundColor : .minningGray100
        setTitleColor(plainButtonType.foregroundColor, for: .normal)
    }
    
    private func updateLeftIcon() {
        if #available (iOS 15.0, *) {
            var config = UIButton.Configuration.plain()
            config.image = plainButtonType.leftIcon
            config.imagePlacement = .leading
            config.imagePadding = 6
            configuration = config
        } else {
            self.setImage(plainButtonType.leftIcon, for: .normal)
            self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewLayout() {
        layer.cornerRadius = Constant.Rounding.rad10
        layer.masksToBounds = true
        backgroundColor = .minningBlue100
        titleLabel?.font = .font16PBold

        self.snp.makeConstraints {
            $0.height.equalTo(Constant.Height.textButton)
        }
    }
}
