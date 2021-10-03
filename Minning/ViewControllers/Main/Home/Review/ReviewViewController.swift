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
        $0.font = .font12PBold
        $0.textColor = .primaryTextGray
        return $0
    }(UILabel())
    
    lazy var feedbackTextView: UITextView = {
        $0.delegate = self
        $0.textColor = .primaryTextGray
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
    
    init(viewModel: ReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewLayout()
        setupNavigationBar()
        bindViewModel()
    }
    
    private func bindViewModel() {
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
    
    private func setupViewLayout() {
        [navigationBar, titleLabel, feedbackTextView, photoSelectButton].forEach {
            view.addSubview($0)
        }
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(66)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        feedbackTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(35.5)
        }
        
        photoSelectButton.snp.makeConstraints { make in
            make.top.equalTo(feedbackTextView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(100)
        }
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
    }
}

extension ReviewViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        viewModel.feedbackContent.accept(textView.text)
        
        textView.snp.updateConstraints { make in
            make.height.equalTo(estimatedSize.height)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == viewModel.feedbackPlaceholder {
            textView.text = nil
            textView.textColor = .primaryBlue
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = viewModel.feedbackPlaceholder
            textView.textColor = .primaryGray
        }
    }
}
