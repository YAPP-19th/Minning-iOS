//
//  ReviewViewModel.swift
//  Minning
//
//  Created by denny on 2021/10/02.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation
import UIKit

final class ReviewViewModel {
    var retrospect: DataBinding<RetrospectModel?> = DataBinding(nil)
    var feedbackContent: DataBinding<String> = DataBinding("")
    
    let feedbackPlaceholder: String = "피드백을 적어주세요!"
    let coordinator: HomeCoordinator
    
    init(coordinator: HomeCoordinator, retrospect: RetrospectModel) {
        self.coordinator = coordinator
        self.retrospect.accept(retrospect)
    }
    
    func postRetrospect(content: String, image: UIImage?, completion: @escaping () -> Void) {
        guard let retrospect = retrospect.value else { return }
        let request = RetrospectRequest(content: content, date: retrospect.date, image: image, routineId: retrospect.routine.id)
        RetrospectAPIRequest.addRetrospect(request: request) { result in
            switch result {
            case .success(_):
                completion()
            case .failure(let error):
                ErrorLog(error.localizedDescription)
            }
        }
    }
}
