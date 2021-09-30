//
//  Constant.swift
//  DesignSystem
//
//  Created by denny on 2021/09/30.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public enum Constant {
    public enum Border {
        public static let thin: CGFloat = 1 / UIScreen.main.scale
        public static let normal: CGFloat = 1
        public static let thick: CGFloat = 8
    }
    
    public enum Rounding {
        public static let rad2: CGFloat = 2
        public static let rad4: CGFloat = 4
        public static let rad8: CGFloat = 8
        public static let rad10: CGFloat = 10
    }
    
    public enum Height {
        public static let textField: CGFloat = 50
        public static let textButton: CGFloat = 50
    }
}
