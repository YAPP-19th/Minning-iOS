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
        $0.backgroundColor = .minningLightGray100
        $0.distribution = .equalSpacing
        $0.layer.cornerRadius = 10
        $0.spacing = 6
        return $0
    }(UIStackView())
    
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
        for (idx, view) in [monLabel, tueLabel, wedLabel, thuLabel,
                            friLabel, satLabel, sunLabel].enumerated() {
            view.text = daySymbols[idx]
            view.textColor = .minningDarkGray100
            view.font = .font12P
            view.textAlignment = .center
            
            view.snp.makeConstraints { make in
                make.width.height.equalTo(30)
            }
            
            titleStackView.addArrangedSubview(view)
        }
        
        titleStackView.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
        }
    }
}
