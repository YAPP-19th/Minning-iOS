//
//  GroupListCellViewController.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/12.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupListTableViewCell: UITableViewCell {
    static let identifier = "GroupListCell"
    
    var cellBackgroundView: UIView = {
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UIView())
    
    var cellView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())
    
    var iconBackgroundView: UIImageView = {
        $0.layer.cornerRadius = 7
        return $0
    }(UIImageView())
    
    var iconImageView: UIImageView = {
        return $0
    }(UIImageView())
    
    var titleLabel: UILabel = {
        $0.font = .font18PBold
        return $0
    }(UILabel())
    
    var achieveRateView: UIView = {
        $0.backgroundColor = .minningBlue20
        $0.layer.cornerRadius = 5
        return $0
    }(UIView())
    
    private var achieveLabelCount: Int = 106
    
    var groupListAchieveRateLabel: UILabel = {
        $0.textColor = .minningBlue100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    var participantLabel: UILabel = {
        $0.textColor = .minningDarkGray100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ groups: GroupModel) {
        titleLabel.text = groups.title
        groupListAchieveRateLabel.text = {
            if groups.rate == nil {
                return "평균 달성률 0%"
            } else {
                return "평균 달성률 \(groups.rate)%"
            }
        }()
        iconImageView.image = {
            switch groups.category {
            case 0:
                return UIImage(sharedNamed: "categoryMiracleMorningIcon")
            case 1:
                return UIImage(sharedNamed: "categorySelfImproveIcon")
            case 2:
                return UIImage(sharedNamed: "categoryExcerciseIcon")
            case 3:
                return UIImage(sharedNamed: "categoryLifeIcon")
            case 4:
                return UIImage(sharedNamed: "categoryWakeUp")
            default:
                return UIImage(sharedNamed: "categoryEctIcon")
            }
        }()
        iconBackgroundView.backgroundColor = {
            switch groups.category {
            case 0:
                return .cateSky100
            case 1:
                return .cateRed100
            case 2:
                return .cateGreen100
            case 3:
                return .cateYellow100
            case 4:
                return .minningBlue100
            default:
                return .cateSky100
            }
        }()
        
        participantLabel.text = "\(groups.participant)명 참여중"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }
    
    private func isCellSelected(_ sender: Any) {
        
    }
    
    private func setupView() {
        self.selectionStyle = .none
        self.layer.cornerRadius = 10
        self.backgroundColor = .minningLightGray100
        
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(cellView)
        [iconBackgroundView, iconImageView, titleLabel, achieveRateView, groupListAchieveRateLabel, participantLabel].forEach {
            cellView.addSubview($0)
        }
        
        layer.cornerRadius = 10
        backgroundColor = .white
        
        cellBackgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        cellView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview()
        }
        
        iconBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.bottom.equalToSuperview().offset(-25)
            make.width.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(iconBackgroundView.snp.leading).offset(10)
            make.trailing.equalTo(iconBackgroundView.snp.trailing).offset(-10)
            make.top.equalTo(iconBackgroundView.snp.top).offset(10)
            make.bottom.equalTo(iconBackgroundView.snp.bottom).offset(-10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconBackgroundView.snp.trailing).offset(16)
            make.top.equalTo(iconBackgroundView.snp.top)
        }
        
        achieveRateView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.equalTo(titleLabel.snp.leading)
            make.width.equalTo(achieveLabelCount + 5)
            make.height.equalTo(23)
        }
        
        groupListAchieveRateLabel.snp.makeConstraints { make in
            make.center.equalTo(achieveRateView.snp.center)
            make.height.equalTo(14)
        }
        
        achieveRateView.snp.makeConstraints { make in
            make.centerY.equalTo(achieveRateView.snp.centerY)
            make.leading.equalTo(achieveRateView.snp.trailing).offset(8)
        }
        
        participantLabel.snp.makeConstraints { make in
            make.top.equalTo(groupListAchieveRateLabel.snp.top)
            make.leading.equalTo(achieveRateView.snp.trailing).offset(8)
        }
    }
}
