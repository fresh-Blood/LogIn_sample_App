import Foundation
import AVFoundation


extension MainViewController {
     func startHungryMode() {
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(self.startHungry),
                                          userInfo: nil,
                                          repeats: false)
    }
    
    @objc private func startHungry() {
        totalSecondsOfHungryMode += 1
        if totalSecondsOfHungryMode % 57600 == 0 {
            self.counter = 1
            synthesizer.speak(utterenceArr16.randomElement()!)
        } else {
            self.counter = 0
        }
        self.eatNumbers.text = String(totalSecondsOfHungryMode).presentInHoursAndMinutes()
    }
    
     func startEatingMode() {
        self.timer = Timer.scheduledTimer(timeInterval: 1,
                                          target: self,
                                          selector: #selector(self.startEating),
                                          userInfo: nil,
                                          repeats: false)
    }
    
    @objc private func startEating() {
        totalSecondsOfEatingMode += 1
        if totalSecondsOfEatingMode % 28800 == 0 {
            self.counter = 0
            synthesizer.speak(utterenceArr8.randomElement()!)
        } else {
            self.counter = 1
        }
        self.eatNumbers.text = String(totalSecondsOfEatingMode).presentInHoursAndMinutes()
    }
}

// MARK: "translating" into hours : minutes : seconds view as we need to display
extension String {
    func presentInHoursAndMinutes() -> String {
        var hours = 0
        var minutes = 0 {
            didSet {
                if minutes >= 60 {
                    hours = minutes / 60
                    minutes = minutes % 60
                }
            }
        }
        var seconds = 0
        minutes = Int(String(String((Int(self) ?? 0) / 60).drop(while: { character in
            character == "."
        }))) ?? 0
        seconds = (Int(self) ?? 0) % 60
        return "\(hours)h : \(minutes)min : \(seconds)s"
    }
}
