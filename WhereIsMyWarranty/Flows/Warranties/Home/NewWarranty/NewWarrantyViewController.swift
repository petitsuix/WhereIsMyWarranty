//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//

import UIKit

class NewWarrantyViewController: UIViewController {
    
    // MARK: - Properties
    
    var category: String?
    
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
    
   // var warranties: [Warranty] = []
    var viewModel: NewWarrantyViewModel?
    
    
    var endDateDefaultText = "Produit sous garantie jusqu'au :\n"
    var newDate: Date?
    var endDateCalendar: Calendar?
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        endDateCalendar = datePicker.calendar
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Methods
    
    
    // MARK: - objc methods
    
    @objc func nextStep() {
        viewModel?.nextStep()
        print("going through 'nextStep objc method in NewWarrantyViewController'")
    }
    
    @objc func nameTextfieldDidChange(textfield: UITextField) { // comment le controller communique avec le viewmodel
        viewModel?.name = textfield.text
    }
    
    // Si on veut recalculer a partir d'une nouvelle date du picker sans que ça remette à zéro les steppers. Et donc se baser sur la nouvelle date du picker avec les memes valeurs de steppers.
  /*  @objc func updateStartDateValue() {
        startDateCalendar = datePicker.calendar
        updateDays()
        updateMonths()
        updateYears()
    } */
    
    @objc func updateStartDateValue() {
        weeksView.stepper.value = 0
        weeksView.timeUnitAmount.text = "0"
        monthsView.stepper.value = 0
        monthsView.timeUnitAmount.text = "0"
        yearsView.stepper.value = 0
        yearsView.timeUnitAmount.text = "0"
        endDateLabel.text = endDateDefaultText
        endDateCalendar = datePicker.calendar
    }
    
    @objc func updateDays() {
        if newDate == nil {
             newDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        newDate = newDate?.adding(.day, value: Int(weeksView.stepper.value * 7))
        // newDate = endDateCalendar?.date(byAdding: .day, value: Int(weeksView.stepper.value * 7), to: datePicker.date)
        guard let safeNewDate = newDate else { return }
        
        endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        newDate = safeNewDate
    }
    
    @objc func updateMonths() {
        if newDate == nil {
             newDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        
        newDate = newDate?.adding(.month, value: Int(monthsView.stepper.value))
        guard let safeNewDate = newDate else { return }
        
        endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        newDate = safeNewDate
    }
    
    var didIncrement: Bool {
        didSet {
    }
    @objc func updateYears() {
        if newDate == nil {
             newDate = datePicker.date
        }
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        
        let value = yearsView.stepper.value
        
        newDate = newDate?.adding(.year, value: Int(yearsView.stepper.value))
        guard let safeNewDate = newDate else { return }
        
        endDateLabel.text = endDateDefaultText + formatter1.string(from: safeNewDate)
        newDate = safeNewDate
    }
}

extension NewWarrantyViewController {
    
    func canGoToNextStep(canSave: Bool) { // pour checker que les champs soient pas vides ?
        nextStepButton.isEnabled = canSave
    }
    
}

// MARK: - View configuration

extension NewWarrantyViewController {
    
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
        yearsView.stepper.addTarget(self, action: #selector(stepperChanged), for: .valueChanged)
        yearsView.translatesAutoresizingMaskIntoConstraints = false
        
        monthsView.timeUnitTitle.text = "mois"
        monthsView.stepper.addTarget(self, action: #selector(updateMonths), for: .touchUpInside)
        monthsView.translatesAutoresizingMaskIntoConstraints = false
        
        weeksView.timeUnitTitle.text = "semaines"
        weeksView.stepper.addTarget(self, action: #selector(updateDays), for: .touchUpInside)
        weeksView.translatesAutoresizingMaskIntoConstraints = false
        
        configureLifetimeWarrantyStackView()
        
        customLengthStackView.addArrangedSubview(validityLengthTitle)
        customLengthStackView.addArrangedSubview(lifetimeWarrantyStackView)
        customLengthStackView.addArrangedSubview(yearsView)
        customLengthStackView.addArrangedSubview(monthsView)
        customLengthStackView.addArrangedSubview(weeksView)
    }
    
    @objc
    func stepperChanged(_ stepper: UIStepper) {
        print(stepper.value)
    }
    
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

extension Date {
    var calendar: Calendar {
        Calendar.current
    }
    
    func adding(_ component: Calendar.Component, value: Int) -> Date? {
        return calendar.date(byAdding: component, value: value, to: self)
    }
}
