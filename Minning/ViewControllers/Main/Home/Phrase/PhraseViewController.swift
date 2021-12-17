//
//  PhraseViewController.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import Foundation
import SharedAssets
import SnapKit

final class PhraseViewController: BaseViewController {
    private let deleteButton: ImageButton = {
        $0.setImage(UIImage(sharedNamed: "close"), for: .normal)
        $0.addTarget(self, action: #selector(onClickCloseButton(_:)), for: .touchUpInside)
        return $0
    }(ImageButton())
    
    private let postButton: TopTextButton = {
        $0.setTitle("저장", for: .normal)
        $0.addTarget(self, action: #selector(onClickSaveButton(_:)), for: .touchUpInside)
        return $0
    }(TopTextButton())
    
    private let titleSectionLabel: UILabel = {
        $0.text = "오늘의 명언"
        $0.font = .font12PBold
        $0.textColor = .primaryTextGray
        return $0
    }(UILabel())
    
    private let phraseLabel: UILabel = {
        $0.font = .font16PBold
        $0.textColor = .primaryBlack
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    private let separatorView: UIView = {
        $0.backgroundColor = .grayEEF1F5
        return $0
    }(UIView())
    
    private let textFieldSectionLabel: UILabel = {
        $0.text = "명언을 따라 써볼까요?"
        $0.font = .font12PBold
        $0.textColor = .primaryTextGray
        return $0
    }(UILabel())
    
    private let phraseTextView: UITextView = {
        $0.textColor = .primaryTextGray
        $0.font = .font16P
        return $0
    }(UITextView())
    
    private let viewModel: PhraseViewModel
    
    init(viewModel: PhraseViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func onClickSaveButton(_ sender: TopTextButton) {
        viewModel.checkPhraseValidation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTodayPhrase()
    }
    
    override func setupViewLayout() {
        phraseTextView.delegate = self
        
        [deleteButton, postButton,
         titleSectionLabel, textFieldSectionLabel,
         phraseLabel, separatorView, phraseTextView].forEach {
            view.addSubview($0)
        }
        
        deleteButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalToSuperview().offset(4)
            make.width.height.equalTo(44)
        }
        
        postButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(26)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        titleSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(deleteButton.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        phraseLabel.snp.makeConstraints { make in
            make.top.equalTo(titleSectionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(phraseLabel.snp.bottom).offset(20)
            make.height.equalTo(2)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        textFieldSectionLabel.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        phraseTextView.snp.makeConstraints { make in
            make.top.equalTo(textFieldSectionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(100)
        }
    }
    
    override func bindViewModel() {
        viewModel.isContentValid.bindAndFire { [weak self] isValid in
            guard let `self` = self else { return }
            self.postButton.isEnabled = isValid
        }
        
        viewModel.phraseContent.bindAndFire { [weak self] content in
            guard let `self` = self else { return }
            self.phraseLabel.setText(text: content, lineHeight: 24)
            self.phraseTextView.text = content
            self.phraseTextView.textColor = .minningGray100
        }
    }
    
    @objc
    private func onClickCloseButton(_ sender: ImageButton) {
        if viewModel.userInputContent.value.count > 0 {
            showAlert(title: "삭제 타이틀", message: "화면을 벗어나면 작성중인 글이 전부 삭제됩니다. 그래도 나가시겠습니까?", handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension PhraseViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == viewModel.phraseContent.value {
            textView.text = nil
            textView.textColor = .minningBlue100
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.setUserContent(content: textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = viewModel.phraseContent.value
            textView.textColor = .minningGray100
        }
    }
}
