import Foundation
import UIKit



extension EditGoalsViewController {
    func setMinusButtonGesturePolitics() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(minusTap))
        gesture.minimumPressDuration = 0
        minusButton.addGestureRecognizer(gesture)
    }
    @objc private func minusTap(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.minusButton.layer.borderWidth = 5
                self?.minusButton.backgroundColor = #colorLiteral(red: 0.6274509804, green: 0.5450980392, blue: 0.9333333333, alpha: 1)
            })
            guard var dataText = Int(ml.text ?? "Error") else { return }
            if dataText > 0 {
                dataText -= 1000
            }
            ml.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.minusButton.layer.borderWidth = 0
                self?.minusButton.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.1294117647, blue: 0.9098039216, alpha: 1)
            })
        }
    }
    func setPlusButtonGesturePolitics() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(plusTap))
        gesture.minimumPressDuration = 0
        plusButton.addGestureRecognizer(gesture)
    }
    @objc private func plusTap(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.plusButton.layer.borderWidth = 5
                self?.plusButton.backgroundColor = #colorLiteral(red: 0.6274509804, green: 0.5450980392, blue: 0.9333333333, alpha: 1)
            })
            guard var dataText = Int(ml.text ?? "Error") else { return }
            dataText += 1000
            ml.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.plusButton.layer.borderWidth = 0
                self?.plusButton.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.1294117647, blue: 0.9098039216, alpha: 1)
            })
        }
    }
    func setMinusButton1GesturePolitics() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(minusTap1))
        gesture.minimumPressDuration = 0
        minusButton1.addGestureRecognizer(gesture)
    }
    @objc private func minusTap1(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.minusButton1.layer.borderWidth = 5
                self?.minusButton1.backgroundColor = #colorLiteral(red: 0.6274509804, green: 0.5450980392, blue: 0.9333333333, alpha: 1)
            })
            guard var dataText = Int(steps.text ?? "Error") else { return }
            if dataText > 0 {
                dataText -= 1000
            }
            steps.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.minusButton1.layer.borderWidth = 0
                self?.minusButton1.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.1294117647, blue: 0.9098039216, alpha: 1)
            })
        }
    }
    func setPlusButton1GesturePolitics() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(plusTap1))
        gesture.minimumPressDuration = 0
        plusButton1.addGestureRecognizer(gesture)
    }
    @objc private func plusTap1(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.plusButton1.layer.borderWidth = 5
                self?.plusButton1.backgroundColor = #colorLiteral(red: 0.6274509804, green: 0.5450980392, blue: 0.9333333333, alpha: 1)
            })
            guard var dataText = Int(steps.text ?? "Error") else { return }
            dataText += 1000
            steps.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.plusButton1.layer.borderWidth = 0
                self?.plusButton1.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.1294117647, blue: 0.9098039216, alpha: 1)
            })
        }
    }
    func setAddButtonGesturePolitics() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(addWater))
        gesture.minimumPressDuration = 0
        setNewGoalsButton.addGestureRecognizer(gesture)
    }
    
    @objc private func addWater(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                let color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                self?.setNewGoalsButton.setTitleColor(color, for: .normal)
            })
            guard
                let ml = ml.text else { return }
            guard
                let steps = steps.text else { return }
            completion?((ml, steps))
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                let color = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
                self?.setNewGoalsButton.setTitleColor(color, for: .normal)
            })
            dismiss(animated: false, completion: nil)
        }
    }
}

