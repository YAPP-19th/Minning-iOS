//
//  LineChart.swift
//  DesignSystem
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import CommonSystem
import Foundation
import UIKit

public struct PointEntry {
    public let value: Int
    public let label: String
    
    public init(value: Int, label: String) {
        self.value = value
        self.label = label
    }
}

extension PointEntry: Comparable {
    public static func <(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value < rhs.value
    }
    
    public static func ==(lhs: PointEntry, rhs: PointEntry) -> Bool {
        return lhs.value == rhs.value
    }
}

public class LineChart: UIView {
    public let entireLineGap: CGFloat = (UIScreen.main.bounds.width - 75.0)
//    public let lineGap: CGFloat = (UIScreen.main.bounds.width - 75.0) / 4
    
    public let topSpace: CGFloat = 28.0
    public let bottomSpace: CGFloat = 34.0
    
    public let topHorizontalLine: CGFloat = 110.0 / 100.0
    
    public var isCurved: Bool = false

    public var animateDots: Bool = false

    public var showDots: Bool = false

    public var innerRadius: CGFloat = 8

    public var outerRadius: CGFloat = 12
    
    public var dataEntries: [PointEntry]? {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    private let dataLayer: CALayer = CALayer()
    
    private let mainLayer: CALayer = CALayer()
    private let scrollView: UIScrollView = UIScrollView()
    
    private let gridLayer: CALayer = CALayer()
    private var dataPoints: [CGPoint]?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        mainLayer.addSublayer(dataLayer)
        scrollView.layer.addSublayer(mainLayer)
        self.layer.addSublayer(gridLayer)
        self.addSubview(scrollView)
        self.backgroundColor = .primaryWhite
    }
    
    public override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        if let dataEntries = dataEntries {
            let lineGap = entireLineGap / CGFloat(dataEntries.count - 1)
            scrollView.contentSize = CGSize(width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
            mainLayer.frame = CGRect(x: 0, y: 0, width: CGFloat(dataEntries.count) * lineGap, height: self.frame.size.height)
            dataLayer.frame = CGRect(x: 0, y: topSpace, width: mainLayer.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
            dataPoints = convertDataEntriesToPoints(entries: dataEntries)
            gridLayer.frame = CGRect(x: 0, y: topSpace, width: self.frame.width, height: mainLayer.frame.height - topSpace - bottomSpace)
            if showDots { drawDots() }
            clean()
            drawVerticalLines()
            drawHorizontalLines()
            if isCurved {
                drawCurvedChart()
            } else {
                drawChart()
            }
            drawLables()
        }
    }
    
    private func convertDataEntriesToPoints(entries: [PointEntry]) -> [CGPoint] {
        var result: [CGPoint] = []
        let lineGap = entireLineGap / CGFloat(entries.count - 1)
        for idx in 0..<entries.count {
            let height = dataLayer.frame.height * (1 - (CGFloat(entries[idx].value) / 100))
            let point = CGPoint(x: CGFloat(idx) * lineGap + 53, y: height)
            result.append(point)
        }
        return result
    }
    
    private func drawChart() {
        if let dataPoints = dataPoints,
            dataPoints.count > 0,
            let path = createPath() {
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.strokeColor = UIColor.white.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }

    private func createPath() -> UIBezierPath? {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return nil
        }
        let path = UIBezierPath()
        path.move(to: dataPoints[0])
        
        for idx in 1..<dataPoints.count {
            path.addLine(to: dataPoints[idx])
        }
        return path
    }
    
    private func drawCurvedChart() {
        guard let dataPoints = dataPoints, dataPoints.count > 0 else {
            return
        }
        if let path = CurveAlgorithm.shared.createCurvedPath(dataPoints) {
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.lineWidth = 2
            lineLayer.strokeColor = UIColor.primaryBlue.cgColor
            lineLayer.fillColor = UIColor.clear.cgColor
            dataLayer.addSublayer(lineLayer)
        }
    }
    
    private func drawLables() {
        if let dataEntries = dataEntries,
            dataEntries.count > 0 {
            let lineGap = entireLineGap / CGFloat(dataEntries.count - 1)
            for idx in 0..<dataEntries.count {
                let textLayer = CATextLayer()
                textLayer.frame = CGRect(x: lineGap * CGFloat(idx) + 53 - (lineGap / 2), y: mainLayer.frame.size.height - bottomSpace / 2 - 8, width: lineGap, height: 16)
                textLayer.foregroundColor = UIColor.primaryBlack.cgColor
                textLayer.backgroundColor = UIColor.clear.cgColor
                textLayer.alignmentMode = CATextLayerAlignmentMode.center
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
                textLayer.fontSize = 11
                textLayer.alignmentMode = .center
                textLayer.string = dataEntries[idx].label
                mainLayer.addSublayer(textLayer)
            }
        }
    }
    
    private func drawVerticalLines() {
        guard let dataPoints = dataPoints else {
            return
        }
        
        let lineGap = entireLineGap / CGFloat(dataPoints.count - 1)
        
        for (index, _) in dataPoints.enumerated() {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 53 + (lineGap * CGFloat(index)), y: 0))
            path.addLine(to: CGPoint(x: 53 + (lineGap * CGFloat(index)), y: gridLayer.frame.size.height))
            
            let lineLayer = CAShapeLayer()
            lineLayer.path = path.cgPath
            lineLayer.fillColor = UIColor.clear.cgColor
            lineLayer.strokeColor = UIColor.primaryGray.cgColor
            lineLayer.lineDashPattern = [2, 2]
            lineLayer.lineWidth = 0.5
            
            gridLayer.addSublayer(lineLayer)
        }
    }
    
    private func drawHorizontalLines() {
        let gridValues: [CGFloat] = [0, 0.2, 0.4, 0.6, 0.8, 1]
        
        for value in gridValues {
            let height = value * gridLayer.frame.size.height
            
            let textLayer = CATextLayer()
            textLayer.frame = CGRect(x: 16, y: height - 8, width: 50, height: 16)
            textLayer.foregroundColor = UIColor.primaryGray.cgColor
            textLayer.backgroundColor = UIColor.clear.cgColor
            textLayer.contentsScale = UIScreen.main.scale
            textLayer.font = CTFontCreateWithName(UIFont.systemFont(ofSize: 0).fontName as CFString, 0, nil)
            textLayer.fontSize = 12
            textLayer.string = "\(Int(100 - (value * 100)))"
            
            gridLayer.addSublayer(textLayer)
        }
    }
    
    private func clean() {
        mainLayer.sublayers?.forEach({
            if $0 is CATextLayer {
                $0.removeFromSuperlayer()
            }
        })
        dataLayer.sublayers?.forEach({ $0.removeFromSuperlayer() })
        gridLayer.sublayers?.forEach({ $0.removeFromSuperlayer() })
    }
    
    private func drawDots() {
        var dotLayers: [DotCALayer] = []
        if let dataPoints = dataPoints {
//            let lineGap = entireLineGap / CGFloat(dataPoints.count - 1)
            
            for dataPoint in dataPoints {
                let xValue = dataPoint.x - outerRadius / 2
                let yValue = (dataPoint.y + 75) - (outerRadius * 2) - 29
                let dotLayer = DotCALayer()
                dotLayer.dotInnerColor = UIColor.primaryBlue
                dotLayer.innerRadius = innerRadius
                dotLayer.backgroundColor = UIColor.primaryBlue030.cgColor
                dotLayer.cornerRadius = outerRadius / 2
                dotLayer.frame = CGRect(x: xValue, y: yValue, width: outerRadius, height: outerRadius)
                dotLayers.append(dotLayer)

                mainLayer.addSublayer(dotLayer)

                if animateDots {
                    let anim = CABasicAnimation(keyPath: "opacity")
                    anim.duration = 1.0
                    anim.fromValue = 0
                    anim.toValue = 1
                    dotLayer.add(anim, forKey: "opacity")
                }
            }
        }
    }
}
