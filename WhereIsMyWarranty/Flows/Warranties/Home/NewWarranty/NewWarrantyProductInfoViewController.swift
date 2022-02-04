//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//
//swiftlint:disable file_length

import UIKit

class NewWarrantyProductInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    // 1
    let parentStackView = UIStackView()
    
    // 1.1
    let nameAndStartDateStackView = UIStackView()
    // 1.1.1
    var nameStackView = UIStackView()
    let nameTitle = UILabel()
    let nameField = UITextField()
    // 1.1.2
    let startDateStackView = UIStackView()
    let startDateTitle = UILabel()
    let datePicker = UIDatePicker()
    
    // 1.2
    let customLengthStackView = UIStackView()
    let validityLengthTitle = UILabel()
    // 1.2.1
    let lifetimeWarrantyStackView = UIStackView()
    let lifetimeWarrantyTitle = UILabel()
    let lifetimeWarrantySwitch = UISwitch()
    let yearsView = TextWithStepperView()
    let monthsView = TextWithStepperView()
    let weeksView = TextWithStepperView()
    
    let endDateLabel = UILabel()
    let nextStepButton = UIButton()
    
    var updatedDate: Date?
    
    var viewModel: NewWarrantyViewModel?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
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
    
    // In case the user changes the initial warranty start date in the date-picker, calling those 3 methods below will ensure that the endDate is re-calculated according to the stepper values that he already gave, if any.
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
    
    @objc func updateWeeksWithStepper() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.day, value: (weeksView.didIncrementStepper ? 7 : -7))
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    @objc func updateMonthsWithStepper() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.month, value: (monthsView.didIncrementStepper ? 1 : -1))
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    @objc func updateYearsWithStepper() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.year, value: (yearsView.didIncrementStepper ? 1 : -1))
        if let updatedDate = updatedDate {
            endDateLabel.text = Strings.productCoveredUntil + formatter1.string(from: updatedDate)
            self.updatedDate = updatedDate
        }
    }
    
    // MARK: - Methods
    
    private func updateWeeks() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
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
    
    func canGoToNextStep(canSave: Bool) { // pour checker que les champs soient pas vides ?
        nextStepButton.isEnabled = canSave
    }
}

extension NewWarrantyProductInfoViewController {
    
    // MARK: - View configuration
    
    private func setupView() {
        view.backgroundColor = .white
        
        nameTitle.text = "Nom du produit"
        nameTitle.font = UIFont.boldSystemFont(ofSize: 29)
        nameTitle.textAlignment = .natural
        
        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
        nameField.setBottomBorder()
        nameField.addDoneToolbar()
        
        nameStackView = UIStackView(arrangedSubviews: [nameTitle, nameField])
        nameStackView.axis = .vertical
        nameStackView.spacing = 12
        
        startDateTitle.text = "Date de début de garantie"
        startDateTitle.font = UIFont.boldSystemFont(ofSize: 16)
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
        
        validityLengthTitle.text = "Durée de validité"
        validityLengthTitle.font = UIFont.boldSystemFont(ofSize: 16)
        
        monthsView.setup()
        weeksView.setup()
        yearsView.setup()
        
        yearsView.timeUnitTitle.text = "années"
        yearsView.stepper.addTarget(self, action: #selector(updateYearsWithStepper), for: .valueChanged)
        
        monthsView.timeUnitTitle.text = "mois"
        monthsView.stepper.addTarget(self, action: #selector(updateMonthsWithStepper), for: .valueChanged)
        
        weeksView.timeUnitTitle.text = "semaines"
        weeksView.stepper.addTarget(self, action: #selector(updateWeeksWithStepper), for: .valueChanged)
        
        lifetimeWarrantyStackView.axis = .horizontal
        lifetimeWarrantyTitle.text = "garanti à vie"
        lifetimeWarrantySwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantyTitle)
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantySwitch)
        
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
        
        // contentStackView
        parentStackView.axis = .vertical
        parentStackView.spacing = 40
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.addArrangedSubview(nameAndStartDateStackView)
        parentStackView.addArrangedSubview(customLengthStackView)
        parentStackView.addArrangedSubview(endDateLabel)
        
        //  parentStackView.setCustomSpacing(50, after: customLengthStackView)
        //  parentStackView.setCustomSpacing(40, after: endDateLabel)
        
        nextStepButton.backgroundColor = MWColor.paleOrange
        nextStepButton.roundingViewCorners(radius: 8)
        nextStepButton.setTitle("Suivant", for: .normal)
        nextStepButton.addTarget(self, action: #selector(goToAddProductPhotoScreen), for: .touchUpInside)
        nextStepButton.isUserInteractionEnabled = true
        nextStepButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(parentStackView)
        view.addSubview(nextStepButton)
        
        NSLayoutConstraint.activate([
            endDateLabel.heightAnchor.constraint(equalToConstant: 60),
            
            nextStepButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextStepButton.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            nextStepButton.heightAnchor.constraint(equalToConstant: 55),
            nextStepButton.widthAnchor.constraint(equalToConstant: 170),
            
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            parentStackView.bottomAnchor.constraint(lessThanOrEqualTo: nextStepButton.topAnchor, constant: -16)
        ])
    }
}
