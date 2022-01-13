import Foundation
import LocalAuthentication
import UIKit

extension ViewController {
    
    private func setBlurEffect() {
        var blurEffect: UIBlurEffect!
        
        if #available(iOS 10.0, *) {
            blurEffect = UIBlurEffect(style: .dark)
        } else {
            blurEffect = UIBlurEffect(style: .light)
        }
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        blurredEffectView.alpha = 0.5
        blurredEffectView.autoresizingMask = [
            .flexibleWidth,
            .flexibleHeight
        ]
        view.addSubview(blurredEffectView)
    }
    private func removeBlurEffect() {
        for subview in view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func start() {
        let context = LAContext()
        var error: NSError?
        
        setBlurEffect()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                     error: &error) {
            let reason = "Identify yourself"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason,
                                   reply: { [weak self] success, authenticationError in
                DispatchQueue.main.async { [weak self] in
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        self?.removeBlurEffect()
                        let ac = UIAlertController(title: "Autentication failed",
                                                   message: "Please, type your login and password instead",
                                                   preferredStyle: .alert)
                        ac.addAction(UIAlertAction(title: "OK",
                                                   style: .default))
                        self?.present(ac, animated: true)
                    }
                }
            })
        } else {
            removeBlurEffect()
            let ac = UIAlertController(title: "Biometry unavailable",
                                       message: "Your device is not configured for biometric authentication",
                                       preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK",
                                       style: .default))
            present(ac, animated: true)
        }
    }
}

