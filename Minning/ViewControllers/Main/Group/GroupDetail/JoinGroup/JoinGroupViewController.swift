//
//  JoinGroupViewController.swift
//  Minning
//
//  Created by denny on 2021/10/04.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class JoinGroupViewController: BaseViewController {
    private let backgroundView: UIView = UIView()
    private let contentView: UIView = {
        $0.backgroundColor = .primaryWhite
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return $0
    }(UIView())
    
    private let titleSectionLabel: UILabel = {
        $0.text = "그룹 참여 기간"
        $0.font = .font12PBold
        $0.textColor = .primaryTextGray
        return $0
    }(UILabel())
    
    private let joinButton: PlainButton = {
        $0.setTitle("참여하기", for: .normal)
        return $0
    }(PlainButton())
    
    private let viewModel: JoinGroupViewModel
    
    public init(viewModel: JoinGroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bindViewModel() {
        
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .clear
        [backgroundView, contentView].forEach {
            view.addSubview($0)
        }
        backgroundView.backgroundColor = .primaryBlack040
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
        [joinButton, titleSectionLabel].forEach {
            contentView.addSubview($0)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        
        titleSectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33)
            make.leading.equalToSuperview().offset(26)
        }
        
        joinButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }
    }
    
    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
