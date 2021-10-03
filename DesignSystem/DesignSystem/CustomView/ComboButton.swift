//
//  ComboButton.swift
//  DesignSystem
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import SharedAssets
import SnapKit

public class ComboButton: UIButton {
    private let contentLabel: UILabel = {
        $0.font = .font16PMedium
        $0.textColor = .gray787C84
        return $0
    }(UILabel())
    
    private let arrowImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "arrow_down")
        return $0
    }(UIImageView())
    
    public var comboContent: String = "" {
        didSet {
            contentLabel.text = comboContent
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [contentLabel, arrowImageView].forEach {
            addSubview($0)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentLabel.snp.trailing).offset(9)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
