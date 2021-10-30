//
//  RoutineCellSwipeView.swift
//  Minning
//
//  Created by 고세림 on 2021/10/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import DesignSystem
import SharedAssets

final class RoutineCellSwipeView: UIView {
    
    enum Action {
        case complete
        case half
        case dismiss
        
        var backgroundColor: UIColor {
            switch self {
            case .complete:
                return .minningBlue100
            case .half:
                return .minningBlue70
            case .dismiss:
                return .subAlert
                
            }
        }
        
        var image: UIImage? {
            switch self {
            case .complete:
                return UIImage(sharedNamed: "routine_swipe_complete")
            case .half:
                return UIImage(sharedNamed: "routine_swipe_half")
            case .dismiss:
                return UIImage(sharedNamed: "routine_swipe_dismiss")
            }
        }
        
        var title: String {
            switch self {
            case .complete:
                return "완료"
            case .half:
                return "부분완료"
            case .dismiss:
                return "취소"
            }
        }
    }

    private let imageView: UIImageView = {
        $0.frame = .init(x: 16, y: 6, width: 30, height: 30)
        return $0
    }(UIImageView())
    
    private let titleLabel: UILabel = {
        $0.frame = .init(x: 0, y: 37, width: 62, height: 14)
        $0.font = .font12PMedium
        $0.textColor = .primaryWhite
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let actionType: Action
    
    init(action: Action) {
        self.actionType = action
        super.init(frame: .init(x: 0, y: 0, width: 62, height: 62))
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.cornerRadius = 10
        backgroundColor = actionType.backgroundColor
        imageView.image = actionType.image
        titleLabel.text = actionType.title
        [imageView, titleLabel].forEach {
            addSubview($0)
        }
    }
    
}
