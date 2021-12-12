//
//  GroupPhotoContainerView.swift
//  Minning
//
//  Created by 고세림 on 2021/12/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupPhotoContainerView: UIView {

    private let groupInfoTitleLabel: UILabel = {
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        $0.text = "인증 사진"
        return $0
    }(UILabel())
    
    private let descContainerView: UIView = {
        $0.backgroundColor = .minningBlue20
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private let descriptionLabel: UILabel = {
        $0.font = .font18PBold
        $0.text = "오늘 20명이 그룹 목표를 달성했어요!"
        $0.textColor = .minningDarkGray100
        return $0
    }(UILabel())
    
    private lazy var photoTabStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 23
        return $0
    }(UIStackView())
    
    private let totalLabel: UILabel = {
        $0.text = "전체"
        $0.font = .font18PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let myPhotoLabel: UILabel = {
        $0.text = "내 사진"
        $0.font = .font18PBold
        $0.textColor = .minningGray100
        return $0
    }(UILabel())
    
    private lazy var orderTabStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 20
        return $0
    }(UIStackView())
    
    private let newerLabel: UILabel = {
        $0.text = "최신순"
        $0.font = .font16PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let olderLabel: UILabel = {
        $0.text = "오래된 순"
        $0.font = .font16PMedium
        $0.textColor = .minningGray100
        return $0
    }(UILabel())
    
    private lazy var photoCollectionView: UICollectionView = {
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
        $0.register(GroupPhotoCell.self, forCellWithReuseIdentifier: GroupPhotoCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    private let morePhotoButton: UIButton = {
        $0.backgroundColor = .minningLightGray100
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.primaryBlack, for: .normal)
        $0.titleLabel?.font = .font16PBold
        $0.layer.cornerRadius = 10
        return $0
    }(UIButton())
    
    private let photoEmptyView: UIView = {
        $0.backgroundColor = .minningLightGray100
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    private let emptyImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "group_my_empty_photo")
        return $0
    }(UIImageView())
    
    private let emptyLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .grayB5B8BE
        $0.text = "아직 인증 사진이 없어요"
        return $0
    }(UILabel())
    
    private let photoUrls = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        [groupInfoTitleLabel, descContainerView, photoTabStackView, orderTabStackView, photoTabStackView, photoCollectionView, morePhotoButton, photoEmptyView].forEach {
            addSubview($0)
        }
        descContainerView.addSubview(descriptionLabel)
        [totalLabel, myPhotoLabel].forEach {
            photoTabStackView.addArrangedSubview($0)
        }
        [newerLabel, olderLabel].forEach {
            orderTabStackView.addArrangedSubview($0)
        }
        [emptyImageView, emptyLabel].forEach {
            photoEmptyView.addSubview($0)
        }
        
        groupInfoTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(20)
        }
        
        descContainerView.snp.makeConstraints { make in
            make.top.equalTo(groupInfoTitleLabel.snp.bottom).offset(16)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(70)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        photoTabStackView.snp.makeConstraints { make in
            make.top.equalTo(descContainerView.snp.bottom).offset(30)
            make.leading.equalTo(20)
        }
        
        orderTabStackView.snp.makeConstraints { make in
            make.top.equalTo(photoTabStackView.snp.bottom).offset(14)
            make.trailing.equalTo(-20)
        }
        
        photoCollectionView.snp.makeConstraints { make in
            make.top.equalTo(orderTabStackView.snp.bottom).offset(20)
            make.leading.equalTo(6)
            make.trailing.equalTo(-6)
            make.height.equalTo(photoCollectionView.snp.width)
        }
        
        morePhotoButton.snp.makeConstraints { make in
            make.top.equalTo(photoCollectionView.snp.bottom).offset(12)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(50)
        }
        
        photoEmptyView.snp.makeConstraints { make in
            make.top.equalTo(orderTabStackView.snp.bottom).offset(14)
            make.height.equalTo(120)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        
        emptyImageView.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(75)
            make.height.equalTo(56)
        }
        
        emptyLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-17)
            make.centerX.equalToSuperview()
        }
        
        if photoUrls.isEmpty {
            photoCollectionView.isHidden = true
            morePhotoButton.isHidden = true
            photoEmptyView.snp.makeConstraints { make in
                make.bottom.equalTo(-40)
            }
        } else {
            photoEmptyView.isHidden = true
            morePhotoButton.snp.makeConstraints { make in
                make.bottom.equalTo(-40)
            }
        }
    }
    
}

extension GroupPhotoContainerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupPhotoCell.identifier, for: indexPath) as? GroupPhotoCell else { return .init() }
        return cell
    }
    
}

extension GroupPhotoContainerView: UICollectionViewDelegate {
    
}

extension GroupPhotoContainerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (photoCollectionView.frame.width - 4) / 3
        return .init(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
