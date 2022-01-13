import Foundation
import UIKit



extension AddFoodViewController {
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
                self?.minusButton.backgroundColor = #colorLiteral(red: 0.5385764299, green: 0.8235294223, blue: 0.4073132885, alpha: 1)
            })
            guard var dataText = Int(gramms.text ?? "Error") else { return }
            if dataText > 0 {
                dataText -= 50
            }
            gramms.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.minusButton.layer.borderWidth = 0
                self?.minusButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
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
                self?.plusButton.backgroundColor = #colorLiteral(red: 0.5385764299, green: 0.8235294223, blue: 0.4073132885, alpha: 1)
            })
            guard var dataText = Int(gramms.text ?? "Error") else { return }
            dataText += 50
            gramms.text = "\(dataText)"
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                self?.plusButton.layer.borderWidth = 0
                self?.plusButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
            })
        }
    }
    func setAddButtonGesturePolitics() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(addWater))
        gesture.minimumPressDuration = 0
        addFoodButton.addGestureRecognizer(gesture)
    }
    
    @objc private func addWater(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                let color = #colorLiteral(red: 0.5385764299, green: 0.8235294223, blue: 0.4073132885, alpha: 1)
                self?.addFoodButton.setTitleColor(color, for: .normal)
            })
            completion?(gramms.text)
        } else {
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           animations: { [weak self] in
                let color = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
                self?.addFoodButton.setTitleColor(color, for: .normal)
            })
            dismiss(animated: false, completion: nil)
        }
    }
}

