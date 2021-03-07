//
//  GraphView.swift
//  Mobdev
//
//  Created by Denis on 07.03.2021.
//

import UIKit

class GraphView: UIView {
    
    struct Unit {
        
        let value: Double
        let color: UIColor
    }
    
    var units = [Unit(value: 0.1, color: .yellow),
                 Unit(value: 0.2, color: .green),
                 Unit(value: 0.25, color: .blue),
                 Unit(value: 0.05, color: .red),
                 Unit(value: 0.4, color: .systemBlue)]
    
    // MARK: - Drawing
    
    override func draw(_ rect: CGRect) {
        
        var lastAngle: CGFloat = 0
        
        units.forEach { unit in
            
            let path = UIBezierPath()
            let endAngle: CGFloat = lastAngle + CGFloat(unit.value * 2 * Double.pi)
            let radius = frame.width / 3
            
            path.addArc(withCenter: CGPoint(x: frame.width / 2,
                                            y: frame.height / 2),
                        radius: radius,
                        startAngle: lastAngle,
                        endAngle: endAngle,
                        clockwise: true)
            
            path.lineWidth = radius / 3
            unit.color.setStroke()
            path.stroke()
            
            lastAngle = endAngle
        }
    }
}
