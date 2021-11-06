//
//  ReviewViewController.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class ReviewViewController: BaseViewController {
    private let navigationBar: PlainUINavigationBar = PlainUINavigationBar()
    private let viewModel: ReviewViewModel
    
    private let titleLabel: UILabel = {
        $0.text = ""
        $0.font = .font14PBold
        $0.textColor = .primaryTextGray
        return $0
    }(UILabel())
    
    lazy var feedbackTextView: UITextView = {
        $0.delegate = self
        $0.textColor = .grayB5B8BE
        $0.text = viewModel.feedbackPlaceholder
        $0.font = .font16P
        $0.isScrollEnabled = false
        $0.textContainer.lineFragmentPadding = 0
        return $0
    }(UITextView())
    
    private let photoSelectButton: PhotoSelectButton = {
        $0.addTarget(self, action: #selector(onClickSelectPhotoFromLibrary(_:)), for: .touchUpInside)
        return $0
    }(PhotoSelectButton())
    
    private let selectedPhotoImageView: UIImageView = {
        $0.backgroundColor = .minningLightGray100
        $0.layer.cornerRadius = 7
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        $0.isHidden = true
        return $0
    }(UIImageView())
    
    private let dismissPhotoButton: UIButton = {
        $0.backgroundColor = .primaryBlack080
        $0.layer.cornerRadius = 14
        $0.setImage(UIImage(sharedNamed: "close_white"), for: .normal)
        $0.addTarget(self, action: #selector(onClickDismissPhotoButton(_:)), for: .touchUpInside)
        return $0
    }(UIButton())
    
    init(viewModel: ReviewViewModel) {
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
    
    override func bindViewModel() {
        viewModel.routimeItem.bindAndFire { [weak self] routine in
            guard let `self` = self else { return }
            self.titleLabel.text = routine?.title
        }
    }
    
    private func setupNavigationBar() {
        navigationBar.titleContent = "돌아보기"
        navigationBar.removeDefaultShadowImage()
        
        let navigationItem = UINavigationItem()
        let textBarButton = MUIBarButtonItem(title: "작성", style: .plain, target: self, action: #selector(onClickPostButton(_:)))
        textBarButton.textFont = .font16PBold
        
        navigationItem.setLeftPlainBarButtonItem(UIBarButtonItem(image: UIImage(sharedNamed: "close"), style: .plain, target: self, action: #selector(onClickCloseButton(_:))))
        navigationItem.setRightPlainBarButtonItem(textBarButton, animated: false)
        navigationBar.setItems([navigationItem], animated: false)
    }
    
    override func setupViewLayout() {
        [navigationBar, titleLabel, feedbackTextView, photoSelectButton, selectedPhotoImageView].forEach {
            view.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        photoSelectButton.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(12)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(photoSelectButton.snp.width)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(photoSelectButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        feedbackTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.greaterThanOrEqualTo(35.5)
        }
        
        selectedPhotoImageView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(12)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(photoSelectButton.snp.width)
        }
        
        selectedPhotoImageView.addSubview(dismissPhotoButton)
        
        dismissPhotoButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.trailing.equalTo(-20)
            make.width.height.equalTo(28)
        }
    }
    
    private func showSelectedPhotoImageView() {
        selectedPhotoImageView.isHidden = false
        photoSelectButton.isHidden = true
    }
    
    private func hideSelectedPhotoImageView() {
        selectedPhotoImageView.isHidden = true
        photoSelectButton.isHidden = false
    }
    
    @objc
    private func onClickCloseButton(_ sender: Any?) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func onClickPostButton(_ sender: Any?) {
        DebugLog("Did Click Post Button")
    }
    
    @objc
    private func onClickSelectPhotoFromLibrary(_ sender: Any?) {
        DebugLog("Did Click Select Photo Button")
        showSelectedPhotoImageView()
    }
    
    @objc
    private func onClickDismissPhotoButton(_ sender: Any?) {
        DebugLog("Did Click Dismiss Photo Button")
        hideSelectedPhotoImageView()
    }
}

extension ReviewViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.feedbackContent.accept(textView.text)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == viewModel.feedbackPlaceholder {
            textView.text = nil
            textView.textColor = .minningBlue100
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = viewModel.feedbackPlaceholder
            textView.textColor = .minningGray100
        }
    }
}
