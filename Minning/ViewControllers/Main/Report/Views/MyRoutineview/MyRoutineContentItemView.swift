//
//  MyRoutineContentItemView.swift
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

final class MyRoutineContentItemView: UIView {
    private let symbolImageView: UIImageView = {
        return $0
    }(UIImageView())
    
    public var routineItem: Routine? {
        didSet {
            symbolImageView.image = routineItem?.result.symbolImage?.withRenderingMode(.alwaysTemplate)
            symbolImageView.layer.opacity = routineItem?.result.symbolOpacity ?? 0
            symbolImageView.tintColor = routineItem?.result == .failure ? .primaryGray : routineItem?.category.color
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.snp.makeConstraints { make in
            make.width.height.equalTo(30)
        }
        
        backgroundColor = .grayF6F7F9
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        addSubview(symbolImageView)
        symbolImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
