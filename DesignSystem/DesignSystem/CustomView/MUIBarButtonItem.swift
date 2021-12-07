//
//  MUIBarButtonItem.swift
//  DesignSystem
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import UIKit

public class MUIBarButtonItem: UIBarButtonItem {
    public var textFont: UIFont? {
        didSet {
            if let font = textFont {
                setTitleTextAttributes([
                    NSAttributedString.Key.font: font
                ], for: .normal)
            }
        }
    }
    
    init(text: String?, action: Selector?) {
//        super.init(title: text, style: .plain, target: target, action: action)
        super.init()
        self.title = text
        self.style = .plain
        self.action = action
        textFont = .font16PBold
    }
    
    private override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
