//
//  PlainSmallButton.swift
//  DesignSystem
//
//  Created by denny on 2021/11/06.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

public class PlainSmallButton: UIButton {
    public override var isSelected: Bool {
        didSet {
            updateButtonStatus()
        }
    }
    
    public var cornerRadius: CGFloat = 7 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    public var title: String? {
        didSet {
            setTitle(title, for: .normal)
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
        layer.cornerRadius = cornerRadius
        titleLabel?.font = .font16P
        updateButtonStatus()
    }
    
    private func updateButtonStatus() {
        backgroundColor = isSelected ? .minningBlue100 : .minningLightGray100
        titleLabel?.textColor = isSelected ? .primaryWhite : .minningDarkGray100
    }
}
