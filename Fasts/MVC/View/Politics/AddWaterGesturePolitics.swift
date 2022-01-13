import Foundation
import UIKit



extension AddWaterViewController {
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
                self?.minusButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            })
            guard var dataText = Int(ml.text ?? "Error") else { return }
            if dataText > 0 {
                dataText -= 50
            }
            ml.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.minusButton.layer.borderWidth = 0
                self?.minusButton.backgroundColor = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
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
                self?.plusButton.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            })
            guard var dataText = Int(ml.text ?? "Error") else { return }
            dataText += 50
            ml.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.plusButton.layer.borderWidth = 0
                self?.plusButton.backgroundColor = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
            })
        }
    }
    func setAddButtonGesturePolitics() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(addWater))
        gesture.minimumPressDuration = 0
        addWaterButton.addGestureRecognizer(gesture)
    }
    
    @objc private func addWater(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                let color = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
                self?.addWaterButton.setTitleColor(color, for: .normal)
            })
            completion?(ml.text)
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                let color = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
                self?.addWaterButton.setTitleColor(color, for: .normal)
            })
            dismiss(animated: false, completion: nil)
        }
    }
}

