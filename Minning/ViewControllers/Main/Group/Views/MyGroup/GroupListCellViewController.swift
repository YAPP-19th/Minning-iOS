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

class GroupListCellViewController: UITableViewCell {
    static let identifier = "GroupListCell"
    
    let cellView = MyGroupCellView()
    
    let model = MyGroupCategoryModel(category: .miracleMorning, title: "명상그룹", percentage: "100", day: "토, 일", dayLeft: "8")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let viewModel = GroupListCellViewModel(model: self.model)
        viewModel.configure(cellView)
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
