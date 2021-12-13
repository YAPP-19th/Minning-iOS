//
//  GroupCategoryCell.swift
//  Minning
//
//  Created by 박지윤 on 2021/10/31.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

class GroupCategoryCell: UICollectionViewCell {
    static let identifier = "GroupCategoryCell"
    
    var cellView: UIImageView = {
        return $0
    }(UIImageView())
    
    var label: UILabel = {
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(label)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(isViewSelected(_:))))
    }
    
    @objc
    private func isViewSelected(_ sender: Any) {
        isSelected.toggle()
        if isSelected {
            cellView.backgroundColor = .minningBlue100
            label.textColor = .white
        } else {
            cellView.backgroundColor = .clear
            label.textColor = .minningGray100
        }
    }
}
