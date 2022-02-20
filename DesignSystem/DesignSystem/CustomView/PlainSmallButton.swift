//
//  PlainSmallButton.swift
//  DesignSystem
//
//  Created by denny on 2021/11/06.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import SnapKit
import UIKit

public class PlainSmallButton: UIButton {
    public var isButtonSelected: Bool = false {
        didSet {
            DebugLog("isButtonSelected: \(isButtonSelected)")
            updateButtonStatus()
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            DebugLog("isHighlighted: \(isHighlighted)")
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
//        setBackgroundImage(UIImage(color: isSelected ? .minningDarkGray100 : .minningLightGray100), for: .normal)
        backgroundColor = isButtonSelected ? .minningDarkGray100 : .minningLightGray100
        titleLabel?.textColor = isButtonSelected ? .primaryWhite : .minningDarkGray100
    }
}
