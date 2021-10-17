//
//  HalfPieChart.swift
//  DesignSystem
//
//  Created by denny on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import UIKit

class HalfPieChart : UIView {
    public var dataSet: [PieChartData] = [] {
        didSet {
            layoutIfNeeded()
        }
    }
    
    override func draw(_ rect: CGRect) {
        for (index, data) in dataSet.enumerated() {
            if index < 1 {
                drawSlice(rect, startPercent: 0, endPercent: data.value, color: dataSet[index].color)
            } else {
                drawSlice(rect, startPercent: dataSet[index - 1].value, endPercent: data.value, color: dataSet[index].color)
            }
        }
        
//        let maskLayer = CAShapeLayer()
//        let path = UIBezierPath()
//        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height)
//        let radius = min(rect.width, rect.height) - 20
//        path.move(to: center)
//        path.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 180, clockwise: true)
//        path.close()
//        let maskColor = UIColor.black
//        maskColor.setFill()
//        path.fill()
//        maskLayer.path = path.cgPath
//        layer.mask = maskLayer
    }

    private func drawSlice(_ rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height)
        let radius = min(rect.width, rect.height)
        let startAngle = startPercent / 100 * CGFloat.pi - CGFloat.pi
        let endAngle = endPercent / 100 * CGFloat.pi - CGFloat.pi
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        color.setFill()
        path.fill()
        
        let centerCirclePath = UIBezierPath()
        centerCirclePath.move(to: center)
        centerCirclePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 180, clockwise: true)
        centerCirclePath.close()
    }
}
