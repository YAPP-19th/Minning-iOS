//
//  ReportArriveView.swift
//  Minning
//
//  Created by 박지윤 on 2021/12/19.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit
import UIKit
import Lottie

final class ReportArriveViewController: UIViewController {
    private let animationView: AnimationView = {
        return $0
    }(AnimationView())
    
    private let firstTitle: UILabel = {
        $0.text = "리포트가 도착했어요!"
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let secondTitle: UILabel = {
        $0.text = "눌러서 확인해보세요"
        $0.font = .font20PBold
        return $0
    }(UILabel())
    
    private let boxArriveButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "reportArrive"), for: .normal)
        $0.addTarget(self, action: #selector(isclickedBox), for: .touchUpInside)
        return $0
    }(UIButton())
    
//    private let nextTimeButton: UIButton = {
//        $0.setTitle("다음에 할게요", for: .normal)
//        $0.setTitleColor(.gray787C84, for: .normal)
//        return $0
//    }(UIButton())
    
    override func viewDidLoad() {
        setupView()
        playAnimation()
    }
    
    private func playAnimation() {
        animationView.frame = view.bounds
        animationView.animation = Animation.named("partyLottie")
        animationView.contentMode = .scaleAspectFit
        animationView.animationSpeed = 1.3
        animationView.play()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(animationView)
        
        [firstTitle, secondTitle, boxArriveButton].forEach {
            view.addSubview($0)
        }
        
        firstTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(162)
            make.centerX.equalToSuperview()
        }
        
        secondTitle.snp.makeConstraints { make in
            make.top.equalTo(firstTitle.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
        
        boxArriveButton.snp.makeConstraints { make in
            make.top.equalTo(secondTitle.snp.bottom).offset(61)
            make.centerX.equalToSuperview()
            make.width.equalTo(212)
            make.height.equalTo(199)
        }
        
//        nextTimeButton.snp.makeConstraints { make in
//            make.top.equalTo(boxArriveButton.snp.bottom).offset(49)
//            make.centerX.equalToSuperview()
//        }
        
        animationView.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.frame.height/2)
        }
    }
    
    @objc func isclickedBox(_ sender: Any?) {
        dismiss(animated: true)
    }
    
    @objc func iclickedNextTIme(_ sender: Any?) {
//        goToMain()
    }
}
