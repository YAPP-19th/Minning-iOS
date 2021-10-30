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
        $0.font = .font16PMedium
        $0.textColor = .gray787C84
        return $0
    }(UILabel())
    
    private let countLabel: UILabel = {
        $0.font = .font16PMedium
        $0.textColor = .minningBlue100
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
        countLabel.text = "\(count)"
    }
    
    private func setupView() {
        backgroundColor = .grayF6F7F9
        layer.cornerRadius = 10
        
        [resultImageView, titleLabel, countLabel].forEach {
            addSubview($0)
        }
        
        resultImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-14)
        }
        countLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
}
