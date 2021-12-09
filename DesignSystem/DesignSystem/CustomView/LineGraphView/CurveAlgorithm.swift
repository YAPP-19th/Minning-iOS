//
//  CurveAlgorithm.swift
//  DesignSystem
//
//  Created by denny on 2021/10/03.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation
import UIKit

struct CurvedSegment {
    var controlPoint1: CGPoint
    var controlPoint2: CGPoint
}

class CurveAlgorithm {
    static let shared = CurveAlgorithm()
    
    private func controlPointsFrom(points: [CGPoint]) -> [CurvedSegment] {
        var result: [CurvedSegment] = []
        
        let delta: CGFloat = 0.3
        for idx in 1..<points.count {
            let pointA = points[idx - 1]
            let pointB = points[idx]
            let controlPoint1 = CGPoint(x: pointA.x + delta * (pointB.x - pointA.x), y: pointA.y + delta * (pointB.y - pointA.y))
            let controlPoint2 = CGPoint(x: pointB.x - delta * (pointB.x - pointA.x), y: pointB.y - delta * (pointB.y - pointA.y))
            let curvedSegment = CurvedSegment(controlPoint1: controlPoint1, controlPoint2: controlPoint2)
            result.append(curvedSegment)
        }
        
        for idx in 1..<points.count - 1 {
            let pointM = result[idx - 1].controlPoint2
            
            let pointN = result[idx].controlPoint1
            
            let pointA = points[idx]
            
            let pointMM = CGPoint(x: 2 * pointA.x - pointM.x, y: 2 * pointA.y - pointM.y)
            
            let pointNN = CGPoint(x: 2 * pointA.x - pointN.x, y: 2 * pointA.y - pointN.y)
            
            result[idx].controlPoint1 = CGPoint(x: (pointMM.x + pointN.x) / 2, y: (pointMM.y + pointN.y) / 2)
            result[idx - 1].controlPoint2 = CGPoint(x: (pointNN.x + pointM.x) / 2, y: (pointNN.y + pointM.y) / 2)
        }
        
        return result
    }
    
    func createCurvedPath(_ dataPoints: [CGPoint]) -> UIBezierPath? {
        let path = UIBezierPath()
        path.move(to: dataPoints[0])
        
        var curveSegments: [CurvedSegment] = []
        curveSegments = controlPointsFrom(points: dataPoints)
        
        for idx in 1..<dataPoints.count {
            path.addCurve(to: dataPoints[idx], controlPoint1: curveSegments[idx - 1].controlPoint1, controlPoint2: curveSegments[idx - 1].controlPoint2)
        }
        return path
    }
}
