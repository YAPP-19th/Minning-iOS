//
//  WeeklyResultView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

final class WeeklyResultView: UIView {
    enum ResultType {
        case complete
        case half
        case incomplete
        
        var image: UIImage? {
            switch self {
            case .complete:
                return UIImage(sharedNamed: "weekly_complete")
            case .half:
                return UIImage(sharedNamed: "weekly_half")
            case .incomplete:
                return UIImage(sharedNamed: "weekly_incomplete")
            }
        }
        var title: String {
            switch self {
            case .complete:
                return "완료"
            case .half:
                return "부분완료"
            case .incomplete:
                return "미완료"
            }
        }
    }
    
    private let resultImageView = UIImageView()
    private let titleLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .gray787C84
        return $0
    }(UILabel())
    
    private let countLabel: UILabel = {
        $0.font = .font16PMedium
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    init(resultType: ResultType, count: Int) {
        super.init(frame: .zero)
        setupView()
        configure(with: resultType, count: count)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(with resultType: ResultType, count: Int) {
        resultImageView.image = resultType.image
        titleLabel.text = resultType.title
        countLabel.text = "\(count)개"
    }
    
    private func setupView() {
        backgroundColor = .primaryWhite
        
        [resultImageView, titleLabel, countLabel].forEach {
            addSubview($0)
        }
        
        resultImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(resultImageView.snp.trailing).offset(11)
            make.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-30)
            make.centerY.equalToSuperview()
        }
    }
}
