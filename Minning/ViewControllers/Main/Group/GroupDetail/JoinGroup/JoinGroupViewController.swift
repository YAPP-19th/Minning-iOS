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
    var springDamping: CGFloat {
        return 0.8
    }
    
    var transitionDuration: Double {
        return 0.5
    }
    
    var transitionAnimationOptions: UIView.AnimationOptions {
        return [.curveEaseInOut, .allowUserInteraction, .beginFromCurrentState]
    }
    
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
        $0.addTarget(self, action: #selector(onClickJoin(_:)), for: .touchUpInside)
        return $0
    }(PlainButton())
    
    public var completion: ((Bool) -> Void)?
    
    private let viewModel: JoinGroupViewModel
    
    public init(viewModel: JoinGroupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showUpJoinGroupView(completion: nil)
    }
    
    override func bindViewModel() {
        
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .clear
        backgroundView.backgroundColor = .primaryBlack040
        backgroundView.alpha = 0
        
        [backgroundView, contentView].forEach {
            view.addSubview($0)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        backgroundView.addGestureRecognizer(tapGesture)
        
        [joinButton, titleSectionLabel].forEach {
            contentView.addSubview($0)
        }
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if let keyWindow = UIApplication.shared.windows.first {
            contentView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalToSuperview().offset(400 + keyWindow.safeAreaInsets.bottom)
                make.height.equalTo(400 + keyWindow.safeAreaInsets.bottom)
            }
        }
        
        titleSectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33)
            make.leading.equalToSuperview().offset(26)
        }
        
        joinButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(334)
        }
    }
    
    @objc
    private func handleTap(sender: UITapGestureRecognizer) {
        hideDownJoinGroupView(completion: { _ in
            self.completion?(false)
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    @objc
    private func onClickJoin(_ sender: UIButton) {
        hideDownJoinGroupView(completion: { _ in
            self.completion?(true) // TEMP
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    private func showUpJoinGroupView(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.backgroundView.alpha = 1
            if let keyWindow = UIApplication.shared.windows.first {
                self.contentView.frame.origin.y = keyWindow.frame.height - 400 - keyWindow.safeAreaInsets.bottom
            }
        }, completion: completion)
    }
    
    private func hideDownJoinGroupView(completion: ((Bool) -> Void)?) {
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.backgroundView.alpha = 0
            if let keyWindow = UIApplication.shared.windows.first {
                self.contentView.frame.origin.y = keyWindow.frame.height
            }
        }, completion: { result in
            completion?(result)
        })
    }
}
