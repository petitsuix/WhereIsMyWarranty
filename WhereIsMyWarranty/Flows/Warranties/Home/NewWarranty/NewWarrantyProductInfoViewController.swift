//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//

import UIKit

class NewWarrantyProductInfoViewController: UIViewController {
    
    // MARK: - Properties
    
    // 1
    var parentStackView = UIStackView()
    
    // 1.1
    let nameAndStartDateStackView = UIStackView()
    // 1.1.1
    var nameStackView = UIStackView()
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
    
    
    let endDateLabel = UILabel()
    var nextStepButton = UIButton()
    
    var endDateDefaultText = "Produit sous garantie jusqu'au :\n"
    var updatedDate: Date?
    
    var viewModel: NewWarrantyViewModel?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewNEw()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Methods
    
    func startDateDidChange() {
        viewModel?.startDate = datePicker.date
    }
    
    func endDateDidChange() {
        viewModel?.endDate = updatedDate
    }
    
    // Stepper values need to be saved, so when the user subsequently modifies one of his warranties, the EditWarrantyProductInfoViewController will be able to perform new date calculations with the right values.
    func stepperValuesDidChange() {
        viewModel?.yearsStepperValue = Int(yearsView.stepper.value)
        viewModel?.monthsStepperValue = Int(monthsView.stepper.value)
        viewModel?.weeksStepperValue = Int(weeksView.stepper.value)
    }
    
    // MARK: - objc methods
    
    @objc func nameTextfieldDidChange(textfield: UITextField) {
        viewModel?.name = textfield.text
    }
    
    // In case the user changes the initial warranty start date in the date-picker, calling those 3 methods below will ensure that the endDate is re-calculated according to the stepper values that he already gave, if any.
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
    
    @objc func updateDays() {
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

extension NewWarrantyProductInfoViewController {
    
    func canGoToNextStep(canSave: Bool) { // pour checker que les champs soient pas vides ?
        nextStepButton.isEnabled = canSave
    }
}

// MARK: - View configuration

extension NewWarrantyProductInfoViewController {
    
    
    func setupViewNEw() {
        view.backgroundColor = .white
        
        
        
        nameTitle.text = "Nom du produit"
        nameTitle.font = UIFont.boldSystemFont(ofSize: 30)
        nameTitle.textAlignment = .natural
       
        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
        nameField.setBottomBorder()
        nameField.addDoneToolbar()
       
        nameStackView = UIStackView(arrangedSubviews: [nameTitle, nameField])
        nameStackView.axis = .vertical
        nameStackView.spacing = 16
        
        startDateTitle.text = "Date de début de garantie"
        startDateTitle.font = UIFont.boldSystemFont(ofSize: 16)
        startDateTitle.textAlignment = .left
        startDateTitle.translatesAutoresizingMaskIntoConstraints = false
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(updateStartDateValue), for: .editingDidEnd)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        startDateStackView.axis = .vertical
        startDateStackView.alignment = .leading
        startDateStackView.spacing = 16
        startDateStackView.translatesAutoresizingMaskIntoConstraints = false
        startDateStackView.addArrangedSubview(startDateTitle)
        startDateStackView.addArrangedSubview(datePicker)
        
        nameAndStartDateStackView.axis = .vertical
        nameAndStartDateStackView.spacing = 56
        nameAndStartDateStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndStartDateStackView.addArrangedSubview(nameStackView)
        nameAndStartDateStackView.addArrangedSubview(startDateStackView)
       
        
        
        
        validityLengthTitle.text = "Durée de validité"
        validityLengthTitle.font = UIFont.boldSystemFont(ofSize: 16)
        validityLengthTitle.translatesAutoresizingMaskIntoConstraints = false
        
        monthsView.configureView()
        weeksView.configureView()
        yearsView.configureView()
        
        yearsView.timeUnitTitle.text = "années"
        yearsView.stepper.addTarget(self, action: #selector(updateYears), for: .valueChanged)
        yearsView.translatesAutoresizingMaskIntoConstraints = false
        
        monthsView.timeUnitTitle.text = "mois"
        monthsView.stepper.addTarget(self, action: #selector(updateMonths), for: .valueChanged)
        monthsView.translatesAutoresizingMaskIntoConstraints = false
        
        weeksView.timeUnitTitle.text = "semaines"
        weeksView.stepper.addTarget(self, action: #selector(updateDays), for: .valueChanged)
        weeksView.translatesAutoresizingMaskIntoConstraints = false
        
        lifetimeWarrantyStackView.axis = .horizontal
        //lifetimeWarrantyStackView.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantyTitle.text = "garanti à vie"
        lifetimeWarrantyTitle.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantySwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        lifetimeWarrantyStackView.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantyTitle)
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantySwitch)
        
        customLengthStackView.axis = .vertical
        customLengthStackView.spacing = 16
        customLengthStackView.translatesAutoresizingMaskIntoConstraints = false
        customLengthStackView.addArrangedSubview(validityLengthTitle)
        customLengthStackView.addArrangedSubview(lifetimeWarrantyStackView)
        customLengthStackView.addArrangedSubview(yearsView)
        customLengthStackView.addArrangedSubview(monthsView)
        customLengthStackView.addArrangedSubview(weeksView)
        
        endDateLabel.textAlignment = .center
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.text = endDateDefaultText
        endDateLabel.numberOfLines = 2
        
        nextStepButton.backgroundColor = MWColor.paleOrange
        nextStepButton.roundingViewCorners(radius: 8)
        nextStepButton.setTitle("Suivant", for: .normal)
        nextStepButton.addTarget(self, action: #selector(nextStep), for: .touchUpInside)
        nextStepButton.isUserInteractionEnabled = true
        nextStepButton.translatesAutoresizingMaskIntoConstraints = false
        
        // contentStackView
        parentStackView.axis = .vertical
        parentStackView.spacing = 56
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.addArrangedSubview(nameAndStartDateStackView)
        parentStackView.addArrangedSubview(customLengthStackView)
        parentStackView.addArrangedSubview(endDateLabel)
      //  parentStackView.setCustomSpacing(50, after: customLengthStackView)
      //  parentStackView.setCustomSpacing(40, after: endDateLabel)
        
        view.addSubview(parentStackView)
        view.addSubview(nextStepButton)
        //view.addSubview(nextStepButton)
        
       
        
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
    
    func setupView() {
        view.backgroundColor = .white
        configureNameAndStartDateStackView()
        configureNameStackView()
        configureStartDateStackView()
        configureCustomLengthStackView()
        configureNextStepButton()
        
        configureParentStackView()
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
        
        yearsView.timeUnitTitle.text = "années"
        yearsView.stepper.addTarget(self, action: #selector(updateYears), for: .valueChanged)
        yearsView.translatesAutoresizingMaskIntoConstraints = false
        
        monthsView.timeUnitTitle.text = "mois"
        monthsView.stepper.addTarget(self, action: #selector(updateMonths), for: .valueChanged)
        monthsView.translatesAutoresizingMaskIntoConstraints = false
        
        weeksView.timeUnitTitle.text = "semaines"
        weeksView.stepper.addTarget(self, action: #selector(updateDays), for: .valueChanged)
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
        //lifetimeWarrantyStackView.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantyTitle.text = "garanti à vie"
        lifetimeWarrantyTitle.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantySwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        lifetimeWarrantyStackView.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantyTitle)
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantySwitch)
    }
    
    @objc func switchAction() {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.yearsView.isHidden.toggle()
                self.monthsView.isHidden.toggle()
                self.weeksView.isHidden.toggle()
            }, completion: nil)
    }
    
//    @objc func switchAction() {
//        if lifetimeWarrantySwitch.isOn {
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//                self.yearsView.alpha = 0
//                self.monthsView.alpha = 0
//                self.weeksView.alpha = 0
//            }, completion: nil)
//        } else {
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
//                self.yearsView.alpha = 1
//                self.monthsView.alpha = 1
//                self.weeksView.alpha = 1
//            }, completion: nil)
//        }
//    }
    
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
