//
//  BottomSheetViewController.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit
import UIKit

class BottomSheetViewController: UIViewController {
    private let dimmedView: UIView = {
        $0.backgroundColor = .primaryBlack.withAlphaComponent(0.4)
        return $0
    }(UIView())
    
    private let bottomSheetView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        $0.clipsToBounds = true
        return $0
    }(UIView())
    
    private let titleLabel: UILabel = {
        $0.text = "그동안 수고했어요!"
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let subtitleLabel: UILabel = {
        $0.text = "그룹 기간이 종료되었습니다."
        $0.font = .font16P
        return $0
    }(UILabel())
    
    private let imageView: UIImageView = {
        $0.image = UIImage(sharedNamed: "groupEndedImage")
        return $0
    }(UIImageView())
    
    private let button: UIButton = {
        $0.backgroundColor = .minningBlue100
        $0.layer.cornerRadius = 10
        $0.setTitle("확인했어요", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        view.addSubview(dimmedView)
        dimmedView.addSubview(bottomSheetView)
        
//        [titleLabel, subtitleLabel, button, imageView].forEach {
//            bottomSheetView.addSubview($0)
//        }
//        
//        dimmedView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
//        bottomSheetView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(267)
//            make.leading.equalTo(view.snp.leading)
//            make.trailing.equalTo(view.snp.trailing)
//            make.bottom.equalTo(view.snp.bottom)
//        }
//        
//        titleLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(50)
//            make.centerX.equalToSuperview()
//        }
//        
//        subtitleLabel.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(7)
//            make.centerX.equalToSuperview()
//        }
//        
//        imageView.snp.makeConstraints { make in
//            make.top.equalTo(subtitleLabel.snp.bottom).offset(36)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(161)
//            make.width.equalTo(212)
//        }
//        
//        button.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
//            make.height.equalTo(50)
//        }
    }
}
