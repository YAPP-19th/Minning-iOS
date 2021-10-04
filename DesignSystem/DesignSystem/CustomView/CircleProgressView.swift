//
//  CircleProgressView.swift
//  DesignSystem
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import UIKit

public class CircleProgressView: UIView {
    private var bgLayer: CAShapeLayer = CAShapeLayer()
    private var progressLayer: CAShapeLayer = CAShapeLayer()

    public var lineWidth: CGFloat = 8 {
        didSet {
            progressLayer.lineWidth = lineWidth
            bgLayer.lineWidth = lineWidth
        }
    }
    
    public var lineCap: CAShapeLayerLineCap = .butt {
        didSet {
            bgLayer.lineCap = lineCap
            progressLayer.lineCap = lineCap
        }
    }
    
    public var pathBackgroundColor: UIColor = UIColor.primaryGray {
        didSet {
            bgLayer.strokeColor = pathBackgroundColor.cgColor
        }
    }
    
    public var viewBackgroundColor: UIColor = .clear {
        didSet {
            bgLayer.fillColor = viewBackgroundColor.cgColor
        }
    }
    
    public var progressColor: UIColor = UIColor.primaryGray {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.clear
        
        bgLayer.lineCap = lineCap
        bgLayer.strokeStart = 0
        bgLayer.strokeEnd = 0
        bgLayer.fillColor = viewBackgroundColor.cgColor
        bgLayer.lineWidth = lineWidth
        bgLayer.strokeColor = pathBackgroundColor.cgColor
        layer.addSublayer(bgLayer)
        
        progressLayer.fillColor = nil
        progressLayer.lineCap = lineCap
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        progressLayer.lineWidth = lineWidth
        progressLayer.strokeColor = progressColor.cgColor
        layer.addSublayer(progressLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        let center = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0)
        let radius: CGFloat = min(bounds.size.width, bounds.size.height) / 2.0 - progressLayer.lineWidth / 2.0
        let startAngle: CGFloat = -.pi / 2
        let endAngle: CGFloat = startAngle + 2 * .pi
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        progressLayer.path = path.cgPath
        progressLayer.frame = bounds
        
        bgLayer.path = path.cgPath
        bgLayer.frame = bounds
        bgLayer.strokeEnd = 1.0
    }
    
    public func setProgress(_ progress: CGFloat) {
        progressLayer.strokeEnd = progress
    }
    
    public func setProgressWithPercentage(_ percentage: Int) {
        setProgress(CGFloat(percentage) * 0.01)
    }
    
    public func animateProgressView(duration: TimeInterval, progress: CGFloat) {
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation.duration = duration

        animation.fromValue = 0
        animation.toValue = progress

        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        progressLayer.strokeEnd = progress
        // Do the actual animation
        progressLayer.add(animation, forKey: "animateProgressView")
    }
}
