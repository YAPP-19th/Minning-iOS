//
//  GroupQuitView.swift
//  Minning
//
//  Created by 고세림 on 2021/12/12.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class GroupQuitView: UIView {
    
    private let quitButton: UIButton = {
        let quitStr = NSMutableAttributedString(string: "그룹 중단하기", attributes: [.underlineStyle: 1.0])
        $0.setAttributedTitle(quitStr, for: .normal)
        $0.titleLabel?.font = .font16P
        $0.setTitleColor(.minningDarkGray100, for: .normal)
        $0.addTarget(self, action: #selector(onClickQuitButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onClickQuitButton(_ sender: Any) {
        
    }

    private func setupView() {
        backgroundColor = .minningLightGray100
        addSubview(quitButton)
        quitButton.snp.makeConstraints { make in
            make.top.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalTo(-104)
        }
    }
    
}
