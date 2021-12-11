//
//  MyRoutineTitleCell.swift
//  Minning
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class MyRoutineTitleCell: UITableViewCell {
    static let identifier: String = "MyRoutineTitleCell"
    
    private let titleStackView: UIStackView = {
        $0.axis = .horizontal
        $0.backgroundColor = .grayEEF1F5
        $0.spacing = 2
        return $0
    }(UIStackView())
    
    private let routineLabel: UILabel = {
        $0.text = "루틴"
        $0.textColor = .minningDarkGray100
        $0.font = .font14P
        $0.textAlignment = .center
        $0.backgroundColor = .minningLightGray100
        return $0
    }(UILabel())
    
    private let monLabel: UILabel = UILabel()
    private let tueLabel: UILabel = UILabel()
    private let wedLabel: UILabel = UILabel()
    private let thuLabel: UILabel = UILabel()
    private let friLabel: UILabel = UILabel()
    private let satLabel: UILabel = UILabel()
    private let sunLabel: UILabel = UILabel()
    
    private let daySymbols: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.addSubview(titleStackView)
        titleStackView.addArrangedSubview(routineLabel)
        
        let routineLabelWidth = self.frame.width - 259
        routineLabel.snp.makeConstraints { make in
            make.width.equalTo(routineLabelWidth)
            make.height.equalTo(35)
        }
        
        for (idx, view) in [monLabel, tueLabel, wedLabel, thuLabel,
                            friLabel, satLabel, sunLabel].enumerated() {
            view.text = daySymbols[idx]
            view.textColor = .minningDarkGray100
            view.font = .font14P
            view.textAlignment = .center
            view.backgroundColor = .minningLightGray100
            
            view.snp.makeConstraints { make in
                make.width.height.equalTo(35)
            }
            
            titleStackView.addArrangedSubview(view)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.centerY.leading.trailing.equalToSuperview()
        }
    }
}
