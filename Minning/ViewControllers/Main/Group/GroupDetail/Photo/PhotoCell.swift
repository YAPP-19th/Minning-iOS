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
    
    private let mainImageView = UIImageView()
    private lazy var selectedView: UIView = {
        $0.backgroundColor = .blue007AFF
        $0.layer.cornerRadius = 8
        $0.layer.borderColor = UIColor.primaryWhite.cgColor
        $0.layer.borderWidth = 1
        $0.isHidden = true
        return $0
    }(UIView())
    
    private let checkImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "checkmark")
        return $0
    }(UIImageView())

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
        layer.borderColor = UIColor.systemBlue.cgColor
        clipsToBounds = true
        
        [mainImageView, selectedView].forEach {
            addSubview($0)
        }
        selectedView.addSubview(checkImageView)
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectedView.snp.makeConstraints { make in
            make.top.leading.equalTo(10)
            make.width.height.equalTo(16)
        }
        
        checkImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(7.89)
            make.height.equalTo(6)
        }
    }
    
    func updateLayout(isSelected: Bool) {
        selectedView.isHidden = !isSelected
        layer.borderWidth = isSelected ? 2 : 0
    }
}
