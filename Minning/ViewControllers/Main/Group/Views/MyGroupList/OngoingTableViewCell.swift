//
//  GroupViewModel.swift
//  Minning
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

class OngoingTableViewCell: UITableViewCell {
    static let identifier = "OngoingGroupCell"
    
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
    
    private var achieveLabelCount: Int = 101
    
    var personalAchieveRateLabel: UILabel = {
        $0.textColor = .minningBlue100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    var dayLabel: UILabel = {
            $0.textColor = .minningDarkGray100
            $0.font = .font14P
            return $0
        }(UILabel())
        
    var dayLeftLabel: UILabel = {
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
    
    func configure(_ groups: MissionModel) {
        titleLabel.text = groups.title
        personalAchieveRateLabel.text = {
            if groups.achievementRate == nil {
                return "내 달성률 0%"
            } else {
                return "내 달성률 \(groups.achievementRate)"
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

        var dayLabelToKorean: String = ""
        
        var dayCount: Int = groups.weeks.count
        
        for week in groups.weeks {
            dayCount -= 1
            if dayCount != 1 {
                dayLabelToKorean += "\(week.korean), "
            } else {
                dayLabelToKorean += "\(week.korean)"
            }
        }
        
        dayLabel.text = dayLabelToKorean
        
        dayLeftLabel.text = "D-\(groups.period)"

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func isCellSelected(_ sender: Any) {
        
    }
    
    private func setupView() {
        self.selectionStyle = .none
        self.layer.cornerRadius = 10
        self.backgroundColor = .minningLightGray100
        
        addSubview(cellBackgroundView)
        cellBackgroundView.addSubview(cellView)
        [iconBackgroundView, iconImageView, titleLabel, achieveRateView, personalAchieveRateLabel,  dayLabel, dayLeftLabel].forEach {
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
        
        personalAchieveRateLabel.snp.makeConstraints { make in
            make.center.equalTo(achieveRateView.snp.center)
            make.height.equalTo(14)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(personalAchieveRateLabel.snp.top)
            make.leading.equalTo(achieveRateView.snp.trailing).offset(8)
        }
        
        dayLeftLabel.snp.makeConstraints { make in
            make.top.equalTo(personalAchieveRateLabel.snp.top)
            make.leading.equalTo(dayLabel.snp.trailing).offset(4)
        }
    }
    
}
