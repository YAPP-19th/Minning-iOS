//
//  GroupPicturePreviewContainerView.swift
//  Minning
//
//  Created by 고세림 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupPhotoPreviewContainerView: UIView {
    
    private let titleLabel: UILabel = {
        $0.font = .font22PExBold
        $0.textColor = .primaryBlack
        $0.text = "그룹 사진"
        return $0
    }(UILabel())
    
    private let layout: UICollectionViewFlowLayout = {
        $0.scrollDirection = .horizontal
        return $0
    }(UICollectionViewFlowLayout())
    
    private lazy var photoCollectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.showsHorizontalScrollIndicator = false
        $0.register(GroupPhotoPreviewCell.self, forCellWithReuseIdentifier: GroupPhotoPreviewCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: layout))
    
    private let photoEmptyView: UIView = {
        $0.backgroundColor = .minningLightGray100
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private let emptyImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "group_empty_photo")
        return $0
    }(UIImageView())
    
    private let emptyLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .grayB5B8BE
        $0.text = "아직 업로드된 그룹 사진이 없어요"
        return $0
    }(UILabel())
    
    private let separatorView: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        [titleLabel, photoCollectionView, photoEmptyView, separatorView].forEach {
            addSubview($0)
        }
        photoCollectionView.isHidden = true
        
        [emptyImageView, emptyLabel].forEach {
            photoEmptyView.addSubview($0)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalTo(20)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.height.equalTo(120)
            make.leading.trailing.equalToSuperview()
        }
        
        photoEmptyView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(14)
            make.height.equalTo(120)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(15)
            make.width.equalTo(75)
            make.height.equalTo(52)
            make.centerX.equalToSuperview()
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-22)
            make.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(12)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension GroupPhotoPreviewContainerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupPhotoPreviewCell.identifier, for: indexPath) as? GroupPhotoPreviewCell else { return .init() }
        cell.configure(showMorePhoto: indexPath.row == 2)
        return cell
    }
    
}

extension GroupPhotoPreviewContainerView: UICollectionViewDelegate {
    
}

extension GroupPhotoPreviewContainerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 120, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
