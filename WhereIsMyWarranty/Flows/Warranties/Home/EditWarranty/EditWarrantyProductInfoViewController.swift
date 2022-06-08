//
//  EditWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//
//swiftlint:disable file_length

import UIKit

class EditWarrantyProductInfoViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var viewModel: EditWarrantyViewModel?
    
    // MARK: - Private properties
    
    private var parentStackView = UIStackView()
    
    private let nameAndStartDateStackView = UIStackView()

    private var nameStackView = UIStackView()
    private let screenTitle = UILabel()
    private var nameField = UITextField()

    private let startDateStackView = UIStackView()
    private let startDateTitle = UILabel()
    private var datePicker = UIDatePicker()
    
    private let customLengthStackView = UIStackView()
    private let validityLengthTitle = UILabel()

    private let lifetimeWarrantyStackView = UIStackView()
    private let lifetimeWarrantyTitle = UILabel()
    private let lifetimeWarrantySwitch = UISwitch()
    private let yearsView = TextWithStepperView()
    private let monthsView = TextWithStepperView()
    private let weeksView = TextWithStepperView()
    
    private let endDateLabel = UILabel()
    private var endCurrentScreenButton = ActionButton()

    private var updatedDate: Date?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        if viewModel?.warranty.lifetimeWarranty == false {
            updateTimeIntervals()
        }
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
    
    @objc func startDateDidChange(datePicker: UIDatePicker) {
        viewModel?.startDate = datePicker.date
    }
    
    // In case the user changes the initial warranty start date in the date-picker, calling those 3 methods above will ensure that the endDate is re-calculated according to the stepper values that he already gave, if any.
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
    
    @objc func goToAddProductPhotoScreen() {
        viewModel?.name = nameField.text
        viewModel?.startDate = datePicker.date
        viewModel?.isLifetimeWarranty = (lifetimeWarrantySwitch.isOn ? true : false)
        viewModel?.endDate = updatedDate
        viewModel?.goToEditProductPhotoScreen()
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
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if weeksView.timeUnitAmount.text == "0" && monthsView.timeUnitAmount.text == "0" && yearsView.timeUnitAmount.text == "0" {
            endDateLabel.text = Strings.productCoveredUntil
        } else {
            updateTimeIntervals()
        }
    }
}

extension EditWarrantyProductInfoViewController {
    
    // MARK: - View configuration
    
    private func setupView() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deletionAlert))
        
        screenTitle.text = Strings.screenTitle
        screenTitle.font = MWFont.modalMainTitle
        screenTitle.textAlignment = .natural
        
        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
        nameField.autocorrectionType = .no
        nameField.setBottomBorder()
        nameField.addDoneToolbar()
        
        nameStackView = UIStackView(arrangedSubviews: [screenTitle, nameField])
        nameStackView.axis = .vertical
        nameStackView.spacing = 16
        
        startDateTitle.text = Strings.warrantyStartDate
        startDateTitle.font = MWFont.modalSubtitles
        startDateTitle.textAlignment = .left
        
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: Strings.localeIdentifier)
        datePicker.addTarget(self, action: #selector(updateTimeIntervals), for: .editingDidEnd)
        
        startDateStackView.axis = .vertical
        startDateStackView.alignment = .leading
        startDateStackView.spacing = 16
        startDateStackView.addArrangedSubview(startDateTitle)
        startDateStackView.addArrangedSubview(datePicker)
        
        nameAndStartDateStackView.axis = .vertical
        nameAndStartDateStackView.spacing = 56
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
        yearsView.addTarget(self, action: #selector(yearsStepperTapped))
        
        monthsView.timeUnitTitle.text = Strings.months
        monthsView.addTarget(self, action: #selector(monthsStepperTapped))
        
        weeksView.timeUnitTitle.text = Strings.weeks
        weeksView.addTarget(self, action: #selector(weeksStepperTapped))
        
        customLengthStackView.axis = .vertical
        customLengthStackView.spacing = 16
        customLengthStackView.addArrangedSubview(validityLengthTitle)
        customLengthStackView.addArrangedSubview(lifetimeWarrantyStackView)
        customLengthStackView.addArrangedSubview(yearsView)
        customLengthStackView.addArrangedSubview(monthsView)
        customLengthStackView.addArrangedSubview(weeksView)
        
        endDateLabel.textAlignment = .center
        endDateLabel.numberOfLines = 2
        
        parentStackView.axis = .vertical
        parentStackView.spacing = 40
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.addArrangedSubview(nameAndStartDateStackView)
        parentStackView.addArrangedSubview(customLengthStackView)
        parentStackView.addArrangedSubview(endDateLabel)

        endCurrentScreenButton.setup(title: Strings.nextStepButtonTitle)
        endCurrentScreenButton.addTarget(self, action: #selector(goToAddProductPhotoScreen), for: .touchUpInside)
        
        view.backgroundColor = MWColor.systemBackground
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
    
    private func setupData() {
        nameField.text = viewModel?.warranty.name
        if let startDate = viewModel?.warranty.warrantyStart {
            datePicker.date = startDate
        }
        if let yearsStepperValue = viewModel?.calculateNumberOfYears() {
            yearsView.stepperAmount = yearsStepperValue
            yearsView.timeUnitAmount.text = "\(Int(yearsStepperValue))"
        }
        if let monthsStepperValue = viewModel?.calculateNumberOfMonths() {
            monthsView.stepperAmount = monthsStepperValue
            monthsView.timeUnitAmount.text = "\(Int(monthsStepperValue))"
        }
        if let weeksStepperValue = viewModel?.calculateNumberOfWeeks() {
            weeksView.stepperAmount = weeksStepperValue
            weeksView.timeUnitAmount.text = "\(Int(weeksStepperValue))"
        }
        if viewModel?.warranty.lifetimeWarranty == true {
            lifetimeWarrantySwitch.setOn(true, animated: false)
            switchAction()
        }
    }
}
