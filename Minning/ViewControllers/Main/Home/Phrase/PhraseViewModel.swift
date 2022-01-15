//
//  PhraseViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation

final class PhraseViewModel {
    var isContentValid: DataBinding<Bool> = DataBinding(false)
    var phraseContent: DataBinding<String> = DataBinding("")
    var userInputContent: DataBinding<String> = DataBinding("")
    
    private var sayingId: Int64?
    let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func updateValidation() {
        isContentValid.accept(phraseContent.value == userInputContent.value)
    }
    
    func setUserContent(content: String) {
        userInputContent.accept(content)
        updateValidation()
    }
    
    func getTodayPhrase() {
        SayingAPIRequest.getTodaySaying(completion: { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                self.sayingId = response.data.id
                self.phraseContent.accept(response.data.content)
            case .failure(let error):
                ErrorLog(error.defaultError.localizedDescription)
            }
        })
    }
    
    func checkPhraseValidation(completion: @escaping () -> Void) {
        SayingAPIRequest.compareSaying(content: userInputContent.value,
                                       sayingId: sayingId ?? 0,
                                       completion: { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let response):
                DebugLog("Result: \(response.data.result)")
                self.isContentValid.accept(response.data.result)
                completion()
            case .failure(let error):
                ErrorLog(error.defaultError.localizedDescription)
            }
        })
    }
}
