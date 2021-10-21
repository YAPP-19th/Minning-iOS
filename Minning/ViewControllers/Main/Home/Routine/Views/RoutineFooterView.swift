//
//  RoutineFooterView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

final class RoutineFooterView: UIView {    
    private let editOrderButton: UIButton = {
        $0.setTitle("순서 편집", for: .normal)
        $0.setTitleColor(.grayB5B8BE, for: .normal)
        $0.titleLabel?.font = .font16PBold
        $0.addTarget(self, action: #selector(onClickEditOrderButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    var editOrderButtonHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onClickEditOrderButton(_ sender: UIButton) {
        if let handler = editOrderButtonHandler {
            handler()
        }
    }
        
    private func setupViewLayout() {
        [editOrderButton].forEach {
            addSubview($0)
        }
        
        editOrderButton.snp.makeConstraints { make in
            make.top.equalTo(18)
            make.centerX.equalToSuperview()
            make.width.equalTo(66)
            make.height.equalTo(19)
        }
    }
}
