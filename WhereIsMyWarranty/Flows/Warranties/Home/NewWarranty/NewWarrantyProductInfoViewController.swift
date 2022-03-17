//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//
//swiftlint:disable file_length

import UIKit

class NewWarrantyProductInfoViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var viewModel: NewWarrantyViewModel?
    
    // MARK: - Private properties
    
    private let parentStackView = UIStackView()
    
    private let nameAndStartDateStackView = UIStackView()
    
    private var nameStackView = UIStackView()
    private let screenTitle = UILabel()
    private let nameField = UITextField()
    
    private let startDateStackView = UIStackView()
    private let startDateTitle = UILabel()
    private let datePicker = UIDatePicker()
    
    private let customLengthStackView = UIStackView()
    private let validityLengthTitle = UILabel()
    
    private let lifetimeWarrantyStackView = UIStackView()
    private let lifetimeWarrantyTitle = UILabel()
    private let lifetimeWarrantySwitch = UISwitch()
    private let yearsView = TextWithStepperView()
    private let monthsView = TextWithStepperView()
    private let weeksView = TextWithStepperView()
    
    private let endDateLabel = UILabel()
    private let endCurrentScreenButton = WarrantyModalNextStepButton()
    
    private var updatedDate: Date?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        canGoToNextStep(canSave: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - objc methods
    
    @objc func nameTextfieldDidChange(textfield: UITextField) {
        viewModel?.name = textfield.text
    }
    
    @objc func switchAction() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.yearsView.isHidden.toggle()
            self.monthsView.isHidden.toggle()
            self.weeksView.isHidden.toggle()
        }, completion: nil)
        if lifetimeWarrantySwitch.isOn {
            endDateLabel.text = Strings.lifetimeWarrantyDefaultText
        } else {
            updateDateAfterTurningSwitchOff()
        }
    }
    
    // In case the user changes the initial warranty start date in the date-picker, calling the 3 update methods below will ensure that the endDate is re-calculated according to the stepper values that he previously gave, if any.
    @objc func updateTimeIntervals() {
        updatedDate = datePicker.date
        if weeksView.timeUnitAmount.text != "0" {
            updateWeeks()
        }
        if monthsView.timeUnitAmount.text != "0" {
            updateMonths()
        }
        if yearsView.timeUnitAmount.text != "0" {
            updateYears()
        }
        if lifetimeWarrantySwitch.isOn {
            endDateLabel.text = Strings.lifetimeWarrantyDefaultText
        }
    }
    
    @objc func goToAddProductPhotoScreen() {
        viewModel?.startDate = datePicker.date
        viewModel?.isLifetimeWarranty = (lifetimeWarrantySwitch.isOn ? true : false)
        viewModel?.endDate = updatedDate
        viewModel?.goToAddProductPhotoScreen()
    }
    
    @objc func weeksStepperTapped() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        updatedDate = updatedDate?.adding(.day, value: (weeksView.didIncrementStepper ? 7 : -7))
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    @objc func monthsStepperTapped() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        updatedDate = updatedDate?.adding(.month, value: (monthsView.didIncrementStepper ? 1 : -1))
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    @objc func yearsStepperTapped() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        updatedDate = updatedDate?.adding(.year, value: (yearsView.didIncrementStepper ? 1 : -1))
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    // MARK: - Methods
    
    func canGoToNextStep(canSave: Bool) {
        if canSave {
            endCurrentScreenButton.isEnabled = true
            endCurrentScreenButton.alpha = 1
        } else {
            endCurrentScreenButton.isEnabled = false
            endCurrentScreenButton.alpha = 0.5
        }
    }
    
    // MARK: - Private methods
    
    private func updateWeeks() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let timeUnitAmount = weeksView.timeUnitAmount.text {
            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
                updatedDate = updatedDate?.adding(.day, value: timeUnitAmountAsInt * 7)
            }
        }
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    private func updateMonths() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let timeUnitAmount = monthsView.timeUnitAmount.text {
            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
                updatedDate = updatedDate?.adding(.month, value: timeUnitAmountAsInt)
            }
        }
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    private func updateYears() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let timeUnitAmount = yearsView.timeUnitAmount.text {
            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
                updatedDate = updatedDate?.adding(.year, value: timeUnitAmountAsInt)
            }
        }
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    private func updateDateAfterTurningSwitchOff() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if let updatedDate = updatedDate {
            if weeksView.timeUnitAmount.text == "0" && monthsView.timeUnitAmount.text == "0" && yearsView.timeUnitAmount.text == "0" {
                endDateLabel.text = Strings.productCoveredUntil
            } else {
                endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            }
        }
    }
}

extension NewWarrantyProductInfoViewController {
    
    // MARK: - View configuration
    
    private func setupView() {
        screenTitle.text = Strings.screenTitle
        screenTitle.font = MWFont.modalMainTitle
        screenTitle.textAlignment = .natural
        
        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
        nameField.autocorrectionType = .no
        nameField.placeholder = Strings.productNamePlaceHolder
        nameField.setBottomBorder()
        nameField.addDoneToolbar()
        nameField.becomeFirstResponder()
        
        nameStackView = UIStackView(arrangedSubviews: [screenTitle, nameField])
        nameStackView.axis = .vertical
        nameStackView.spacing = 12
        
        startDateTitle.text = Strings.warrantyStartDate
        startDateTitle.font = MWFont.modalSubtitles
        startDateTitle.textAlignment = .natural
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(updateTimeIntervals), for: .editingDidEnd)
        
        startDateStackView.axis = .vertical
        startDateStackView.alignment = .leading
        startDateStackView.spacing = 12
        startDateStackView.addArrangedSubview(startDateTitle)
        startDateStackView.addArrangedSubview(datePicker)
        
        nameAndStartDateStackView.axis = .vertical
        nameAndStartDateStackView.spacing = 40
        nameAndStartDateStackView.addArrangedSubview(nameStackView)
        nameAndStartDateStackView.addArrangedSubview(startDateStackView)
        
        validityLengthTitle.text = Strings.validityLength
        validityLengthTitle.font = MWFont.modalSubtitles
        
        lifetimeWarrantyTitle.text = Strings.lifetimeWarranty
        lifetimeWarrantySwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        
        lifetimeWarrantyStackView.axis = .horizontal
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantyTitle)
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantySwitch)
        
        monthsView.setup()
        weeksView.setup()
        yearsView.setup()
        
        yearsView.timeUnitTitle.text = Strings.years
        yearsView.stepper.addTarget(self, action: #selector(yearsStepperTapped), for: .valueChanged)
        
        monthsView.timeUnitTitle.text = Strings.months
        monthsView.stepper.addTarget(self, action: #selector(monthsStepperTapped), for: .valueChanged)
        
        weeksView.timeUnitTitle.text = Strings.weeks
        weeksView.stepper.addTarget(self, action: #selector(weeksStepperTapped), for: .valueChanged)
        
        customLengthStackView.axis = .vertical
        customLengthStackView.spacing = 16
        customLengthStackView.addArrangedSubview(validityLengthTitle)
        customLengthStackView.addArrangedSubview(lifetimeWarrantyStackView)
        customLengthStackView.addArrangedSubview(yearsView)
        customLengthStackView.addArrangedSubview(monthsView)
        customLengthStackView.addArrangedSubview(weeksView)
        
        endDateLabel.textAlignment = .center
        endDateLabel.text = Strings.productCoveredUntil
        endDateLabel.numberOfLines = 2
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 40
        parentStackView.addArrangedSubview(nameAndStartDateStackView)
        parentStackView.addArrangedSubview(customLengthStackView)
        parentStackView.addArrangedSubview(endDateLabel)
        
        endCurrentScreenButton.setup(title: Strings.nextStepButtonTitle)
        endCurrentScreenButton.addTarget(self, action: #selector(goToAddProductPhotoScreen), for: .touchUpInside)
        
        view.backgroundColor = MWColor.white
        view.addSubview(parentStackView)
        view.addSubview(endCurrentScreenButton)
        
        NSLayoutConstraint.activate([
            endDateLabel.heightAnchor.constraint(equalToConstant: 60),
            
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            parentStackView.bottomAnchor.constraint(lessThanOrEqualTo: endCurrentScreenButton.topAnchor, constant: -16),
            
            endCurrentScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endCurrentScreenButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            endCurrentScreenButton.heightAnchor.constraint(equalToConstant: 55),
            endCurrentScreenButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}
