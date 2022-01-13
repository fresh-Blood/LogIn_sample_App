import UIKit
import HealthKit
import AVFoundation

var waterPersentage: CGFloat = 0

final class MainViewController: UIViewController {
    
    lazy var totalSecondsOfHungryMode = 0
    lazy var totalSecondsOfEatingMode = 0
    var counter: Int = 0
    {
        didSet {
            counter == 0 ? startHungryMode() : startEatingMode()
        }
    }
    weak var timer: Timer?
    
    // MARK: hungry messages array you can set your own of course
    lazy var utterenceArr16: [AVSpeechUtterance] = [
        AVSpeechUtterance(string: "well well well it's time to make you more attractive"),
        AVSpeechUtterance(string: "I am here to help you my fat friend, stop eating, do sports"),
        AVSpeechUtterance(string: "It's not so bad, remember fat men are kind"),
        AVSpeechUtterance(string: "okay ok ok , they are rich also, and i do love reach people")
    ]
    // MARK: eating messages array
    lazy var utterenceArr8: [AVSpeechUtterance] = [
        AVSpeechUtterance(string: "Bon appetite"),
        AVSpeechUtterance(string: "I think it's time to eat my friend"),
        AVSpeechUtterance(string: "Nice work! Let's go to Mc'Donalds finally"),
        AVSpeechUtterance(string: "I am soo hungry")
    ]
    lazy var synthesizer = AVSpeechSynthesizer()
    
    static let shared = MainViewController()
    var startValue: Double = 0
    var endValue: String = ""
    var startStepsValue: Double = 0
    var endStepsValue: String = ""
    let animationStartDate = Date()
    let animationDuration: Double = 1.5
    
    private let ringsImage: RingsCustomView = {
        let view = RingsCustomView()
        view.backgroundColor = .systemGroupedBackground
        return view
    }()
    
    private let untilLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "until your next fast:"
        lbl.textColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        return lbl
    }()
    
    let eatNumbers: UILabel = {
        let lbl = UILabel()
        lbl.text = "03:45:09"
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 45, weight: .bold)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
        return lbl
    }()
    
    let youCanEatNowLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "you can eat now"
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        lbl.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        return lbl
    }()
    
    private let breakLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "⎯⎯⎯⎯"
        lbl.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private let leftToDrinkLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "left to drink:"
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        lbl.textColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        return lbl
    }()
    
    let drinkNumbers: UILabel = {
        let lbl = UILabel()
        lbl.text = "3000"
        lbl.textColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9843137255, alpha: 1)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 45, weight: .bold)
        return lbl
    }()
    
    let ofMlLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "of 3 000 ml"
        lbl.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        return lbl
    }()
    
    private let breakLabel1: UILabel = {
        let lbl = UILabel()
        lbl.text = "⎯⎯⎯⎯"
        lbl.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        lbl.textAlignment = .right
        return lbl
    }()
    
    private let leftToGoLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "left to go:"
        lbl.textColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        return lbl
    }()
    
    let stepsNumbers: UILabel = {
        let lbl = UILabel()
        lbl.text = "7567"
        lbl.textColor = #colorLiteral(red: 0.9450980392, green: 0.8274509804, blue: 0.007843137255, alpha: 1)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.font = .systemFont(ofSize: 45, weight: .bold)
        lbl.textAlignment = .right
        return lbl
    }()
    
    var ofStepslabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "of 9 000 steps"
        lbl.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        lbl.textAlignment = .right
        lbl.font = .systemFont(ofSize: 14, weight: .light)
        return lbl
    }()
    
    private let breakLabel2: UILabel = {
        let lbl = UILabel()
        lbl.text = "⎯⎯⎯⎯"
        lbl.textColor = #colorLiteral(red: 0.7098039216, green: 0.7098039216, blue: 0.7098039216, alpha: 1)
        lbl.textAlignment = .right
        return lbl
    }()
    
    let editGoalsButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    private let editLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "edit goals"
        lbl.textColor = .systemGroupedBackground
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.4549019608, green: 0.4549019608, blue: 0.4549019608, alpha: 1)
        lbl.font = .systemFont(ofSize: 16, weight: .light)
        return lbl
    }()
    
    private let penImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "pen")
        img.contentMode = .scaleToFill
        return img
    }()
    
    private let smallStackView: UIStackView = {
        let stck = UIStackView()
        stck.distribution = .fillProportionally
        stck.axis = .horizontal
        stck.alignment = .fill
        return stck
    }()
    
    private let mediumStackView: UIStackView = {
        let stck = UIStackView()
        stck.distribution = .fillEqually
        stck.axis = .vertical
        stck.alignment = .fill
        return stck
    }()
    
    internal let addFoodButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.8274509804, blue: 0.2039215686, alpha: 1)
        btn.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let food: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "food")
        img.contentMode = .top
        return img
    }()
    
    private let foodLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "add food"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .white
        lbl.contentMode = .bottom
        return lbl
    }()
    
    private let foodStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        return stack
    }()
    
    internal let addLiquidButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0, green: 0.6509803922, blue: 0.9843137255, alpha: 1)
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        return btn
    }()
    
    private let liquid: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "liquid")
        img.contentMode = .top
        return img
    }()
    
    private let liquidLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "add liquid"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .white
        lbl.contentMode = .bottom
        return lbl
    }()
    
    private let liquidStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        return stack
    }()
    
    internal let addMoodButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 0.431372549, green: 0.2941176471, blue: 0.9215686275, alpha: 1)
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        return btn
    }()
    
    private let mood: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "mood")
        img.contentMode = .top
        return img
    }()
    
    private let moodLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "add mood"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .white
        lbl.contentMode = .bottom
        return lbl
    }()
    
    private let moodStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .leading
        return stack
    }()
    
    internal let addstart16hFastButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = #colorLiteral(red: 1, green: 0.3294117647, blue: 0.1176470588, alpha: 1)
        btn.layer.cornerRadius = 8
        btn.layer.borderColor = UIColor.systemGroupedBackground.cgColor
        return btn
    }()
    
    private let fire: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "fire")
        img.contentMode = .left
        return img
    }()
    
    private let fireLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "start 16h fast"
        lbl.numberOfLines = 0
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.textColor = .white
        lbl.contentMode = .bottom
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    private let fireLabel1: UILabel = {
        let lbl = UILabel()
        lbl.text = "at 9:00 pm"
        lbl.font = .systemFont(ofSize: 14, weight: .medium)
        lbl.alpha = 0.5
        lbl.textColor = .white
        lbl.contentMode = .bottom
        lbl.adjustsFontSizeToFitWidth = true
        return lbl
    }()
    
    private let buttonsStackView1: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.backgroundColor = .systemGroupedBackground
        return stack
    }()
    private let buttonsStackView2: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.backgroundColor = .systemGroupedBackground
        return stack
    }()
    private let buttonsStackView3: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.backgroundColor = .systemGroupedBackground
        return stack
    }()
    
    func setNiceNumbersAnimation() {
        let displayLink = CADisplayLink(target: self,
                                        selector: #selector(handleUpdate))
        displayLink.add(to: .main, forMode: .default)
    }
    
    @objc private func handleUpdate() {
        
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)
        
        if elapsedTime > animationDuration {
            drinkNumbers.text = endValue
            waterPersentage = CGFloat(Int(endValue) ?? 0)
            stepsNumbers.text = endStepsValue
        } else {
            let percantage = elapsedTime / animationDuration
            let value = percantage * ((Double(endValue) ?? 0) - startValue)
            let value1 = percantage * ((Double(endStepsValue) ?? 0) - startStepsValue)
            drinkNumbers.text = "\(Int(value))"
            waterPersentage = CGFloat(Int(value))
            stepsNumbers.text = "\(Int(value1))"
        }
    }
    
    func loadValues() {
        endValue = drinkNumbers.text ?? "Error"
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        guard
            let day = components.day,
            let savedDay = UserDefaults.standard.object(forKey: CodingKeys.dateForToday.rawValue) as? Int,
            let savedWaterValue = UserDefaults.standard.object(forKey: CodingKeys.water.rawValue) as? String,
            let savedMl = UserDefaults.standard.object(forKey:CodingKeys.waterValue.rawValue) as? String,
            let savedSteps = UserDefaults.standard.object(forKey: CodingKeys.stepsValue.rawValue) as? String,
            let goal = savedMl.chooseNumbersOnly()
        else { return }
        
        if day != savedDay || savedDay == 0 {
            endValue = goal
            drinkNumbers.text = endValue
        } else if Int(savedWaterValue) ?? 0 > Int(goal) ?? 0 {
            endValue = goal
            drinkNumbers.text = endValue
            ofMlLabel.text = savedMl
            ofStepslabel.text = savedSteps
        } else {
            endValue = savedWaterValue
            drinkNumbers.text = endValue
            ofMlLabel.text = savedMl
            ofStepslabel.text = savedSteps
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadValues()
        setHealthKitPolitics()
        setNiceNumbersAnimation()
        setFoodButtonGesture()
        setLiquidButtonGesture()
        setMoodButtonGesture()
        setFireButtonGesture()
        setEditButtonGesture()
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(ringsImage)
        editGoalsButton.addSubview(penImage)
        editGoalsButton.addSubview(editLabel)
        view.addSubview(editGoalsButton)
        mediumStackView.addArrangedSubview(untilLabel)
        mediumStackView.addArrangedSubview(eatNumbers)
        mediumStackView.addArrangedSubview(youCanEatNowLabel)
        mediumStackView.addArrangedSubview(breakLabel)
        mediumStackView.addArrangedSubview(leftToDrinkLabel)
        mediumStackView.addArrangedSubview(drinkNumbers)
        mediumStackView.addArrangedSubview(ofMlLabel)
        mediumStackView.addArrangedSubview(breakLabel1)
        mediumStackView.addArrangedSubview(leftToGoLabel)
        mediumStackView.addArrangedSubview(stepsNumbers)
        mediumStackView.addArrangedSubview(ofStepslabel)
        mediumStackView.addArrangedSubview(breakLabel2)
        view.addSubview(mediumStackView)
        foodStackView.addArrangedSubview(food)
        foodStackView.addArrangedSubview(foodLabel)
        addFoodButton.addSubview(foodStackView)
        buttonsStackView1.addArrangedSubview(addFoodButton)
        liquidStackView.addArrangedSubview(liquid)
        liquidStackView.addArrangedSubview(liquidLabel)
        addLiquidButton.addSubview(liquidStackView)
        buttonsStackView1.addArrangedSubview(addLiquidButton)
        moodStackView.addArrangedSubview(mood)
        moodStackView.addArrangedSubview(moodLabel)
        addMoodButton.addSubview(moodStackView)
        buttonsStackView2.addArrangedSubview(buttonsStackView1)
        buttonsStackView2.addArrangedSubview(addMoodButton)
        buttonsStackView3.addArrangedSubview(buttonsStackView2)
        addstart16hFastButton.addSubview(fire)
        addstart16hFastButton.addSubview(fireLabel)
        addstart16hFastButton.addSubview(fireLabel1)
        buttonsStackView3.addArrangedSubview(addstart16hFastButton)
        view.addSubview(buttonsStackView3)
        _ = utterenceArr16.map{
            $0.voice = AVSpeechSynthesisVoice(language: "en-IE")
        }
        _ = utterenceArr8.map{
            $0.voice = AVSpeechSynthesisVoice(language: "en-IE")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let inset: CGFloat = 20
        let height = (view.bounds.height/3*2) - view.safeAreaInsets.top
        let width = (height/2) - view.safeAreaInsets.top + inset
        ringsImage.frame = CGRect(x: view.bounds.minX,
                                  y: view.bounds.minY + view.safeAreaInsets.top,
                                  width: width,
                                  height: height)
        mediumStackView.frame = CGRect(x: view.bounds.midX - view.safeAreaInsets.right,
                                       y: view.bounds.minY + view.safeAreaInsets.top + inset,
                                       width: view.bounds.width/2 - inset,
                                       height: view.bounds.height/2 - inset)
        editGoalsButton.frame = CGRect(x: view.bounds.width/2 + inset,
                                       y: view.bounds.minY + view.safeAreaInsets.top + mediumStackView.bounds.height + inset*2,
                                       width: view.bounds.width/2 - view.safeAreaInsets.right,
                                       height: inset)
        editLabel.frame = CGRect(x: editGoalsButton.bounds.minX + inset,
                                 y: editGoalsButton.bounds.minY,
                                 width: editGoalsButton.bounds.width/3*2,
                                 height: editGoalsButton.bounds.height)
        penImage.frame = CGRect(x: editGoalsButton.bounds.minX + editLabel.bounds.width + inset/2,
                                y: editGoalsButton.bounds.minY,
                                width: inset,
                                height: editGoalsButton.bounds.height)
        buttonsStackView1.setCustomSpacing(5, after: addFoodButton)
        buttonsStackView2.setCustomSpacing(5, after: buttonsStackView1)
        buttonsStackView3.setCustomSpacing(5, after: buttonsStackView2)
        buttonsStackView3.frame = CGRect(x: view.bounds.minX + view.safeAreaInsets.left + inset,
                                         y: view.bounds.minY + view.safeAreaInsets.top + mediumStackView.bounds.height + inset*2 + editGoalsButton.frame.height + inset*2,
                                         width: view.bounds.width - view.safeAreaInsets.right - inset*2 - view.safeAreaInsets.right,
                                         height: view.bounds.height/4.5)
        let inset1: CGFloat = 16
        let inset2: CGFloat = 5
        buttonsStackView1.layoutIfNeeded()
        buttonsStackView2.layoutIfNeeded()
        buttonsStackView3.layoutIfNeeded()
        foodStackView.frame = CGRect(x: addFoodButton.bounds.minX + inset1,
                                     y: addFoodButton.bounds.minY + inset1,
                                     width: addFoodButton.bounds.width,
                                     height: addFoodButton.bounds.height - inset1)
        liquidStackView.frame = CGRect(x: addLiquidButton.bounds.minX + inset1,
                                       y: addLiquidButton.bounds.minY + inset1,
                                       width: addLiquidButton.bounds.width,
                                       height: addLiquidButton.bounds.height - inset1)
        moodStackView.frame = CGRect(x: addMoodButton.bounds.minX + inset1,
                                     y: addMoodButton.bounds.minY + inset1,
                                     width: addMoodButton.bounds.width,
                                     height: addMoodButton.bounds.height - inset1)
        fire.frame = CGRect(x: addstart16hFastButton.bounds.minX + inset1,
                            y: addstart16hFastButton.bounds.minY + inset1 + inset2,
                            width: addstart16hFastButton.bounds.width,
                            height: inset1)
        fireLabel.frame = CGRect(x: addstart16hFastButton.bounds.minX + inset1,
                                 y: addstart16hFastButton.bounds.maxY - inset1*3,
                                 width: addstart16hFastButton.bounds.width - inset1*2,
                                 height: inset1)
        fireLabel1.frame = CGRect(x: addstart16hFastButton.bounds.minX + inset1,
                                  y: addstart16hFastButton.bounds.maxY - inset1*2,
                                  width: addstart16hFastButton.bounds.width - inset1*2,
                                  height: inset1)
        view.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            let newWaterValue = endValue
        guard
            let newOfMlValue = ofMlLabel.text,
            let newOfStepsValue = ofStepslabel.text,
            let steps = stepsNumbers.text
        else { return }
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        guard
            let day = components.day else { return }
        
        UserDefaults.standard.set(day, forKey: CodingKeys.dateForToday.rawValue)
        UserDefaults.standard.set(newWaterValue, forKey: CodingKeys.water.rawValue)
        UserDefaults.standard.set(newOfMlValue, forKey: CodingKeys.waterValue.rawValue)
        UserDefaults.standard.set(newOfStepsValue, forKey: CodingKeys.stepsValue.rawValue)
        UserDefaults.standard.set(steps, forKey: CodingKeys.steps.rawValue)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}

