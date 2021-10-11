//
//  RoutineCell.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

final class RoutineCell: UICollectionViewCell {
    static let identifier = "RoutineCell"
    
    private let categoryBarView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let alarmImageView = UIImageView()
    private let alarmLabel = UILabel()
    private let alarmStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        setTempData()
    }
    
    private func setupViewLayout() {
        contentView.backgroundColor = .primaryWhite

        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        
        [categoryBarView, titleLabel, descriptionLabel, alarmStackView].forEach {
            addSubview($0)
        }
        [alarmImageView, alarmLabel].forEach {
            alarmStackView.addArrangedSubview($0)
        }
        
        titleLabel.font = .font16PBold
        descriptionLabel.font = .font12P
        descriptionLabel.textColor = .minningDarkGray100
        alarmImageView.image = UIImage(sharedNamed: "alarm_enable.png")
        alarmLabel.font = .font12P
        
        categoryBarView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(categoryBarView.snp.trailing).offset(12)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        alarmImageView.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(11)
        }
        alarmStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func setTempData() {
        categoryBarView.backgroundColor = .minningBlue100
        titleLabel.text = "아침에 신문 읽기"
        descriptionLabel.text = "시사경영 3개씩 매일매일 읽기"
        alarmLabel.text = "7:00"
    }
}
