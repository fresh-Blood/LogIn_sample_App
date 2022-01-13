import UIKit

final class SignInViewController: UIViewController, UITextFieldDelegate {
    
    private let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Fasts"
        lbl.textColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        lbl.font = .systemFont(ofSize: 70, weight: .bold)
        return lbl
    }()
    private let todoLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Log into your account or register"
        lbl.textColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        lbl.font = .systemFont(ofSize: 16, weight: .light)
        return lbl
    }()
    private let emailTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "    E-mail"
        lbl.textColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    private let emailLabel: CustomTextField = {
        let txt = CustomTextField()
        txt.placeholder = "Enter your e-mail"
        txt.font = .systemFont(ofSize: 16, weight: .light)
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 2
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        return txt
    }()
    private let passwordTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "    Password"
        lbl.textColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    private let passwordLabel: CustomTextField = {
        let txt = CustomTextField()
        txt.placeholder = "Enter your password"
        txt.font = .systemFont(ofSize: 16, weight: .light)
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 2
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.isSecureTextEntry.toggle()
        return txt
    }()
    private let eyeButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "eye.slash"),
                     for: .normal)
        btn.addTarget(self,
                      action: #selector(changePassVisability),
                      for: .touchUpInside)
        btn.tintColor = .systemGray2
        return btn
    }()
    @objc private func changePassVisability() {
        if passwordLabel.isSecureTextEntry == true {
            eyeButton.setImage(UIImage(systemName: "eye"),
                               for: .normal)
            passwordLabel.isSecureTextEntry = false
        } else {
            eyeButton.setImage(UIImage(systemName: "eye.slash"),
                               for: .normal)
            passwordLabel.isSecureTextEntry = true
        }
    }
    
    private let signUpbutton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign up",
                     for: .normal)
        btn.setTitleColor(.white,
                          for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.addTarget(self,
                      action: #selector(startApp),
                      for: .touchUpInside)
        return btn
    }()
    
    @objc private func startApp() {
        signUpbutton.pulsate()
        
        guard
            let email = emailLabel.text?.lowercased() else { return }
        guard
            let pass = passwordLabel.text else { return }
        
        if UserErrorsPolitics.checkUserSign(emailLabel, passwordLabel, email, pass) {
            let tabBarVC = UITabBarController()
            let mainVC = MainViewController()
            mainVC.title = "main"
            mainVC.tabBarItem.image = UIImage(named: "Vector")
            let profileVC = ProfileViewController()
            profileVC.title = "profile"
            profileVC.tabBarItem.image = UIImage(named: "Vector1")
            let statsVC = StatsViewController()
            statsVC.title = "stats"
            statsVC.tabBarItem.image = UIImage(named: "3")
            let settingsVC = SettingsViewController()
            settingsVC.title = "settings"
            settingsVC.tabBarItem.image = UIImage(named: "4")
            tabBarVC.setViewControllers([mainVC,profileVC,statsVC,settingsVC], animated: true)
            tabBarVC.modalTransitionStyle = .flipHorizontal
            tabBarVC.modalPresentationStyle = .fullScreen
            tabBarVC.tabBar.tintColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
            present(tabBarVC,
                    animated: true,
                    completion: nil)
        }
    }
    
    private let backToLogInButton: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSMutableAttributedString(string: "Back to log in",
                                                         attributes: [
                                                            .underlineStyle : NSUnderlineStyle.single.rawValue,
                                                            .font : UIFont.systemFont(ofSize: 16,weight:.light),
                                                            .foregroundColor : #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
                                                         ]),
                               for: .normal)
        btn.addTarget(self,
                      action: #selector(backToLogIn),
                      for: .touchUpInside)
        return btn
    }()
    @objc private func backToLogIn() {
        dismiss(animated: true,
                completion: nil)
        backToLogInButton.pulsate()
    }
    private let superStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailLabel.delegate = self
        passwordLabel.delegate = self 
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(nameLabel)
        view.addSubview(todoLabel)
        superStackView.addArrangedSubview(emailTitleLabel)
        superStackView.addArrangedSubview(emailLabel)
        superStackView.addArrangedSubview(passwordTitleLabel)
        superStackView.addArrangedSubview(passwordLabel)
        superStackView.addArrangedSubview(signUpbutton)
        superStackView.addArrangedSubview(backToLogInButton)
        view.addSubview(superStackView)
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let inset: CGFloat = 20
        let x = view.bounds.minX + view.safeAreaInsets.left + inset
        nameLabel.frame = CGRect(x: x,
                                 y: view.bounds.height/10*3 + view.safeAreaInsets.top,
                                 width: view.bounds.width,
                                 height: inset*4)
        todoLabel.frame = CGRect(x: x,
                                 y: view.bounds.height/10*3 + view.safeAreaInsets.top + nameLabel.bounds.height,
                                 width: view.bounds.width,
                                 height: inset)
        superStackView.frame = CGRect(x: x,
                                      y: view.bounds.height/10*3 + view.safeAreaInsets.top + nameLabel.bounds.height + todoLabel.bounds.height + inset,
                                      width: view.bounds.width - inset*2 - view.safeAreaInsets.right*2,
                                      height: view.bounds.height/2 - view.safeAreaInsets.bottom - inset)
        signUpbutton.layer.cornerRadius = 10
        superStackView.setCustomSpacing(100, after: passwordLabel)
        superStackView.setCustomSpacing(10, after: signUpbutton)
        passwordLabel.rightView = eyeButton
        passwordLabel.rightViewMode = .always
    }
}

extension UIButton {
    func pulsate() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.damping = 1.0
        animation.fromValue = 0.98
        animation.toValue = 1.0
        animation.duration = 0.05
        self.layer.add(animation,
                       forKey: nil)
    }
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        super.hitTest(point, with: event)
        var result: UIView?
        if self.bounds.contains(point) {
            result = self
        }
        return result
    }
}


final class CustomTextField: UITextField {
    let inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 45)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return bounds.inset(by: inset)
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds)
        return bounds.inset(by: inset)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds)
        return bounds.inset(by: inset)
    }
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= 10
        return textRect
    }
}
