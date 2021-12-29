//
//  ReviewCell.swift
//  Minning
//
//  Created by 고세림 on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

final class ReviewCell: UITableViewCell {
    static let identifier = "ReviewCell"
    
    private let categoryBarView = UIView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let reviewImageView: UIImageView = {
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ retrospect: RetrospectModel) {
        categoryBarView.backgroundColor = retrospect.routine.category.color
        titleLabel.text = retrospect.routine.title
        if let url = URL(string: retrospect.imageUrl ?? ""), let data = try? Data(contentsOf: url) {
            self.reviewImageView.image = UIImage(data: data)
        } else {
            self.reviewImageView.image = nil
        }
        
        if let content = retrospect.content {
            descriptionLabel.text = content
        } else {
            descriptionLabel.text = "피드백을 적어주세요"
        }
    }
    
    private func setupViewLayout() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.backgroundColor = .primaryWhite
        contentView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        
        layer.shadowRadius = 4
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        
        [categoryBarView, titleLabel, descriptionLabel, reviewImageView].forEach {
            contentView.addSubview($0)
        }
        
        titleLabel.font = .font16PBold
        descriptionLabel.font = .font14PMedium
        descriptionLabel.textColor = .minningDarkGray100
        
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(4)
            make.bottom.equalTo(-4)
        }
        categoryBarView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(3)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(categoryBarView.snp.trailing).offset(12)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-14)
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(reviewImageView.snp.leading).offset(-27)
        }
        reviewImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.trailing.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
    }
}
