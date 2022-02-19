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
    
    let day: Day
    
    var isSelected: Bool = false {
        didSet {
            if isSelected {
                backgroundColor = .minningDarkGray100
                dayLabel.textColor = .primaryWhite
            } else {
                backgroundColor = .minningLightGray100
                dayLabel.textColor = .minningGray100
            }
        }
    }
    
    private lazy var dayLabel: UILabel = {
        $0.text = day.korean
        $0.font = .font14P
        $0.textColor = .minningGray100
        return $0
    }(UILabel())
    
    init(day: Day) {
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
