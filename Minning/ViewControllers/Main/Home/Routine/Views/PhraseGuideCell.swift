//
//  PhraseGuideCell.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

final class PhraseGuideCell: UITableViewCell {
    static let identifier = "PhraseGuideCell"

    private let titleLabel: UILabel = {
        $0.text = "글을 따라쓰고 오늘 루틴을 시작해봐요"
        $0.font = .font16PBold
        $0.textColor = .primaryWhite
        return $0
    }(UILabel())
    
    private let pencilImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "pencil.png")
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .blue67A4FF
        contentView.layer.cornerRadius = 10

        [titleLabel, pencilImageView].forEach {
            contentView.addSubview($0)
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-8)
            make.top.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(16)
        }
        
        pencilImageView.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.centerY.trailing.equalToSuperview()
        }
    }
}
