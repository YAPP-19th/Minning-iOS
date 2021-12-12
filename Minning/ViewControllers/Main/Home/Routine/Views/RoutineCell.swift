//
//  RoutineCell.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

final class RoutineCell: UITableViewCell {
    static let identifier = "RoutineCell"
    
    private let categoryBarView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let completeLabel = UILabel()
    private let lockImageView = UIImageView()
    private let alarmImageView = UIImageView()
    private let alarmLabel = UILabel()
    private let alarmStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
        setViewAsDisable()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ routine: RoutineModel) {
        categoryBarView.backgroundColor = routine.category.color
        titleLabel.text = routine.title
        descriptionLabel.text = routine.goal
        alarmLabel.text = routine.startTime
    }

    private func setupViewLayout() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.backgroundColor = .primaryWhite
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        
        [categoryBarView, titleLabel, descriptionLabel, completeLabel, lockImageView, alarmStackView].forEach {
            contentView.addSubview($0)
        }
        [alarmImageView, alarmLabel].forEach {
            alarmStackView.addArrangedSubview($0)
        }
        
        titleLabel.font = .font16PBold
        descriptionLabel.font = .font14PMedium
        descriptionLabel.textColor = .minningDarkGray100
        completeLabel.font = .font12P
        completeLabel.textColor = .minningBlue100
        lockImageView.image = UIImage(sharedNamed: "lock.png")
        alarmImageView.image = UIImage(sharedNamed: "alarm_enable.png")
        alarmLabel.font = .font12P
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
        }
        categoryBarView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(categoryBarView.snp.trailing).offset(12)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        completeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-14)
        }
        lockImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(20)
        }
        alarmImageView.snp.makeConstraints { make in
            make.width.equalTo(10)
            make.height.equalTo(11)
        }
        alarmStackView.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func setViewAsDisable() {
        categoryBarView.backgroundColor = .grayB5B8BE
        titleLabel.textColor = .grayB5B8BE
        descriptionLabel.textColor = .grayB5B8BE
        alarmImageView.image = UIImage(sharedNamed: "alarm_disable.png")
        alarmLabel.textColor = .grayB5B8BE
    }
}
