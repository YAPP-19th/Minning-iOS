//
//  ProfileView.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

protocol ProfileViewDelegate: AnyObject {
    func didSelectAdd()
    
    func didSelectNoti()
}

final class ProfileView: UIView {
    weak var delegate: ProfileViewDelegate?
    
    private let profileImageView: UIImageView = {
        $0.backgroundColor = .primaryLightGray
        $0.layer.cornerRadius = 22
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    private let optionButtonStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 0
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    private let titleLabel: UILabel = {
        $0.font = .font20PExBold
        $0.textColor = .black
        $0.text = "9월 16일 (목)"
        return $0
    }(UILabel())
    
    private let notiButton: ImageButton = {
        $0.setImage(UIImage(sharedNamed: "bell"), for: .normal)
        $0.addTarget(self, action: #selector(onClickOptionButton(_:)), for: .touchUpInside)
        return $0
    }(ImageButton())
    
    private let addButton: ImageButton = {
        $0.setImage(UIImage(sharedNamed: "add"), for: .normal)
        $0.addTarget(self, action: #selector(onClickOptionButton(_:)), for: .touchUpInside)
        return $0
    }(ImageButton())
    
    private var weeklyViewList: [WeeklyView] = []
    
    private let weeklyDataStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        return $0
    }(UIStackView())
    
    private let leftArrowButton: ImageButton = {
        $0.setImage(UIImage(sharedNamed: "arrow_left"), for: .normal)
        return $0
    }(ImageButton())
    
    private let rightArrowButton: ImageButton = {
        $0.setImage(UIImage(sharedNamed: "arrow_right"), for: .normal)
        return $0
    }(ImageButton())
    
    @objc
    private func onClickOptionButton(_ sender: ImageButton) {
        switch sender {
        case addButton:
            delegate?.didSelectAdd()
        case notiButton:
            delegate?.didSelectNoti()
        default:
            break
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        backgroundColor = .primaryWhite
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        layer.cornerRadius = 15
        
        [profileImageView, titleLabel,
         optionButtonStackView, leftArrowButton,
         rightArrowButton, weeklyDataStackView].forEach {
            addSubview($0)
        }
        
        for idx in 0..<7 {
            let view = WeeklyView()
            view.weeklyData = WeeklyData(date: Date(), progress: CGFloat(idx) * 0.1)
            view.isTextBold = idx == 6
            weeklyDataStackView.addArrangedSubview(view)
        }
        
        [addButton, notiButton].forEach {
            optionButtonStackView.addArrangedSubview($0)
            $0.snp.makeConstraints { make in
                make.width.equalTo(44)
            }
        }
        
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(29)
            make.leading.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(17)
            make.leading.equalToSuperview().offset(16)
        }
        
        optionButtonStackView.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
        
        leftArrowButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-26)
            make.width.equalTo(8)
            make.height.equalTo(16)
        }
        
        rightArrowButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-26)
            make.width.equalTo(8)
            make.height.equalTo(16)
        }
        
        weeklyDataStackView.snp.makeConstraints { make in
            make.top.equalTo(optionButtonStackView.snp.bottom).offset(20)
            make.leading.equalTo(leftArrowButton.snp.trailing).offset(15)
            make.trailing.equalTo(rightArrowButton.snp.leading).offset(-15)
            make.bottom.equalToSuperview().offset(-27)
        }
    }
}
