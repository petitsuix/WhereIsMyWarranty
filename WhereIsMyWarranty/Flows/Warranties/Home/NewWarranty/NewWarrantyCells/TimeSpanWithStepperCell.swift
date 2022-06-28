//
//  TimeSpanWithStepperCell.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 24/06/2022.
//

import UIKit

class TimeSpanWithStepperCell: UICollectionViewListCell {
    
    // MARK: - Internal properties
    
    static let identifier = "TimeSpanWithStepperCell"
    
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
    
    private var parentStackView = UIStackView()
    private  var stepperStackView = UIStackView()
    private var timeUnitType = String()
    
    private var stepperValue: Double = 0 {
        didSet {
            didIncrementStepper = stepperValue > oldValue ? true : false
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.initCoderNotImplemented)
    }
    
    // MARK: - objc methods
    
    @objc func updateTimeUnitAmount(_ sender: UIStepper) {
        timeUnitAmount.text = String(sender.value.shortDigitsIn(0))
        stepperValue = sender.value
    }
    
    // MARK: - Methods
    
    func addTarget(_ target: Any?, action: Selector) {
        stepper.addTarget(target, action: action, for: .valueChanged)
    }
}

extension TimeSpanWithStepperCell {
    
    // MARK: - View configuration
    
    func setupUI() {
        stepper.value = 0
        stepper.minimumValue = 0
        stepper.maximumValue = 99
        stepper.addTarget(self, action: #selector(updateTimeUnitAmount(_:)), for: .valueChanged)
        timeUnitAmount.text = "0"
        
        stepperStackView.axis = .horizontal
        stepperStackView.spacing = 24
        stepperStackView.addArrangedSubview(stepper)
        stepperStackView.addArrangedSubview(timeUnitAmount)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .horizontal
        parentStackView.addArrangedSubview(timeUnitTitle)
        parentStackView.addArrangedSubview(stepperStackView)
        
        contentView.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            parentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            parentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            parentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            timeUnitAmount.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
}

