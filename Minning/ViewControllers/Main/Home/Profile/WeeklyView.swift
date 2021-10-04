//
//  WeeklyView.swift
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

public struct WeeklyData {
    let date: Date
    let progress: CGFloat // 0.0 ~ 1.0
}

public enum WeeklyText: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    
    var title: String {
        switch self {
        case .sunday:
            return "월"
        case .monday:
            return "월"
        case .tuesday:
            return "화"
        case .wednesday:
            return "수"
        case .thursday:
            return "목"
        case .friday:
            return "금"
        case .saturday:
            return "토"
        }
    }
}

final class WeeklyView: UIView {
    private let dateLabel: UILabel = {
        $0.font = .font12P
        $0.textColor = .primaryTextGray
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let progressView: CircleProgressView = {
        $0.backgroundColor = .clear
        $0.lineCap = .round
        $0.lineWidth = 3
        $0.pathBackgroundColor = .primaryLightGray
        $0.progressColor = .primaryBlue
        return $0
    }(CircleProgressView())
    
    public var isTextBold: Bool = false {
        didSet {
            dateLabel.textColor = isTextBold ? .black : .primaryTextGray
            dateLabel.font = isTextBold ? .font12PBold : .font12P
        }
    }
    
    public var weeklyData: WeeklyData? {
        didSet {
            if let data = weeklyData {
                let dayValue = data.date.get(.day)
                dateLabel.text = "\(dayValue > 9 ? "" : "0")\(dayValue) \(WeeklyText(rawValue: data.date.get(.weekday))?.title ?? "-")"
//                progressView.setProgress(data.progress)
                progressView.animateProgressView(duration: 0.3, progress: data.progress)
            } else {
                dateLabel.text = "00 월"
            }
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
        [dateLabel, progressView].forEach {
            addSubview($0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.centerX.bottom.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.width.height.equalTo(23)
        }
    }
}
