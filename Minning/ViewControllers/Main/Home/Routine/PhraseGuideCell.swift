//
//  PhraseGuideCell.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

class PhraseGuideCell: UICollectionViewCell {
    
    static let identifier = "PhraseGuideCell"
    
    private let titleLabel: UILabel = {
        $0.text = "글을 따라쓰고 오늘 루틴을 시작해봐요"
        $0.font = .font14PBold
        $0.textColor = .primaryWhite
        return $0
    }(UILabel())
    
    private let pencilImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "pencil.png")
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        layer.cornerRadius = 10
        
        backgroundColor = .minningBlue100
        
        [titleLabel, pencilImageView].forEach {
            addSubview($0)
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
