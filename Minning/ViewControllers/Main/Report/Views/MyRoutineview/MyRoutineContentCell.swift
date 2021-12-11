//
//  MyRoutineContentCell.swift
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

final class MyRoutineContentCell: UITableViewCell {
    static let identifier: String = "MyRoutineContentCell"
    
    public var weeklyRoutineData: [Routine] = [] {
        didSet {
            for (index, itemView) in itemViewList.enumerated() {
                itemView.routineItem = weeklyRoutineData.count > index ? weeklyRoutineData[index] : nil
            }
            itemTitleLabel.text = weeklyRoutineData.first?.title
        }
    }
    
    private let itemTitleContainer: UIView = {
        $0.backgroundColor = .primaryWhite
        return $0
    }(UIView())
    
    private let itemTitleLabel: UILabel = {
        $0.font = .font14PMedium
        $0.textColor = .primaryBlack
        $0.backgroundColor = .primaryWhite
        return $0
    }(UILabel())
    
    private let itemStackView: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 2
        return $0
    }(UIStackView())
    
    private let itemViewList: [MyRoutineContentItemView] = [
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView(),
        MyRoutineContentItemView()
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentViewLayout() {
        backgroundColor = .clear
        
        [itemTitleContainer, itemStackView].forEach {
            contentView.addSubview($0)
        }
        itemTitleContainer.addSubview(itemTitleLabel)
        
        for itemView in itemViewList {
            itemStackView.addArrangedSubview(itemView)
        }
        
        itemStackView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
        itemTitleContainer.snp.makeConstraints { make in
            make.trailing.equalTo(itemStackView.snp.leading).offset(-2)
            make.leading.top.equalToSuperview()
            make.bottom.equalTo(-2)
        }
        
        itemTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(4)
            make.trailing.lessThanOrEqualTo(-4)
        }
    }
}
