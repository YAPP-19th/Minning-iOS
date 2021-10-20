//
//  HalfPieChart.swift
//  DesignSystem
//
//  Created by denny on 2021/10/17.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem

public class HalfPieChart: UIView {
    private var pieLayers: [CALayer] = []
    
    public var dataSet: [PieChartData] = [] {
        didSet {
            layoutIfNeeded()
        }
    }
    
    public var pieTouchHandler: ((Int) -> Void)?
    
    public override func draw(_ rect: CGRect) {
        self.layer.sublayers?.forEach { subLayer in
            subLayer.removeFromSuperlayer()
        }
        pieLayers.removeAll()
        
        var prevValue: CGFloat = 0
        for (index, data) in dataSet.enumerated() {
            if index < 1 {
                DebugLog("Data : \(data.value)")
                prevValue = data.value
                drawSlice(rect, startPercent: 0, endPercent: data.value, color: dataSet[index].color)
            } else {
                let curValue = prevValue + data.value
                drawSlice(rect,
                          startPercent: prevValue, endPercent: curValue > 100 ? 100 : curValue,
                          color: dataSet[index].color)
                prevValue = curValue
            }
        }
        
        addMaskLayer(rect)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DebugLog("Touch Began")
        guard let touch = touches.first, let subLayers = layer.sublayers as? [CAShapeLayer] else { return }
        let point = touch.location(in: self)

        subLayers.enumerated().forEach { index, layer in
            if let path = layer.path, path.contains(point), index < dataSet.count {
                DebugLog("Index: \(index), Layer : \(layer)")
                pieTouchHandler?(index)
            }
        }
    }
    
    private func addMaskLayer(_ rect: CGRect) {
        let maskLayer: CAShapeLayer = CAShapeLayer()
        let radius = min(rect.width, rect.height) - 20
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height)
        let centerCirclePath = UIBezierPath()
        centerCirclePath.move(to: center)
        centerCirclePath.addArc(withCenter: center, radius: radius, startAngle: 0, endAngle: 180, clockwise: true)
        centerCirclePath.close()
        
        maskLayer.path = centerCirclePath.cgPath
        maskLayer.fillColor = UIColor.primaryWhite.cgColor
        layer.addSublayer(maskLayer)
    }

    private func drawSlice(_ rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
        let subLayer: CAShapeLayer = CAShapeLayer()
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height)
        let radius = min(rect.width, rect.height)
        let startAngle = startPercent / 100 * CGFloat.pi - CGFloat.pi
        let endAngle = endPercent / 100 * CGFloat.pi - CGFloat.pi
        
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        
        subLayer.path = path.cgPath
        subLayer.fillColor = color.cgColor
        
        pieLayers.append(subLayer)
        layer.addSublayer(subLayer)
    }
}
