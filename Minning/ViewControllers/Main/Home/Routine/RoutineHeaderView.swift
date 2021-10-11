//
//  RoutineHeaderView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import SnapKit

final class RoutineHeaderView: UICollectionReusableView {
    static let identifier = "RoutineHeaderView"
    
    private let routineButton: UIButton = {
        $0.setTitle("루틴", for: .normal)
        $0.setTitleColor(.primaryBlack, for: .normal)
        $0.titleLabel?.font = .font20PExBold
        return $0
    }(UIButton())
    
    private let reviewButton: UIButton = {
        $0.setTitle("돌아보기", for: .normal)
        $0.setTitleColor(.primaryBlack, for: .normal)
        $0.titleLabel?.font = .font20PExBold
        return $0
    }(UIButton())

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViewLayout() {
        [routineButton, reviewButton].forEach {
            addSubview($0)
        }
        
        routineButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
        }

        reviewButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalTo(routineButton.snp.trailing).offset(21)
        }
    }
}
