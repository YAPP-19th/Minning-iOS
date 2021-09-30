//
//  BlueButton.swift
//  DesignSystem
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import SharedAssets
import SnapKit
import UIKit

public class BlueButton: UIButton {
    public var isActive: Bool = true {
        didSet {
            isEnabled = isActive
            isUserInteractionEnabled = isActive
            backgroundColor = isActive ? .primaryBlue : .primaryGray
        }
    }

    public var buttonContent: String = "" {
        didSet {
            setTitle(buttonContent, for: .normal)
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewLayout() {
        layer.cornerRadius = 10
        layer.masksToBounds = true
        backgroundColor = .primaryBlue
        setTitleColor(.primaryWhite, for: .normal)
        titleLabel?.font = .font16PBold
    }
}
