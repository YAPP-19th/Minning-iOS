//
//  GroupPhotoCell.swift
//  Minning
//
//  Created by 고세림 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupPhotoCell: UICollectionViewCell {
    
    static let identifier = "GroupPhotoCell"
    
    private let mainImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .minningGray100
        layer.cornerRadius = 2
        clipsToBounds = true

        addSubview(mainImageView)
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
