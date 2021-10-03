//
//  TopTextButton.swift
//  DesignSystem
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import SharedAssets
import SnapKit
import UIKit

public class TopTextButton: UIButton {
    public override var isEnabled: Bool {
        didSet {
            setTitleColor(isEnabled ? .primaryBlack : .primaryGray, for: .normal)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        titleLabel?.font = .font16PBold
        setTitleColor(.primaryBlack, for: .normal)
    }
}
