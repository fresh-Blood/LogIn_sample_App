import UIKit



final class AddWaterViewController: UIViewController {
    
    public var completion: ((String?) -> Void)?
    
    let addWaterButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add water",
                     for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        let color = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
        btn.setTitleColor(color,
                          for: .normal)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    private let closeButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(systemName: "xmark"),
                               for: .normal)
        btn.tintColor = #colorLiteral(red: 0.6500751972, green: 0.650090754, blue: 0.6500824094, alpha: 1)
        btn.addTarget(self,
                      action: #selector(close),
                      for: .touchUpInside)
        return btn
    }()
    
    @objc private func close() {
        dismiss(animated: false, completion: nil)
    }
    let minusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "minus"),
                     for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        btn.tintColor = .white
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.imageEdgeInsets = UIEdgeInsets(top: 25, left: 10, bottom: 25, right: 10)
        return btn
    }()
    
    let plusButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "plus"),
                     for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        btn.tintColor = .white
        btn.contentVerticalAlignment = .fill
        btn.contentHorizontalAlignment = .fill
        btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: 10, bottom: 12, right: 10)
        return btn
    }()
    
    let ml: CustomTextField1 = {
        let text = CustomTextField1()
        text.text = "250"
        text.textAlignment = .center
        text.font = .systemFont(ofSize: 25, weight: .bold)
        text.isUserInteractionEnabled = false 
        text.layer.cornerRadius = 10
        text.layer.borderWidth = 2
        text.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.8352941176, blue: 0.8352941176, alpha: 1)
        text.textColor = #colorLiteral(red: 0.3294117647, green: 0.3294117647, blue: 0.3294117647, alpha: 1)
        return text
    }()
    
    private let mlLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "ml"
        lbl.textColor = #colorLiteral(red: 0.5843137255, green: 0.5843137255, blue: 0.5843137255, alpha: 1)
        return lbl
    }()
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGroupedBackground
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 6, height: 6)
        view.layer.shadowRadius = 8
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPlusButtonGesturePolitics()
        setMinusButtonGesturePolitics()
        setAddButtonGesturePolitics()
        customView.addSubview(addWaterButton)
        customView.addSubview(closeButton)
        customView.addSubview(plusButton)
        customView.addSubview(ml)
        customView.addSubview(minusButton)
        ml.addSubview(mlLabel)
        view.addSubview(customView)
        view.backgroundColor = .systemGroupedBackground.withAlphaComponent(0.5)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let inset: CGFloat = 40
        customView.frame = CGRect(x: view.bounds.minX + inset/2 + view.safeAreaInsets.left,
                                  y: view.bounds.height/5*2 - view.safeAreaInsets.top,
                                  width: view.bounds.width - inset - view.safeAreaInsets.right,
                                  height: view.bounds.height/4)
        
        addWaterButton.frame = CGRect(x: customView.bounds.minX + inset,
                                      y: customView.bounds.minY + inset,
                                      width: customView.bounds.width - inset*2 - inset/1.5,
                                      height: inset/2)
        closeButton.frame = CGRect(x: addWaterButton.frame.maxX,
                                   y: customView.bounds.minY + inset,
                                   width: inset/1.5,
                                   height: inset/1.5)
        ml.rightView = mlLabel
        ml.rightViewMode = .always
        let inset1: CGFloat = 10
        minusButton.frame = CGRect(x: customView.bounds.minX + inset,
                                   y: customView.bounds.midY,
                                   width: inset*1.5,
                                   height: inset*1.5)
        
        ml.frame = CGRect(x: customView.bounds.minX + inset + plusButton.frame.width + inset1,
                          y: customView.bounds.midY,
                          width: (customView.bounds.width - inset*1.5)/2,
                          height: inset*1.5)
        
        plusButton.frame = CGRect(x: customView.bounds.minX + inset + plusButton.frame.width + inset1 + ml.frame.width + inset1,
                                  y: customView.bounds.midY,
                                  width: inset*1.5,
                                  height: inset*1.5)
        plusButton.backgroundColor = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
        minusButton.backgroundColor = #colorLiteral(red: 0, green: 0.7137254902, blue: 0.9882352941, alpha: 1)
        plusButton.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        minusButton.layer.borderColor = UIColor.systemGroupedBackground.cgColor
    }
}

final class CustomTextField1: UITextField {
    let inset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 30)
    
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

