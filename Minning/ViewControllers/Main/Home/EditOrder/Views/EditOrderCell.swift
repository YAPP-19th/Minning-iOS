//
//  EditOrderCell.swift
//  Minning
//
//  Created by 고세림 on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class EditOrderCell: UITableViewCell {
    static let identifier = "EditOrderCell"
    
    private let categoryBarView = UIView()
    private let titleLabel = UILabel()
    private let editOrderImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "list_selection.png")
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ routine: RoutineModel) {
        setTempData()
        titleLabel.text = routine.title
        categoryBarView.backgroundColor = routine.category.color
    }
    
    private func setupViewLayout() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.backgroundColor = .primaryWhite
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        
        [categoryBarView, titleLabel, editOrderImageView].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.font = .font16PBold
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
        }
        categoryBarView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(categoryBarView.snp.trailing).offset(12)
        }
        editOrderImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(12)
            make.height.equalTo(7)
        }
    }
    
    private func setTempData() {
        categoryBarView.backgroundColor = .minningBlue100
    }
}
