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
    private let titleLabel: UILabel = {
        $0.textColor = .primaryBlack
        $0.font = .font16PBold
        return $0
    }(UILabel())
    private let titleCompleteLabel: UILabel = {
        $0.textColor = .primaryBlack
        $0.font = .font16PBold
        return $0
    }(UILabel())
    private let descriptionLabel: UILabel = {
        $0.font = .font14PMedium
        $0.textColor = .minningDarkGray100
        return $0
    }(UILabel())
    private let descriptionCompleteLabel: UILabel = {
        $0.font = .font14PMedium
        $0.textColor = .minningDarkGray100
        return $0
    }(UILabel())
    private let completeLabel: UILabel = {
        $0.font = .font12P
        $0.textColor = .minningBlue100
        return $0
    }(UILabel())
    private let lockImageView = UIImageView()
    
    private var titleString: String?
    private var descriptionString: String?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ routine: RoutineModel, isEnabled: Bool) {
        titleString = routine.title
        descriptionString = routine.goal
        
        lockImageView.isHidden = true
        categoryBarView.backgroundColor = routine.category.color
        titleLabel.text = titleString
        descriptionLabel.text = descriptionString
        let titleAttString = NSMutableAttributedString(string: titleString ?? "")
        titleAttString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: .init(location: 0, length: titleAttString.length))
        titleCompleteLabel.attributedText = titleAttString
        let descAttString = NSMutableAttributedString(string: descriptionString ?? "")
        descAttString.addAttribute(.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: .init(location: 0, length: descAttString.length))
        descriptionCompleteLabel.attributedText = descAttString
        if !isEnabled {
            setViewAsDisable()
            return
        } else {
            setViewWithResult(routine.result)
        }
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
        
        [categoryBarView, titleLabel, titleCompleteLabel, descriptionLabel, descriptionCompleteLabel, completeLabel, lockImageView].forEach {
            contentView.addSubview($0)
        }
        lockImageView.image = UIImage(sharedNamed: "lock.png")
        
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
        titleCompleteLabel.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.leading.equalTo(categoryBarView.snp.trailing).offset(12)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(-14)
            make.leading.equalTo(titleLabel.snp.leading)
        }
        descriptionCompleteLabel.snp.makeConstraints { make in
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
    }

    private func setViewAsDisable() {
        titleLabel.isHidden = false
        titleCompleteLabel.isHidden = true
        descriptionLabel.isHidden = false
        descriptionCompleteLabel.isHidden = true
        completeLabel.isHidden = true
        lockImageView.isHidden = false
        categoryBarView.backgroundColor = .grayB5B8BE
        titleLabel.textColor = .grayB5B8BE
        descriptionLabel.textColor = .grayB5B8BE
    }
    
    private func setViewWithResult(_ result: RoutineResult) {
        switch result {
        case .done:
            titleLabel.isHidden = true
            titleCompleteLabel.isHidden = false
            descriptionLabel.isHidden = true
            descriptionCompleteLabel.isHidden = false
            completeLabel.isHidden = false
            completeLabel.text = result.title
        case .tried:
            titleLabel.isHidden = false
            titleCompleteLabel.isHidden = true
            descriptionLabel.isHidden = false
            descriptionCompleteLabel.isHidden = true
            completeLabel.isHidden = false
            completeLabel.text = result.title
        case .failure:
            titleLabel.isHidden = false
            titleCompleteLabel.isHidden = true
            descriptionLabel.isHidden = false
            descriptionCompleteLabel.isHidden = true
            completeLabel.isHidden = true
        case .relax:
            return
        }
    }
}
