//
//  PhotoCell.swift
//  Minning
//
//  Created by 고세림 on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class PhotoCell: UICollectionViewCell {
    
    static let identifier = "PhotoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .minningLightGray100
    }
}
