//
//  WeeklyPercentView.swift
//  Minning
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit
import UIKit

final class WeeklyPercentView: UIView {
    public var weekModel: ReportWeekModel? {
        didSet {
            percentValueLabel.text = "\(weekModel?.rate ?? 0)"
            
            resultStackView.subviews.forEach { view in
                view.removeFromSuperview()
            }
            
            let completeView = WeeklyResultView(resultType: .complete, count: weekModel?.fullyDoneCount ?? 0)
            let halfView = WeeklyResultView(resultType: .half, count: weekModel?.partiallyDoneCount ?? 0)
            let incompleteView = WeeklyResultView(resultType: .incomplete, count: weekModel?.notDoneCount ?? 0)
            [completeView, halfView, incompleteView].forEach {
                resultStackView.addArrangedSubview($0)
            }
        }
    }
    
    private let titleLabel: UILabel = {
        $0.text = "이번주 내 달성률"
        $0.font = .font16P
        $0.textColor = .gray787C84
        return $0
    }(UILabel())
    
    private let percentGuideButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "questionButton.png"), for: .normal)
        $0.addTarget(self, action: #selector(onClickPercentGuideButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())

    private let percentValueLabel: UILabel = {
        $0.text = "0"
        $0.font = .font50PHeavy
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let percentLabel: UILabel = {
        $0.text = "%"
        $0.font = .font30P
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let percentStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 4
        return $0
    }(UIStackView())
    
    private let descriptionLabel: UILabel = {
        $0.text = "일주일동안 고생했어요 👍"
        $0.font = .font22PExBold
        $0.textColor = .primaryBlack
        return $0
    }(UILabel())
    
    private let resultStackView: UIStackView = {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 0
        return $0
    }(UIStackView())
    
    private let bubbleView: UIView = {
        $0.backgroundColor = .minningLightGray100
        $0.layer.cornerRadius = 10
        $0.isHidden = true
        return $0
    }(UIView())
    
    private let bubbleTriagleView: UIImageView = {
        $0.image = UIImage(sharedNamed: "bubble_triangle_weekly")
        $0.isHidden = true
        return $0
    }(UIImageView())
    
    private let bubbleLabel: UILabel = {
        $0.text = "{(완료한 루틴×1)+(부분완료한 루틴×0.5)}/전체 루틴"
        $0.textColor = .minningDarkGray100
        $0.font = .font14P
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onClickPercentGuideButton(_ sender: Any) {
        bubbleTriagleView.isHidden.toggle()
        bubbleView.isHidden.toggle()
    }
    
    @objc
    private func onClickBackground(_ sender: Any) {
        guard bubbleTriagleView.isHidden == false, bubbleView.isHidden == false else { return }
        bubbleTriagleView.isHidden = true
        bubbleView.isHidden = true
    }
    
    private func setupView() {
        isUserInteractionEnabled = true
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onClickBackground(_:))))
        backgroundColor = .primaryWhite
        
        [descriptionLabel, percentStackView, titleLabel, percentGuideButton, resultStackView, bubbleTriagleView, bubbleView].forEach {
            addSubview($0)
        }
        [percentValueLabel, percentLabel].forEach {
            percentStackView.addArrangedSubview($0)
        }
        bubbleView.addSubview(bubbleLabel)
        
        let completeView = WeeklyResultView(resultType: .complete, count: 10)
        let halfView = WeeklyResultView(resultType: .half, count: 10)
        let incompleteView = WeeklyResultView(resultType: .incomplete, count: 10)
        [completeView, halfView, incompleteView].forEach {
            resultStackView.addArrangedSubview($0)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
        }
        percentStackView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom)
            make.leading.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(percentStackView.snp.bottom).offset(4)
            make.leading.equalTo(20)
        }
        percentGuideButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.leading.equalTo(titleLabel.snp.trailing).offset(-9)
            make.width.height.equalTo(44)
        }
        resultStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(52)
            make.bottom.equalTo(-20)
            make.height.equalTo(120)
        }
        bubbleTriagleView.snp.makeConstraints { make in
            make.top.equalTo(percentGuideButton.snp.bottom).offset(-13)
            make.centerX.equalTo(percentGuideButton)
            make.width.equalTo(16.87)
            make.height.equalTo(16.14)
        }
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(bubbleTriagleView.snp.bottom).offset(-1)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
            make.height.equalTo(50)
        }
        bubbleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
