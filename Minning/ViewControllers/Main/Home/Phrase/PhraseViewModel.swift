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
    var phraseContent: DataBinding<String> = DataBinding("새로운 일을 시작하는 용기속에 당신의 천재성, 능력과 기적이 모두 숨어 있다.")
    
    let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func updateValidation(content: String) {
        isContentValid.accept(phraseContent.value == content)
    }
}
