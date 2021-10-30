//
//  addCategoryView.swift
//  Minning
//
//  Created by 박지윤 on 2021/10/18.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class AddCategoryView: UIView {
    enum CategoryType {
        case miracleMorning
        case selfImprove
        case health
        case life
        case etc
        
        var image: UIImage? {
            switch self {
            case .miracleMorning:
                return UIImage(sharedNamed: "categoryMiracleMorningIcon")
            case .selfImprove:
                return UIImage(sharedNamed: "categorySelfImproveIcon")
            case .health:
                return UIImage(sharedNamed: "categoryExcerciseIcon")
            case .life:
                return UIImage(sharedNamed: "categoryLifeIcon")
            case .etc:
                return UIImage(sharedNamed: "categoryEtcIcon")
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .miracleMorning:
                return .cateSky100
            case .selfImprove:
                return .cateRed100
            case .health:
                return .cateGreen100
            case .life:
                return .cateYellow100
            case .etc:
                return .catePurple100
            }
        }
        
        var title: String {
            switch self {
            case .miracleMorning:
                return "미라클모닝"
            case .selfImprove:
                return "자기개발"
            case .health:
                return "건강"
            case .life:
                return "생활"
            case .etc:
                return "기타"
            }
        }
    }
    
    private let category: CategoryType
    
    private var isSelected: Bool = false
    
    private let categoryIconImageView: UIImageView = {
        return $0
    }(UIImageView())
    
    private let categorySelectedView: UIView = {
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return $0
    }(UIView())
    
    private let categorySelectedImageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "checkmark")
        return $0
    }(UIImageView())
    
    private let categoryLabel: UILabel = {
        $0.font = .font12PBold
        $0.textColor = .white
        return $0
    }(UILabel())
    
    init(category: CategoryType) {
        self.category = category
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        categorySelectedView.isHidden = !isSelected
        
        isUserInteractionEnabled = true
        
        layer.cornerRadius = 10
        clipsToBounds = true
        addSubview(categoryIconImageView)
        addSubview(categoryLabel)
        
        backgroundColor = category.backgroundColor
        categoryLabel.text = category.title
        categoryIconImageView.image = category.image
        
        categoryIconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(9)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryIconImageView.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        
        categorySelectedView.addSubview(categorySelectedImageView)
        
        addSubview(categorySelectedView)
        
        categorySelectedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        categorySelectedImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(14.19)
            make.width.equalTo(14.3)
        }
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(isButtonSelected(_:))))
    }
    
    @objc
    private func isButtonSelected(_ sender: Any) {
        isSelected.toggle()
        categorySelectedView.isHidden = !isSelected
    }
}
