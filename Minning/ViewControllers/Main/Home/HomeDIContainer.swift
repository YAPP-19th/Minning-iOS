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
    
    func createAdd(_ coordinator: HomeCoordinator) -> AddViewController {
        let viewModel = AddViewModel(coordinator: coordinator)
        let addVC = AddViewController(viewModel: viewModel)
        return addVC
    }
    
    func createReview(_ coordinator: HomeCoordinator) -> ReviewViewController {
        let viewModel = ReviewViewModel(coordinator: coordinator)
        let addVC = ReviewViewController(viewModel: viewModel)
        return addVC
    }
    
    func createEditOrder(_ coordinator: HomeCoordinator) -> EditOrderViewController {
        let viewModel = EditOrderViewModel(coordinator: coordinator)
        let editOrderVC = EditOrderViewController(viewModel: viewModel)
        return editOrderVC
    }
    
    func createRecommend(_ coordinator: HomeCoordinator) -> RecommendViewController {
        let viewModel = RecommendViewModel(coordinator: coordinator)
        let recommendVC = RecommendViewController(viewModel: viewModel)
        return recommendVC
    }
}
