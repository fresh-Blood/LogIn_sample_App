import UIKit


final class ViewController: UIViewController, UITextFieldDelegate {
    
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
    internal let emailLabel: CustomTextField = {
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
    
    internal let passwordLabel: CustomTextField = {
        let txt = CustomTextField()
        txt.placeholder = "Enter your password"
        txt.font = .systemFont(ofSize: 16, weight: .light)
        txt.layer.cornerRadius = 10
        txt.layer.borderWidth = 2
        txt.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        txt.isSecureTextEntry.toggle()
        return txt
    }()
    
    private let forgotpasswordButton: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSMutableAttributedString(string: "Forgot password?",
                                                         attributes: [
                                                            .underlineStyle : NSUnderlineStyle
                                                                .single
                                                                .rawValue,
                                                            .font : UIFont.systemFont(ofSize: 16,weight: .light),
                                                            .foregroundColor : #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
                                                         ]),
                               for: .normal)
        btn.addTarget(self,
                      action: #selector(presentSignInVc),
                      for: .touchUpInside)
        return btn
    }()
    @objc private func presentSignInVc() {
        let signInVc = SignInViewController()
        signInVc.modalTransitionStyle = .flipHorizontal
        signInVc.modalPresentationStyle = .fullScreen
        present(signInVc,
                animated: true,
                completion: nil)
    }
    private let createAccWithEmailButton: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSMutableAttributedString(string: "Create account with e-mail",
                                                         attributes: [
                                                            .underlineStyle : NSUnderlineStyle
                                                                .single
                                                                .rawValue,
                                                            .font : UIFont.systemFont(ofSize: 16,weight:.light),
                                                            .foregroundColor : #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
                                                         ]),
                               for: .normal)
        btn.addTarget(self,
                      action: #selector(signIn),
                      for: .touchUpInside)
        return btn
    }()
    
    @objc private func signIn() {
        let vc = SignInViewController()
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc,
                animated: true,
                completion: nil)
        createAccWithEmailButton.pulsate()
    }
    
    func presentTabBarVc() {
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
    
    private let logInButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Log in",
                     for: .normal)
        btn.setTitleColor(.white,
                          for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.addTarget(self,
                      action: #selector(startApp),
                      for: .touchUpInside)
        return btn
    }()
    @objc private func startApp() {
        logInButton.pulsate()
        
        guard
            let email = emailLabel.text?.lowercased() else { return }
        guard
            let pass = passwordLabel.text else { return }
        
        if UserErrorsPolitics.checkUser(emailLabel, passwordLabel, email, pass) {
            presentTabBarVc()
        }
    }
    
    func unlockSecretMessage() {
        presentTabBarVc()
    }
    
    private let continueLabel: UILabel = {
        let lbl = UILabel()
        lbl.attributedText = NSMutableAttributedString(string: "⎯⎯⎯⎯  Or continue with  ⎯⎯⎯⎯",
                                                       attributes: [
                                                        .font : UIFont.systemFont(ofSize: 16, weight: .light),
                                                        .foregroundColor : #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1),
                                                       ])
        lbl.textAlignment = .center
        return lbl
    }()
    private let googleButton: UIButton = {
        let btn = UIButton()
        let color = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.setTitle("G",
                     for: .normal)
        btn.setTitleColor(color,
                          for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 35,
                                           weight: .bold)
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self,
                      action: #selector(goGoogle),
                      for: .touchUpInside)
        return btn
    }()
    @objc private func goGoogle() {
        // Here we need to implement Google's Sigh - in SDK but no such mission in test missions(
        googleButton.pulsate()
        if let url = URL(string: CodingKeys.googleUrl.rawValue) {
            UIApplication.shared.open(url)
        }
    }
    private let appleButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "apple"),
                     for: .normal)
        btn.imageView?.tintColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.imageView?.scalesLargeContentImage = true
        btn.layer.cornerRadius = 10
        btn.layer.borderWidth = 2
        btn.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.addTarget(self,
                      action: #selector(goApple),
                      for: .touchUpInside)
        return btn
    }()
    @objc private func goApple() {
        // Here we need to implement Apple ID's Sigh - in SDK but no such mission in test missions( (i did it for practise - it worked correct superEasy in docs)
        appleButton.pulsate()
        if let url = URL(string: CodingKeys.appleUrl.rawValue) {
            UIApplication.shared.open(url)
        }
    }
    
    private let metaButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("f",
                     for: .normal)
        let color = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.setTitleColor(color,
                          for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 35,
                                           weight: .bold)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 2
        btn.layer.borderColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.addTarget(self,
                      action: #selector(goMeta),
                      for: .touchUpInside)
        return btn
    }()
    @objc private func goMeta() {
        // the same
        metaButton.pulsate()
        if let url = URL(string: CodingKeys.metaUrl.rawValue) {
            UIApplication.shared.open(url)
        }
        
    }
    private let buttonsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    private let superStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordLabel.delegate = self
        emailLabel.delegate = self
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(nameLabel)
        view.addSubview(todoLabel)
        superStackView.addArrangedSubview(emailTitleLabel)
        superStackView.addArrangedSubview(emailLabel)
        superStackView.addArrangedSubview(passwordTitleLabel)
        superStackView.addArrangedSubview(passwordLabel)
        buttonsStackView.addArrangedSubview(googleButton)
        buttonsStackView.addArrangedSubview(appleButton)
        buttonsStackView.addArrangedSubview(metaButton)
        superStackView.addArrangedSubview(forgotpasswordButton)
        superStackView.addArrangedSubview(logInButton)
        superStackView.addArrangedSubview(continueLabel)
        superStackView.addArrangedSubview(buttonsStackView)
        superStackView.addArrangedSubview(createAccWithEmailButton)
        view.addSubview(superStackView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        start()
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
                                 y: view.bounds.height/10 + view.safeAreaInsets.top,
                                 width: view.bounds.width,
                                 height: inset*4)
        todoLabel.frame = CGRect(x: x,
                                 y: view.bounds.height/10 + view.safeAreaInsets.top + nameLabel.bounds.height,
                                 width: view.bounds.width,
                                 height: inset)
        superStackView.frame = CGRect(x: x,
                                      y: view.bounds.height/10 + view.safeAreaInsets.top + nameLabel.bounds.height + todoLabel.bounds.height + inset,
                                      width: view.bounds.width - inset*2 - view.safeAreaInsets.right*2,
                                      height: view.bounds.height/3*2 - view.safeAreaInsets.bottom - inset)
        buttonsStackView.setCustomSpacing(30, after: googleButton)
        buttonsStackView.setCustomSpacing(30, after: appleButton)
        logInButton.layer.cornerRadius = 10
        superStackView.setCustomSpacing(20, after: logInButton)
        superStackView.setCustomSpacing(10, after: continueLabel)
        superStackView.setCustomSpacing(15, after: buttonsStackView)
        superStackView.setCustomSpacing(15, after: passwordLabel)
        superStackView.setCustomSpacing(10, after: forgotpasswordButton)
        passwordLabel.rightView = eyeButton
        passwordLabel.rightViewMode = .always
    }
}


enum CodingKeys: String {
    case water
    case steps 
    case googleUrl = "https://developers.google.com/identity/sign-in/ios"
    case appleUrl = "https://medium.com/@priya_talreja/sign-in-with-apple-using-swift-5cd8695a46b6"
    case metaUrl = "https://developers.facebook.com/docs/facebook-login/ios/"
    case dateForToday
    case waterValue
    case stepsValue
}
