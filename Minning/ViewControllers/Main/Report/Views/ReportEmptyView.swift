//
//  ReportEmptyView.swift
//  Minning
//
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit
import UIKit

final class ReportEmptyView: UIView {
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 41
        return stackView
    }()
    
    private let characterContainerView: UIView = UIView()
    private let characterView: UIImageView = {
        $0.image = UIImage(sharedNamed: "reportEmptyIcon")
        return $0
    }(UIImageView())
    
    private let contentLabel: UILabel = {
        $0.text = "아직 리포트가 나오지 않았어요"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .font20PBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let subcontentLabel: UILabel = {
        $0.text = "주 리포트는 매주 수요일,\n월 리포트는 매월 첫째주에 확인할 수 있어요"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .font16P
        $0.textColor = .gray787C84
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .minningLightGray100
        addSubview(contentStackView)
        [characterContainerView, contentLabel, subcontentLabel].forEach {
            contentStackView.addArrangedSubview($0)
        }
        
        characterContainerView.addSubview(characterView)
        
        contentStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        characterContainerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(105)
        }
        
        characterView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
        }
        
        contentStackView.setCustomSpacing(31, after: contentLabel)
        
        subcontentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
