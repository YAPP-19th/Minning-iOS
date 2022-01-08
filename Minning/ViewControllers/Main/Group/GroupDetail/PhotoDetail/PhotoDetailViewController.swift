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
    
    private lazy var imageScrollView: UIScrollView = {
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.contentSize = .init(width: view.frame.width * CGFloat(viewModel.photoUrls.count), height: view.frame.width)
        $0.backgroundColor = .clear
        $0.delegate = self
        return $0
    }(UIScrollView())

    private let bottomView: UIView = {
        $0.backgroundColor = .clear
        return $0
    }(UIView()) 
    
    private lazy var countLabel: UILabel = {
        $0.textAlignment = .center
        $0.font = .font16P
        $0.textColor = .primaryWhite
        $0.text = "\(viewModel.selectedPhotoIndex.value + 1)/\(viewModel.photoUrls.count)"
        return $0
    }(UILabel())
    
    private lazy var backButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "arrow_left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = viewModel.selectedPhotoIndex.value == 0 ? .minningDarkGray100 : .primaryWhite
        $0.isEnabled = viewModel.selectedPhotoIndex.value != 0
        $0.addTarget(self, action: #selector(onClickBackButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    private lazy var nextButton: UIButton = {
        $0.setImage(UIImage(sharedNamed: "arrow_right")?.withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = viewModel.selectedPhotoIndex.value == viewModel.photoUrls.count - 1 ? .minningDarkGray100 : .primaryWhite
        $0.isEnabled = viewModel.selectedPhotoIndex.value != viewModel.photoUrls.count - 1
        $0.addTarget(self, action: #selector(onClickNextButton(_:)), for: .touchUpInside)
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
        setImagesAtScrollView()
    }
    
    override func bindViewModel() {
        viewModel.selectedPhotoIndex.bindAndFire { [weak self] _ in
            guard let `self` = self else { return }
            self.updateBottomView()
        }
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onClickBackButton(_ sender: Any?) {
        viewModel.decreasePhotoIndex()
        UIView.animate(withDuration: 0.3) {
            self.imageScrollView.contentOffset.x = self.view.frame.width * CGFloat(self.viewModel.selectedPhotoIndex.value)
        }
        backButton.isEnabled = viewModel.selectedPhotoIndex.value != 0
    }
    
    @objc
    private func onClickNextButton(_ sender: Any?) {
        viewModel.increasePhotoIndex()
        UIView.animate(withDuration: 0.3) {
            self.imageScrollView.contentOffset.x = self.view.frame.width * CGFloat(self.viewModel.selectedPhotoIndex.value)
        }
        nextButton.isEnabled = viewModel.selectedPhotoIndex.value != viewModel.photoUrls.count - 1
    }

    private func updateBottomView() {
        countLabel.text = "\(viewModel.selectedPhotoIndex.value + 1)/\(viewModel.photoUrls.count)"
        backButton.imageView?.tintColor = viewModel.selectedPhotoIndex.value == 0 ? .minningDarkGray100 : .primaryWhite
        nextButton.imageView?.tintColor = viewModel.selectedPhotoIndex.value == viewModel.photoUrls.count - 1 ? .minningDarkGray100 : .primaryWhite
    }
    
    private func setupNavigationBar() {
        navigationBar.removeDefaultShadowImage()
        navigationBar.setDarkPlainNavigationStyle()
        
        let navigationItem = UINavigationItem()
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "backArrow"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationBar.setItems([navigationItem], animated: false)
        navigationBar.titleContent = "내 사진"
    }
    
    override func setupViewLayout() {
        view.backgroundColor = .primaryBlack
        
        [navigationBar, imageScrollView, bottomView].forEach {
            view.addSubview($0)
        }
        [countLabel, backButton, nextButton].forEach {
            bottomView.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        imageScrollView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(view.frame.width)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(imageScrollView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints { make in
            make.width.equalTo(65)
            make.center.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel.snp.centerY)
            make.trailing.equalTo(countLabel.snp.leading)
            make.width.height.equalTo(44)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(countLabel.snp.centerY)
            make.leading.equalTo(countLabel.snp.trailing)
            make.width.height.equalTo(44)
        }
    }
    
    private func setImagesAtScrollView() {
        // 이미지 대신 백그라운드 컬러로 스와이프 기능 테스트 -> 추후 이미지 삽입 필요
        viewModel.photoUrls.enumerated().forEach { index, _ in
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.1 * CGFloat(index))
            let xPosition = view.frame.width * CGFloat(index)
            imageView.frame = .init(x: xPosition, y: imageScrollView.frame.minY, width: view.frame.width, height: view.frame.width)
            imageScrollView.addSubview(imageView)
        }
        imageScrollView.contentOffset.x = view.frame.width * CGFloat(viewModel.selectedPhotoIndex.value)
    }
    
}

extension PhotoDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollViewContentWidth = scrollView.contentSize.width
        let xPositon = scrollView.contentOffset.x
        let index = Int(xPositon / scrollViewContentWidth * CGFloat(viewModel.photoUrls.count))
        viewModel.selectedPhotoIndex.accept(index)
    }
}
