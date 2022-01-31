//
//  TextWithStepperView.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 28/12/2021.
//

import UIKit

class TextWithStepperView: UIView {
    
    // MARK: - Properties
    
    var timeUnitTitle = UILabel()
    var stepper = UIStepper()
    var didIncrementStepper: Bool = false
    
    var stepperAmount: Double = 0 {
        didSet {
            stepper.value = stepperAmount
            stepperValue = stepperAmount
        }
    }
    
    var timeUnitAmount = UILabel()
  
    // MARK: - Private properties
    
    private var stackView = UIStackView()
    private  var stepperStackView = UIStackView()
    private var timeUnitType = String()
    
    private var stepperValue: Double = 0 {
        didSet {
            didIncrementStepper = stepperValue > oldValue ? true : false
        }
    }
    
    // MARK: - objc methods
    
    @objc func updateTimeUnitAmount(_ sender: UIStepper) {
        print("UIStepper is now \(Int(sender.value))")
        timeUnitAmount.text = String(sender.value.shortDigitsIn(0))
        stepperValue = sender.value
    }
    
    // MARK: - Methods
    
    func addTarget(_ target: Any?, action: Selector) {
        stepper.addTarget(target, action: action, for: .valueChanged)
    }
    
    func configureView() {
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 99
        stepper.addTarget(self, action: #selector(updateTimeUnitAmount(_:)), for: .valueChanged)
        timeUnitAmount.text = "0"
        stepperStackView.axis = .horizontal
        stepperStackView.spacing = 24
        stepperStackView.addArrangedSubview(stepper)
        stepperStackView.addArrangedSubview(timeUnitAmount)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.addArrangedSubview(timeUnitTitle)
        stackView.addArrangedSubview(stepperStackView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            
            timeUnitAmount.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
