//
//  HomeDIContainer.swift
//  Minning
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import DesignSystem
import Foundation

final class HomeDIContainer {
    func createPhrase(_ coordinator: HomeCoordinator) -> PhraseViewController {
        let viewModel = PhraseViewModel(coordinator: coordinator)
        let phraseVC = PhraseViewController(viewModel: viewModel)
        return phraseVC
    }
}
