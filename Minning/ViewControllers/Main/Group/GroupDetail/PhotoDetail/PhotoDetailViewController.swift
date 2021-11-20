//
//  PhotoDetailViewController.swift
//  Minning
//
//  Created by 고세림 on 2021/11/20.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets
import SnapKit

final class PhotoDetailViewController: BaseViewController {
    
    private let navigationBar: PlainUINavigationBar = PlainUINavigationBar()
    private let mainImageView: UIImageView = {
        $0.backgroundColor = .minningGray100
        return $0
    }(UIImageView())
    
    private let bottomView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView())
    
    private let countLabel: UILabel = {
        $0.font = .font16P
        $0.textColor = .primaryWhite
        $0.text = "1/20"
        return $0
    }(UILabel())
    
    private let backButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "arrow_left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .minningGray100
        return $0
    }(UIButton())
    
    private let nextButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "arrow_right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .minningGray100
        return $0
    }(UIButton())
    
    private let viewModel: PhotoDetailViewModel
    
    public init(viewModel: PhotoDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationBar.removeDefaultShadowImage()
        navigationBar.setDarkPlainNavigationStyle()
        
        let navigationItem = UINavigationItem()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "close"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.titleContent = "내 사진"
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryBlack
        
        [navigationBar, mainImageView, bottomView].forEach {
            view.addSubview($0)
        }
        [countLabel, backButton, nextButton].forEach {
            bottomView.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(mainImageView.snp.width)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel.snp.centerY)
            make.trailing.equalTo(countLabel.snp.leading).offset(-36)
            make.width.equalTo(8)
            make.height.equalTo(16)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel.snp.centerY)
            make.leading.equalTo(countLabel.snp.trailing).offset(36)
            make.width.equalTo(8)
            make.height.equalTo(16)
        }
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
}
