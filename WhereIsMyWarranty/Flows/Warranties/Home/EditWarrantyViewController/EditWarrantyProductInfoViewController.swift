//
//  EditWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import UIKit

class EditWarrantyProductInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: EditWarrantyViewModel?
    
    // MARK: - Private properties
    
    // 1
    private var parentStackView = UIStackView()
    
    // 1.1
    private let nameAndStartDateStackView = UIStackView()
    // 1.1.1
    private var nameStackView = UIStackView()
    private let nameTitle = UILabel()
    private var nameField = UITextField()
    // 1.1.2
    private let startDateStackView = UIStackView()
    private let startDateTitle = UILabel()
    private var datePicker = UIDatePicker()
    
    
    // 1.2
    private let customLengthStackView = UIStackView()
    private let validityLengthTitle = UILabel()
    // 1.2.1
    private let lifetimeWarrantyStackView = UIStackView()
    private let lifetimeWarrantyTitle = UILabel()
    private let lifetimeWarrantySwitch = UISwitch()
    private let yearsView = TextWithStepperView()
    private let monthsView = TextWithStepperView()
    private let weeksView = TextWithStepperView()
    
    // 1.3 endDate
    private let endDateLabel = UILabel()
    
    private var nextStepButton = UIButton()
    
    
    private var lifeTimeWarrantyDefaultText = "Produit garanti à vie !"
    private var updatedDate: Date?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if viewModel?.warranty.lifetimeWarranty == false {
            updateTimeIntervals()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - objc methods
    
    @objc func nameTextfieldDidChange(textfield: UITextField) { // comment le controller communique avec le viewmodel
        // FIXME: 
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
    
    @objc func updateWeeksWithStepper() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.day, value: (weeksView.didIncrementStepper ? 7 : -7))
        if let safeNewDate = updatedDate {
            endDateLabel.text = Strings.endDateDefaultText + formatter1.string(from: safeNewDate)
            updatedDate = safeNewDate
        }
    }
    
    @objc func updateMonthsWithStepper() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.month, value: (monthsView.didIncrementStepper ? 1 : -1))
        if let safeNewDate = updatedDate {
            endDateLabel.text = Strings.endDateDefaultText + formatter1.string(from: safeNewDate)
            updatedDate = safeNewDate
        }
    }
    
    @objc func updateYearsWithStepper() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.year, value: (yearsView.didIncrementStepper ? 1 : -1))
        if let safeNewDate = updatedDate {
            endDateLabel.text = Strings.endDateDefaultText + formatter1.string(from: safeNewDate)
            updatedDate = safeNewDate
        }
    }
    
    @objc func goToAddProductPhotoScreen() {
        nameDidChange()
        startDateDidChange() // Calling this method here, only at the end when moving to nextStep. Not in start datePicker's action "updateStartDateValue", because it may never be called if the user doesn't interract with start datePicker.
        endDateDidChange()
        viewModel?.goToEditProductPhotoScreen()
    }
    
    // MARK: - Private methods
    
    private func nameDidChange() {
        viewModel?.name = nameField.text
    }
    
    private func startDateDidChange() {
        viewModel?.startDate = datePicker.date
    }
    
    private func isLifetimeWarranty() {
        viewModel?.isLifetimeWarranty = (lifetimeWarrantySwitch.isOn ? true : false)
    }
    
    private func endDateDidChange() {
        viewModel?.endDate = updatedDate
    }
    
    private func updateWeeks() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        if let timeUnitAmount = weeksView.timeUnitAmount.text {
            if let timeUnitAmountAsInt = Int(timeUnitAmount) {
                updatedDate = updatedDate?.adding(.day, value: timeUnitAmountAsInt * 7)
            }
        }
        if let safeNewDate = updatedDate {
            endDateLabel.text = Strings.endDateDefaultText + formatter1.string(from: safeNewDate)
            updatedDate = safeNewDate
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
        if let safeNewDate = updatedDate {
            endDateLabel.text = Strings.endDateDefaultText + formatter1.string(from: safeNewDate)
            updatedDate = safeNewDate
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
        if let safeNewDate = updatedDate {
            endDateLabel.text = Strings.endDateDefaultText + formatter1.string(from: safeNewDate)
            updatedDate = safeNewDate
        }
    }
    
    private func updateDateAfterTurningSwitchOff() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        if let safeNewDate = updatedDate {
            if weeksView.timeUnitAmount.text == "0" && monthsView.timeUnitAmount.text == "0" && yearsView.timeUnitAmount.text == "0" {
                endDateLabel.text = Strings.endDateDefaultText
            } else {
                endDateLabel.text = Strings.endDateDefaultText + formatter1.string(from: safeNewDate)
            }
        }
    }
}

// MARK: - Extensions

extension EditWarrantyProductInfoViewController {
    
    func canGoToNextStep(canSave: Bool) { // pour checker que les champs soient pas vides ?
        nextStepButton.isEnabled = canSave
    }
}

extension EditWarrantyProductInfoViewController {
    
    func setupView() {
        view.backgroundColor = .white
        
        nameTitle.text = "Nom du produit"
        nameTitle.font = UIFont.boldSystemFont(ofSize: 30)
        nameTitle.textAlignment = .natural
        
        nameField.text = viewModel?.warranty.name
        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
        nameField.setBottomBorder()
        nameField.addDoneToolbar()
        
        nameStackView = UIStackView(arrangedSubviews: [nameTitle, nameField])
        nameStackView.axis = .vertical
        nameStackView.spacing = 16
        
        startDateTitle.text = "Date de début de garantie"
        startDateTitle.font = UIFont.boldSystemFont(ofSize: 16)
        startDateTitle.textAlignment = .left
        
        datePicker.datePickerMode = .date
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
        
        validityLengthTitle.text = "Durée de validité"
        validityLengthTitle.font = UIFont.boldSystemFont(ofSize: 16)
        
        monthsView.configureView()
        weeksView.configureView()
        yearsView.configureView()
        
        if let yearsStepperValue = viewModel?.getYearsStepperValue() {
            yearsView.stepperAmount = yearsStepperValue
            yearsView.timeUnitAmount.text = "\(Int(yearsStepperValue))"
        }
        yearsView.timeUnitTitle.text = "années"
        yearsView.addTarget(self, action: #selector(updateYearsWithStepper))
        
        if let monthsStepperValue = viewModel?.getMonthsStepperValue() {
            monthsView.stepperAmount = monthsStepperValue
            monthsView.timeUnitAmount.text = "\(Int(monthsStepperValue))"
        }
        monthsView.timeUnitTitle.text = "mois"
        monthsView.addTarget(self, action: #selector(updateMonthsWithStepper))
        
        if let weeksStepperValue = viewModel?.getWeeksStepperValue() {
            weeksView.stepperAmount = weeksStepperValue
            weeksView.timeUnitAmount.text = "\(Int(weeksStepperValue))"
        }
        weeksView.timeUnitTitle.text = "semaines"
        weeksView.addTarget(self, action: #selector(updateWeeksWithStepper))
        
        lifetimeWarrantyStackView.axis = .horizontal
        lifetimeWarrantyTitle.text = "garanti à vie"
        if viewModel?.warranty.lifetimeWarranty == true {
            lifetimeWarrantySwitch.setOn(true, animated: false)
            switchAction()
        }
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
        //  endDateLabel.text = Strings.endDateDefaultText
        endDateLabel.numberOfLines = 2
        
        // contentStackView
        parentStackView.axis = .vertical
        parentStackView.spacing = 56
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
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            endDateLabel.heightAnchor.constraint(equalToConstant: 60),
            
            nextStepButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextStepButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            nextStepButton.heightAnchor.constraint(equalToConstant: 55),
            nextStepButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}
