//
//  GroupCellViewModel.swift
//  Minning
//
//  Created by 박지윤 on 2021/11/29.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupListCellViewModel {
    let model: MyGroupCategoryModel
    let cellColor: UIColor
    let cellIconImage: UIImage
    
    init(model: MyGroupCategoryModel) {
        self.model = model
        switch model.category {
        case .miracleMorning:
            cellColor = .cateSky100
            cellIconImage = UIImage(sharedNamed: "categoryMiracleMorningIcon")!
        case .selfImprovement:
            cellColor = .cateRed100
            cellIconImage = UIImage(sharedNamed: "categorySelfImproveIcon")!
        case .health:
            cellColor = .cateGreen100
            cellIconImage = UIImage(sharedNamed: "categoryExcerciseIcon")!
        case .life:
            cellColor = .cateYellow100
            cellIconImage = UIImage(sharedNamed: "categoryLifeIcon")!
        case .wakeupTime:
            cellColor = .blue67A4FF
            cellIconImage = UIImage(sharedNamed: "categoryWakeUp")!
        }
    }
    
    var title: String {
        return model.title
    }
    
    var percentage: String {
        return "내 달성률 \(model.percentage)%"
    }
    
    var day: String {
        return model.day
    }
    
    var dayLeft: String {
        return "D-\(model.dayLeft)"
    }
    
    var lenPercentage: Int {
        return percentage.count
    }

}

extension GroupListCellViewModel {
    func configure(_ view: MyGroupCellView) {
        view.titleLabel.text = title
        view.achieveRateLabel.text = percentage
        view.dayLabel.text = day
        view.dayLeftLabel.text = dayLeft
        view.iconBackgroundView.backgroundColor = cellColor
        view.iconImageView.image = cellIconImage
    }
}
