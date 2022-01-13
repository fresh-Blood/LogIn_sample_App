import Foundation
import UIKit




extension MainViewController {
    func setFoodButtonGesture() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(addFood))
        gesture.minimumPressDuration = 0
        addFoodButton.addGestureRecognizer(gesture)
    }
    @objc private func addFood(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addFoodButton.layer.borderWidth = 5
                self?.addFoodButton.backgroundColor = #colorLiteral(red: 0.5725161983, green: 0.9764705896, blue: 0.5557012552, alpha: 1)
            })
            eatNumbers.layer.removeAllAnimations()
            let addFoodVC = AddFoodViewController()
            self.timer?.invalidate()
            self.totalSecondsOfHungryMode = 0
            self.totalSecondsOfEatingMode = 0
            self.eatNumbers.text = "0"
            DispatchQueue.global(qos: .utility).async { [weak self] in
                self?.synthesizer.speak((self?.utterenceArr8.randomElement()!)!)
            }
            addFoodVC.modalTransitionStyle = .crossDissolve
            addFoodVC.modalPresentationStyle = .overCurrentContext
            present(addFoodVC, animated: true, completion: nil)
        } else {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addFoodButton.layer.borderWidth = 0
                self?.addFoodButton.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
                self?.startEatingMode()
                self?.youCanEatNowLabel.text = "you can eat now"
                self?.eatNumbers.textColor = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
            })
        }
    }
    func setLiquidButtonGesture() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(addLiquid))
        gesture.minimumPressDuration = 0
        addLiquidButton.addGestureRecognizer(gesture)
    }
    @objc private func addLiquid(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addLiquidButton.layer.borderWidth = 5
                self?.addLiquidButton.backgroundColor = #colorLiteral(red: 0.4868322455, green: 0.9436092721, blue: 0.9764705896, alpha: 1)
            })
            let addWaterVC = AddWaterViewController()
            addWaterVC.completion = { [weak self] text in
                DispatchQueue.main.async {
                    
                    guard
                        var actualValue = Int(self?.drinkNumbers.text ?? "0")
                    else {
                        print("Some error occured")
                        return
                    }
                    
                    actualValue -= Int(text ?? "0") ?? 0
                    
                    if actualValue > 0 {
                        self?.drinkNumbers.text = "\(actualValue)"
                        self?.endValue = "\(actualValue)"
                    } else {
                        self?.drinkNumbers.text = "0"
                        self?.endValue = "0"
                    }
                }
            }
            addWaterVC.modalTransitionStyle = .crossDissolve
            addWaterVC.modalPresentationStyle = .overCurrentContext
            present(addWaterVC, animated: true, completion: nil)
        } else {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addLiquidButton.layer.borderWidth = 0
                self?.addLiquidButton.backgroundColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9843137255, alpha: 1)
            })
        }
    }
    func setMoodButtonGesture() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(addMood))
        gesture.minimumPressDuration = 0
        addMoodButton.addGestureRecognizer(gesture)
    }
    @objc private func addMood(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addMoodButton.layer.borderWidth = 5
                self?.addMoodButton.backgroundColor = #colorLiteral(red: 0.7215125951, green: 0.6610905325, blue: 0.9764705896, alpha: 1)
            })
        } else {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addMoodButton.layer.borderWidth = 0
                self?.addMoodButton.backgroundColor = #colorLiteral(red: 0.431372549, green: 0.2941176471, blue: 0.9215686275, alpha: 1)
            })
        }
    }
    func setFireButtonGesture() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(addFire))
        gesture.minimumPressDuration = 0
        addstart16hFastButton.addGestureRecognizer(gesture)
    }
    @objc private func addFire(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            timer?.invalidate()
            counter = 0
            DispatchQueue.global(qos: .utility).async { [weak self] in
                self?.synthesizer.speak((self?.utterenceArr16.randomElement()!)!)
            }
            eatNumbers.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addstart16hFastButton.layer.borderWidth = 5
                self?.addstart16hFastButton.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.7014931664, blue: 0.3566247024, alpha: 1)
            })
            DispatchQueue.main.async { [weak self] in
                UIView.animate(withDuration: 1.0,
                               delay: 0,
                               options: [
                                .repeat,
                                .autoreverse
                               ],
                               animations: {
                    self?.eatNumbers.textColor = #colorLiteral(red: 1, green: 0.4216593802, blue: 0.1488574743, alpha: 1)
                    self?.eatNumbers.text = "тест"
                    self?.eatNumbers.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
                }, completion: { finished in
                    self?.eatNumbers.transform = .identity
                })
                self?.youCanEatNowLabel.text = "Hungry mode on!"
            }
        } else {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.addstart16hFastButton.layer.borderWidth = 0
                self?.addstart16hFastButton.backgroundColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
            })
        }
    }
    func setEditButtonGesture() {
        let gesture = UILongPressGestureRecognizer(target: self,
                                                   action: #selector(editButton))
        gesture.minimumPressDuration = 0
        editGoalsButton.addGestureRecognizer(gesture)
    }
    @objc private func editButton(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.editGoalsButton.pulsate()
            })
            let editVC = EditGoalsViewController()
            editVC.completion = { [weak self] turple in
                DispatchQueue.main.async { [weak self] in
                    guard
                        let actualMlGoal = self?.ofMlLabel.text,
                        let actualStepsGoal = self?.ofStepslabel.text,
                        var oldMlValue = actualMlGoal.chooseNumbersOnly(),
                        var oldStepsValue = actualStepsGoal.chooseNumbersOnly(),
                        var newMlValue = turple?.0,
                        var newStepsValue = turple?.1
                    else { return }
                    oldMlValue.addSpaceInRightPlace()
                    oldStepsValue.addSpaceInRightPlace()
                    newMlValue.addSpaceInRightPlace()
                    newStepsValue.addSpaceInRightPlace()
                    self?.ofMlLabel.text = actualMlGoal.replacingOccurrences(of: oldMlValue, with: newMlValue)
                    self?.ofStepslabel.text = actualStepsGoal.replacingOccurrences(of: oldStepsValue, with: newStepsValue)
                }
            }
            editVC.modalTransitionStyle = .crossDissolve
            editVC.modalPresentationStyle = .overCurrentContext
            present(editVC,
                    animated: true,
                    completion: nil)
        } else {
            UIView.animate(withDuration: 0.15,
                           delay: 0,
                           animations: { [weak self] in
                self?.editGoalsButton.layer.removeAllAnimations()
            })
        }
    }
}

extension String {
    func chooseNumbersOnly() -> String? {
        var result = ""
        result = self.filter {
            var resultZ: Bool?
            if ($0.wholeNumberValue != nil) {
                result.append($0)
                resultZ = true
            } else {
                resultZ = false
            }
            return resultZ ?? false
        }
        return result
    }
    mutating func addSpaceInRightPlace() {
        let numbersSet: Set<String> = ["1","2","3","4","5","6","7","8","9"]
        let index = self.firstIndex { char in
            !numbersSet.contains(String(char))
        } ?? self.startIndex
        self.insert(" ", at: index)
    }
}
