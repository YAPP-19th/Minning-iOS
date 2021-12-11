//
//  AddDayView.swift
//  Minning
//
//  Created by 박지윤 on 2021/10/19.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class AddDayView: UIView {
    enum DayType {
        case mon
        case tue
        case wed
        case thu
        case fri
        case sat
        case sun
        
        var label: String {
            switch self {
            case .mon:
                return "월"
            case .tue:
                return "화"
            case .wed:
                return "수"
            case .thu:
                return "목"
            case .fri:
                return "금"
            case .sat:
                return "토"
            case .sun:
                return "일"
            }
        }
    }
    
    private let day: DayType
    
    private var isSelected: Bool = false
    
    private let dayLabel: UILabel = {
        return $0
    }(UILabel())
    
    init(day: DayType) {
        self.day = day
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        isUserInteractionEnabled = true
        
        layer.cornerRadius = 19
        clipsToBounds = true
        addSubview(dayLabel)
        backgroundColor = .minningLightGray100
        
        dayLabel.text = day.label
        dayLabel.font = .font14P
        dayLabel.textColor = .minningGray100
        
        dayLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(isButtonSelected(_:))))
    }
    
    @objc
    private func isButtonSelected(_ sender: Any) {
        isSelected.toggle()
        if isSelected {
            backgroundColor = .minningDarkGray100
            dayLabel.textColor = .primaryWhite
        } else {
            backgroundColor = .minningLightGray100
            dayLabel.textColor = .minningGray100
        }
    }

}
