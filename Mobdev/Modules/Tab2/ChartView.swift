//
//  ChartView.swift
//  Mobdev
//
//  Created by Denis on 07.03.2021.
//

import UIKit

class ChartView: UIView {
    
    let startPoint: Double = -4.0
    let endPoint: Double = 4.0
    let offset: Double = 20
    let arrowWidth: Double = 6
    let arrowHeight: Double = 10
    
    var width: Double {
        return Double(frame.width)
    }
    
    var height: Double {
        return Double(frame.height)
    }
    
    var equivalentUnit: Double {
        return (width / 2 - offset - 10) / (4)
    }
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawChart()
        drawLines()
    }
    
    private func drawChart() {
        
        let chartPath = UIBezierPath()
        
        // Stroke
        chartPath.lineWidth = 2.5
        UIColor.orange.setStroke()
        
        chartPath.move(to: getYPoint(for: 0.01))
        
        for pointX in stride(from: 0.01, through: endPoint + 0.01, by: 0.01) {
            chartPath.addLine(to: getYPoint(for: pointX))
            print(getYPoint(for: pointX))
        }
        chartPath.stroke()
    }
    
    private func drawLines() {
        
        let line = UIBezierPath()
        line.lineWidth = 1.0
        UIColor.blue.setStroke()
        
        let xEndPoint = CGPoint(x: width - offset, y: height / 2)
        let yEndPoint = CGPoint(x: width / 2, y: 0)
        
        line.move(to: CGPoint(x: 16, y: height / 2))
        line.addLine(to: xEndPoint)
        
        line.move(to: CGPoint(x: width / 2, y: height))
        line.addLine(to: yEndPoint)
        
        line.move(to: CGPoint(x: width - offset - arrowHeight, y: height / 2 - arrowWidth))
        line.addLine(to: xEndPoint)
        line.move(to: CGPoint(x: width - offset - arrowHeight, y: height / 2 + arrowWidth))
        line.addLine(to: xEndPoint)
        
        line.move(to: CGPoint(x: width / 2 - arrowWidth, y: arrowHeight))
        line.addLine(to: yEndPoint)
        line.move(to: CGPoint(x: width / 2 + arrowWidth, y: arrowHeight))
        line.addLine(to: yEndPoint)
        
        line.stroke()
    }
    
    private func getYPoint(for x: Double) -> CGPoint {
        
        return CGPoint(x: x * equivalentUnit + (width / 2),
                       y: -(log10(x) * equivalentUnit - height / 2))
    }
}
