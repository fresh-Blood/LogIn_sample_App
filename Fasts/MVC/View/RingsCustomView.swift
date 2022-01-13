import UIKit

final class RingsCustomView: UIView {
    
    let yellowColor = #colorLiteral(red: 0.9580816627, green: 0.8498032093, blue: 0, alpha: 1)
    let blueColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9843137255, alpha: 1)
    let greenColor = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
    
    func calculateWaterProcentage() -> Double? {
        guard
            let goal = UserDefaults.standard.object(forKey: CodingKeys.waterValue.rawValue) as? String,
            let current = UserDefaults.standard.object(forKey: CodingKeys.water.rawValue) as? String,
            let goalNumber = Int(goal.chooseNumbersOnly() ?? "Error"),
            let currentNumber = Int(current) else { return nil }
        
        let value = goalNumber - currentNumber
        let result = (Double(value) * 0.5)/Double(goalNumber)
        var averageValue: Double = 0
        
        if result > 0 && result < 0.1 {
            averageValue = 0.15
        } else if result > 0.1 && result < 0.2 {
            averageValue = 0.20
        } else if result > 0.2 && result < 0.3 {
            averageValue = 0.25
        } else if result > 0.3 && result < 0.4 {
            averageValue = 0.30
        } else if result > 0.4 && result < 0.5 {
            averageValue = 0.35
        }
        return averageValue
    }
    func calculateStepsProcentage() -> Double? {
        guard
            let goal = UserDefaults.standard.object(forKey: CodingKeys.stepsValue.rawValue) as? String,
            let current = UserDefaults.standard.object(forKey: CodingKeys.steps.rawValue) as? String,
            let goalNumber = Int(goal.chooseNumbersOnly() ?? "Error"),
            let currentNumber = Int(current) else { return nil }
        
        let value = goalNumber - currentNumber
        let result = (Double(value) * 0.5)/Double(goalNumber)
        var averageValue: Double = 0
        
        if result > 0 && result < 0.1 {
            averageValue = 0.15
        } else if result > 0.1 && result < 0.2 {
            averageValue = 0.20
        } else if result > 0.2 && result < 0.3 {
            averageValue = 0.25
        } else if result > 0.3 && result < 0.4 {
            averageValue = 0.30
        } else if result > 0.4 && result < 0.5 {
            averageValue = 0.35
        }
        print(averageValue)
        return averageValue
    }
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        var lastArcAngle = -CGFloat.pi
        func addArc(color: UIColor, percentage: CGFloat, radius: CGFloat, lineWidth: CGFloat) {
            let fullCircle = CGFloat.pi * 4
            let arcAngle = fullCircle * percentage
            let path = UIBezierPath(arcCenter: CGPoint(x: self.bounds.minX,
                                                       y: self.bounds.height/2 - 20),
                                    radius: radius,
                                    startAngle: lastArcAngle,
                                    endAngle: lastArcAngle + arcAngle,
                                    clockwise: true)
            if lineWidth != 50 {
                let finishPointShapeLayer = CAShapeLayer()
                finishPointShapeLayer.strokeColor = color.cgColor
                finishPointShapeLayer.lineWidth = lineWidth
                finishPointShapeLayer.fillColor = UIColor.clear.cgColor
                finishPointShapeLayer.path = path.cgPath
                finishPointShapeLayer.lineCap = .round
                let finishPointAnimation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
                finishPointAnimation.fromValue = 0
                finishPointAnimation.duration = 2
                finishPointShapeLayer.add(finishPointAnimation, forKey: "animation")
                self.layer.addSublayer(finishPointShapeLayer)
            } else {
                color.setStroke()
                path.lineWidth = lineWidth
                path.stroke()
                lastArcAngle += arcAngle
            }
        }
        
        addArc(color: yellowColor, percentage: calculateStepsProcentage() ?? 0.15, radius: 80, lineWidth: 35)
        addArc(color: blueColor, percentage: calculateWaterProcentage() ?? 0.25, radius: 135, lineWidth: 35)
        addArc(color: greenColor, percentage: 0.3, radius: 190, lineWidth: 35)
        
        addArc(color: yellowColor.withAlphaComponent(0.5), percentage: 3.0 / 6.0, radius: 80, lineWidth: 50)
        addArc(color: blueColor.withAlphaComponent(0.5), percentage: 3.0 / 6.0, radius: 135, lineWidth: 50)
        addArc(color: greenColor.withAlphaComponent(0.5), percentage: 3.0 / 6.0, radius: 190, lineWidth: 50)
        addArc(color: greenColor.withAlphaComponent(0.5), percentage: 3.0 / 6.0, radius: 240, lineWidth: 2)
    }
}
