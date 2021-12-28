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
    
//    var minusButton = UIButton()
    var timeUnitAmount = UILabel()
//    var plusButton = UIButton()
    
    
    // MARK: - Methods
    
    func configureView() {
        configureStackView()
        configureStepperStackView()
        configureTimeUnitTitle()
        configureStepper()
        self.addSubview(stackView)
        activateConstraints()
        
       // configureMinusButton()
       // configureTimeUnitAmount()
       // configurePlusButton()
    }
    
    func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.addArrangedSubview(timeUnitTitle)
        stackView.addArrangedSubview(stepperStackView)
//        stackView.addArrangedSubview(minusButton)
//        stackView.addArrangedSubview(timeUnitAmount)
//        stackView.addArrangedSubview(plusButton)
    }
    
    func configureTimeUnitTitle() {
        timeUnitTitle.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureStepperStackView() {
        stepperStackView.axis = .horizontal
        stepperStackView.spacing = 8
        stepperStackView.translatesAutoresizingMaskIntoConstraints = false
        timeUnitAmount.text = "0"
        timeUnitAmount.translatesAutoresizingMaskIntoConstraints = false
        stepperStackView.addArrangedSubview(stepper)
        stepperStackView.addArrangedSubview(timeUnitAmount)
    }
    
    func configureStepper() {
        stepper.translatesAutoresizingMaskIntoConstraints = false
       // stepper.setDecrementImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
       // stepper.setIncrementImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
    }
    
    func configureTimeUnitAmount() {
        timeUnitAmount.translatesAutoresizingMaskIntoConstraints = false
        timeUnitAmount.text = String(stepper.value)
    }

    func activateConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0)
        ])
    }
    
    
//    func configureMinusButton() {
//        minusButton.translatesAutoresizingMaskIntoConstraints = false
//    }
    
//    func configureTimeUnitAmount() {
//        timeUnitAmount.translatesAutoresizingMaskIntoConstraints = false
//    }
//
//    func configurePlusButton() {
//        plusButton.translatesAutoresizingMaskIntoConstraints = false
//    }
}
