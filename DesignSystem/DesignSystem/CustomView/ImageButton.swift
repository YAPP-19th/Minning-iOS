//
//  ImageButton.swift
//  DesignSystem
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import SharedAssets
import SnapKit
import UIKit

public class ImageButton: UIButton {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViewLayout() {
        backgroundColor = .clear
    }
}
