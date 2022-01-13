//
//  TextWithStepperView.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 28/12/2021.
//

import UIKit

class TextWithStepperView: UIView {
    
    // MARK: - Properties
    
    var stackView = UIStackView()
    var stepperStackView = UIStackView()
    
    var timeUnitTitle = UILabel()
    var timeUnitType = String()
    
    var stepper = UIStepper()
    
    var didIncrementStepper: Bool = false
    
    private var stepperValue: Double = 0 {
        didSet {
            didIncrementStepper = stepperValue > oldValue ? true : false
        }
    }
    
    var timeUnitAmount = UILabel()
    
    // MARK: - objc methods
    
    @objc func updateTimeUnitAmount(_ sender: UIStepper) {
        print("UIStepper is now \(Int(sender.value))")
        timeUnitAmount.text = String(sender.value.shortDigitsIn(0))
        stepperValue = sender.value
    }
    
    // MARK: - Methods
    
    func configureView() {
        configureStackView()
        configureStepperStackView()
        configureTimeUnitTitle()
        configureStepper()
        addSubview(stackView)
        activateConstraints()
    }
    
    func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.addArrangedSubview(timeUnitTitle)
        stackView.addArrangedSubview(stepperStackView)
    }
    
    func configureTimeUnitTitle() {
        timeUnitTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStepperStackView() {
        stepperStackView.axis = .horizontal
        stepperStackView.spacing = 24
        stepperStackView.translatesAutoresizingMaskIntoConstraints = false
        
        timeUnitAmount.text = "0"
        
        timeUnitAmount.translatesAutoresizingMaskIntoConstraints = false
        stepperStackView.addArrangedSubview(stepper)
        stepperStackView.addArrangedSubview(timeUnitAmount)
    }
    
    func configureStepper() {
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 99
        stepper.addTarget(self, action: #selector(updateTimeUnitAmount(_:)), for: .valueChanged)
//        stepper.setDecrementImage(UIImage(systemName: "minus.circle.fill"), for: .normal)
//        stepper.setIncrementImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
    }
    
    func configureTimeUnitAmount() {
        timeUnitAmount.translatesAutoresizingMaskIntoConstraints = false
    }

    func activateConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            
            timeUnitAmount.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}
