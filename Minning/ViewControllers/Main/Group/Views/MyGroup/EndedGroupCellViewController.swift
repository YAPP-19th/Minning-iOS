//
//  EndedGroupCellViewController.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/12.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

class EndedGroupCellViewController: UITableViewCell {
    static let identifier = "MyGroupCell"
    
    let cellView = GroupCellView(category: .myGroup)
    
    let onGoingViewModel = MyGroupCategoryModel(category: .wakeupTime, title: "새벽 5시 기상 그룹", percentage: "100", day: "토, 일", dayLeft: "8")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let onGoingviewModel = GroupListCellViewModel(model: self.onGoingViewModel)
        onGoingviewModel.configure(cellView, category: .myGroup)
        addSubview(cellView)
        
        self.selectionStyle = .none
        self.layer.cornerRadius = 10
        self.backgroundColor = .minningLightGray100
        
        cellView.snp.makeConstraints { make in
            make.height.equalTo(112)
            make.top.equalToSuperview().offset(6)
            make.bottom.equalToSuperview().offset(-6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }
    
    private func isCellSelected(_ sender: Any) {
        
    }
    
}