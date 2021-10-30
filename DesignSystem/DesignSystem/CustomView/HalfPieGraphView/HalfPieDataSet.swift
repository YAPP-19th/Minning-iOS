//
//  HalfPieDataSet.swift
//  DesignSystem
//
//  Created by denny on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

public struct PieChartData {
    public let value: CGFloat
    public let color: UIColor
    
    public init(value: CGFloat, color: UIColor) {
        self.value = value
        self.color = color
    }
}
