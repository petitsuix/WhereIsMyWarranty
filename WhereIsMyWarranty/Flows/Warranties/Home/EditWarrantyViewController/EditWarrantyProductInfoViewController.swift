//
//  EditWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import UIKit

class EditWarrantyProductInfoViewController: UIViewController {

    // MARK: - Properties
    
    // 1
    var parentStackView = UIStackView()
    
    // 1.1
    let nameAndStartDateStackView = UIStackView()
    // 1.1.1
    let nameStackView = UIStackView()
    let nameTitle = UILabel()
    var nameField = UITextField()
    // 1.1.2
    let startDateStackView = UIStackView()
    let startDateTitle = UILabel()
    var datePicker = UIDatePicker()
    
    
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
    
    // 1.3 endDate
    let endDateLabel = UILabel()
    
    var nextStepButton = UIButton()
    
    var viewModel: EditWarrantyViewModel?
    
    
    var endDateDefaultText = "Produit sous garantie jusqu'au :\n"
    var updatedDate: Date?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateStartDateValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Methods
    
    func nameDidChange() {
        viewModel?.name = nameField.text
    }
    
    func startDateDidChange() {
        viewModel?.startDate = datePicker.date
    }
    
    func endDateDidChange() {
        viewModel?.endDate = updatedDate
    }
    
    func stepperValuesDidChange() {
        viewModel?.yearsStepperValue = Int(yearsView.stepper.value)
        viewModel?.monthsStepperValue = Int(monthsView.stepper.value)
        viewModel?.weeksStepperValue = Int(weeksView.stepper.value)
    }
    
    // MARK: - objc methods
    
    @objc func nameTextfieldDidChange(textfield: UITextField) { // comment le controller communique avec le viewmodel
        viewModel?.name = textfield.text
    }
    
    // In case the user changes the initial warranty start date in the date-picker, calling those 3 methods above will ensure that the endDate is re-calculated according to the stepper values that he already gave, if any.
    @objc func updateStartDateValue() {
        updatedDate = datePicker.date
        if weeksView.timeUnitAmount.text != "0" {
            updateDaysAfterDatePickerChanged()
        }
        if monthsView.timeUnitAmount.text != "0" {
            updateMonthsAfterDatePickerChanged()
        }
        if yearsView.timeUnitAmount.text != "0" {
            updateYearsAfterDatePickerChanged()
        }
    }
    
    @objc func nextStep() {
//        nameDidChange()
        startDateDidChange() // Calling this method here, only at the end when moving to nextStep. Not in start datePicker's action "updateStartDateValue", because it may never be called if the user doesn't interract with start datePicker.
        stepperValuesDidChange()
        endDateDidChange()
        viewModel?.nextStep()
    }
    
    
    
    
    
    //    @objc func updateStartDateValue() {
    //        weeksView.stepper.value = 0
    //        weeksView.timeUnitAmount.text = "0"
    //        monthsView.stepper.value = 0
    //        monthsView.timeUnitAmount.text = "0"
    //        yearsView.stepper.value = 0
    //        yearsView.timeUnitAmount.text = "0"
    //        endDateLabel.text = endDateDefaultText
    //        startDateCalendar = datePicker.calendar
    //    }
    
    @objc func updateWeeks() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.day, value: (weeksView.didIncrementStepper ? 7 : -7))
        guard let safeNewDate = updatedDate else { return }
        endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        updatedDate = safeNewDate
    }
    
    @objc func updateMonths() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.month, value: (monthsView.didIncrementStepper ? 1 : -1))
        guard let safeNewDate = updatedDate else { return }
        endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        updatedDate = safeNewDate
    }
    
    @objc func updateYears() {
        if updatedDate == nil {
            updatedDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        updatedDate = updatedDate?.adding(.year, value: (yearsView.didIncrementStepper ? 1 : -1))
        guard let safeNewDate = updatedDate else { return }
        endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        updatedDate = safeNewDate
    }
    
    // MARK: - Methods
    
    func updateDaysAfterDatePickerChanged() {
       let formatter1 = DateFormatter()
       formatter1.dateStyle = .full
        guard let timeUnitAmount = weeksView.timeUnitAmount.text else { return }
        guard let timeUnitAmountAsInt = Int(timeUnitAmount) else { return }
        updatedDate = updatedDate?.adding(.day, value: timeUnitAmountAsInt * 7)
       // newDate = endDateCalendar?.date(byAdding: .day, value: Int(weeksView.stepper.value * 7), to: datePicker.date)
       guard let safeNewDate = updatedDate else { return }
       endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        updatedDate = safeNewDate
   }
    
    func updateMonthsAfterDatePickerChanged() {
       let formatter1 = DateFormatter()
       formatter1.dateStyle = .full
        guard let timeUnitAmount = monthsView.timeUnitAmount.text else { return }
        guard let timeUnitAmountAsInt = Int(timeUnitAmount) else { return }
        updatedDate = updatedDate?.adding(.month, value: timeUnitAmountAsInt)
       guard let safeNewDate = updatedDate else { return }
       endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        updatedDate = safeNewDate
   }
    
    func updateYearsAfterDatePickerChanged() {
       let formatter1 = DateFormatter()
       formatter1.dateStyle = .full
        guard let timeUnitAmount = yearsView.timeUnitAmount.text else { return }
        guard let timeUnitAmountAsInt = Int(timeUnitAmount) else { return }
        updatedDate = updatedDate?.adding(.year, value: timeUnitAmountAsInt)
       guard let safeNewDate = updatedDate else { return }
       endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        updatedDate = safeNewDate
   }
}

extension EditWarrantyProductInfoViewController {
    
    func canGoToNextStep(canSave: Bool) { // pour checker que les champs soient pas vides ?
        nextStepButton.isEnabled = canSave
    }
}

// MARK: - View configuration

extension EditWarrantyProductInfoViewController {
    
    func setupView() {
        view.backgroundColor = .white
        configureParentStackView()
        configureNameAndStartDateStackView()
        configureNameStackView()
        configureStartDateStackView()
        configureCustomLengthStackView()
        configureNextStepButton()
        view.addSubview(parentStackView)
        view.addSubview(nextStepButton)
        activateConstraints()
    }
    
    func configureParentStackView() {
        parentStackView.axis = .vertical
        parentStackView.spacing = 56
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        configureEndDate()
        parentStackView.addArrangedSubview(nameAndStartDateStackView)
        parentStackView.addArrangedSubview(customLengthStackView)
        parentStackView.addArrangedSubview(endDateLabel)
    }
    
    func configureNameAndStartDateStackView() {
        nameAndStartDateStackView.axis = .vertical
        nameAndStartDateStackView.spacing = 56
        nameAndStartDateStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndStartDateStackView.addArrangedSubview(nameStackView)
        nameAndStartDateStackView.addArrangedSubview(startDateStackView)
    }
    
    func configureNameStackView() {
        nameStackView.axis = .vertical
        nameStackView.spacing = 16
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        
        nameTitle.text = "Nom du produit"
        nameTitle.font = UIFont.boldSystemFont(ofSize: 30)
        nameTitle.textAlignment = .left
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.text = viewModel?.warranty.name
        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
        nameField.setBottomBorder()
        nameField.addDoneToolbar()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.addArrangedSubview(nameTitle)
        nameStackView.addArrangedSubview(nameField)
    }
    
    func configureStartDateStackView() {
        startDateStackView.axis = .vertical
        startDateStackView.alignment = .leading
        startDateStackView.spacing = 16
        startDateStackView.translatesAutoresizingMaskIntoConstraints = false
        startDateTitle.text = "Date de début de garantie"
        startDateTitle.font = UIFont.boldSystemFont(ofSize: 16)
        startDateTitle.textAlignment = .left
        startDateTitle.translatesAutoresizingMaskIntoConstraints = false
        
        guard let warrantyStart = viewModel?.warranty.warrantyStart else { return }
        datePicker.date = warrantyStart
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(updateStartDateValue), for: .editingDidEnd)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        startDateStackView.addArrangedSubview(startDateTitle)
        startDateStackView.addArrangedSubview(datePicker)
    }
    
    func configureCustomLengthStackView() {
        monthsView.configureView()
        weeksView.configureView()
        yearsView.configureView()
        
        customLengthStackView.axis = .vertical
        customLengthStackView.spacing = 16
        customLengthStackView.translatesAutoresizingMaskIntoConstraints = false
        
        validityLengthTitle.text = "Durée de validité"
        validityLengthTitle.font = UIFont.boldSystemFont(ofSize: 16)
        validityLengthTitle.translatesAutoresizingMaskIntoConstraints = false
        
        guard let yearsStepperValue = viewModel?.getYearsStepperValue() else { return }
        yearsView.timeUnitTitle.text = "années"
        yearsView.stepperAmount = yearsStepperValue
        yearsView.timeUnitAmount.text = "\(Int(yearsStepperValue))"
        yearsView.addTarget(self, action: #selector(updateYears))
        yearsView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let monthsStepperValue = viewModel?.getMonthsStepperValue() else { return }
        monthsView.timeUnitTitle.text = "mois"
        monthsView.stepperAmount = monthsStepperValue
        monthsView.timeUnitAmount.text = "\(Int(monthsStepperValue))"
        monthsView.addTarget(self, action: #selector(updateMonths))
        monthsView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let weeksStepperValue = viewModel?.getWeeksStepperValue() else { return }
        weeksView.timeUnitTitle.text = "semaines"
        weeksView.stepperAmount = weeksStepperValue
        weeksView.timeUnitAmount.text = "\(Int(weeksStepperValue))"
        weeksView.addTarget(self, action: #selector(updateWeeks))
        weeksView.translatesAutoresizingMaskIntoConstraints = false
        
        configureLifetimeWarrantyStackView()
        
        customLengthStackView.addArrangedSubview(validityLengthTitle)
        customLengthStackView.addArrangedSubview(lifetimeWarrantyStackView)
        customLengthStackView.addArrangedSubview(yearsView)
        customLengthStackView.addArrangedSubview(monthsView)
        customLengthStackView.addArrangedSubview(weeksView)
    }
    
    //    @objc func stepperChanged(_ stepper: UIStepper) {
    //        print(stepper.value)
    //    }
    
    func configureLifetimeWarrantyStackView() {
        lifetimeWarrantyStackView.axis = .horizontal
        lifetimeWarrantyStackView.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantyTitle.text = "garanti à vie"
        lifetimeWarrantyTitle.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantySwitch.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantyTitle)
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantySwitch)
    }
    
    func configureEndDate() {
        endDateLabel.textAlignment = .center
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.text = endDateDefaultText
        endDateLabel.numberOfLines = 2
    }
    
    func configureNextStepButton() {
        nextStepButton.backgroundColor = MWColor.paleOrange
        nextStepButton.roundingViewCorners(radius: 8)
        nextStepButton.setTitle("Suivant", for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        nextStepButton.isUserInteractionEnabled = true
        nextStepButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            //    parentStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -24),
            
            yearsView.heightAnchor.constraint(equalTo: lifetimeWarrantyStackView.heightAnchor),
            monthsView.heightAnchor.constraint(equalTo: lifetimeWarrantyStackView.heightAnchor),
            weeksView.heightAnchor.constraint(equalTo: lifetimeWarrantyStackView.heightAnchor),
            
            endDateLabel.heightAnchor.constraint(equalToConstant: 60),
            
            nextStepButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextStepButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            nextStepButton.heightAnchor.constraint(equalToConstant: 55),
            nextStepButton.widthAnchor.constraint(equalToConstant: 170)
        ])
    }
}
