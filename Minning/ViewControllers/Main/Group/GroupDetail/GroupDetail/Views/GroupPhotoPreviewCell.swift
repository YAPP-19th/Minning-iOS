//
//  GroupPhotoPreviewCell.swift
//  Minning
//
//  Created by 고세림 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupPhotoPreviewCell: UICollectionViewCell {
    
    static let identifier = "GroupPhotoPreviewCell"
    
    private let mainImageView = UIImageView()
    private lazy var morePhotoView: UIView = {
        $0.backgroundColor = .primaryBlack040
        return $0
    }(UIView())
    private let morePhotoLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryWhite
        $0.text = "사진 더보기"
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(showMorePhoto: Bool) {
        morePhotoView.isHidden = !showMorePhoto
    }
    
    private func setupView() {
        backgroundColor = .minningGray100
        layer.cornerRadius = 2
        clipsToBounds = true
        morePhotoView.isHidden = true
        
        [mainImageView, morePhotoView].forEach {
            addSubview($0)
        }
        morePhotoView.addSubview(morePhotoLabel)
        
        mainImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        morePhotoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        morePhotoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
