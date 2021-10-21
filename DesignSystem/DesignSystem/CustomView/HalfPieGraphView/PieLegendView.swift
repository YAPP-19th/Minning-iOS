//
//  PieLegendView.swift
//  DesignSystem
//
//  Created by denny on 2021/10/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

public class PieLegendView: UIView {
    public var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public var circleColor: UIColor = .clear {
        didSet {
            circleView.backgroundColor = circleColor
        }
    }
    
    private let circleView: UIView = {
        $0.layer.cornerRadius = 7
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.font = .font12P
        $0.textColor = .gray787C84
        return $0
    }(UILabel())
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [circleView, titleLabel].forEach {
            addSubview($0)
        }
        
        circleView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.height.equalTo(14)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(circleView.snp.trailing).offset(4)
        }
    }
}
