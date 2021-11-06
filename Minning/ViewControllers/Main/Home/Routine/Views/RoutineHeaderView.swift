//
//  RoutineHeaderView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/11.
//  Copyright © 2021 Minning. All rights reserved.
//

import SnapKit

protocol RoutineHeaderCellDelegate: AnyObject {
    func didSelectRoutineTab()
    func didSelectReviewTab()
}

final class RoutineHeaderCell: UITableViewCell {
    static let identifier = "RoutineHeaderCell"

    private let routineButton: UIButton = {
        $0.setTitle("루틴", for: .normal)
        $0.setTitleColor(.primaryBlack, for: .normal)
        $0.titleLabel?.font = .font22PExBold
        $0.addTarget(self, action: #selector(onClickRoutineButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private let reviewButton: UIButton = {
        $0.setTitle("돌아보기", for: .normal)
        $0.setTitleColor(.grayB5B8BE, for: .normal)
        $0.titleLabel?.font = .font22PExBold
        $0.addTarget(self, action: #selector(onClickReviewButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())

    weak var delegate: RoutineHeaderCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(delegate: RoutineHeaderCellDelegate, tabType: HomeViewModel.RoutineTabType) {
        self.delegate = delegate
        
        switch tabType {
        case .routine:
            routineButton.setTitleColor(.primaryBlack, for: .normal)
            reviewButton.setTitleColor(.grayB5B8BE, for: .normal)
        case .review:
            routineButton.setTitleColor(.grayB5B8BE, for: .normal)
            reviewButton.setTitleColor(.primaryBlack, for: .normal)
        }
    }
    
    @objc
    private func onClickRoutineButton(_ sender: UIButton) {
        delegate?.didSelectRoutineTab()
    }
    
    @objc
    private func onClickReviewButton(_ sender: UIButton) {
        delegate?.didSelectReviewTab()
    }
    
    private func setupViewLayout() {
        backgroundColor = .clear
        selectionStyle = .none
        
        [routineButton, reviewButton].forEach {
            contentView.addSubview($0)
        }
        
        routineButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        reviewButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(routineButton.snp.trailing).offset(21)
        }
    }
}
