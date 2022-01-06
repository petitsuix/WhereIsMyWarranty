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
    var startDatePicker = UIDatePicker()
    var startDateValue: String = ""
    
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
    var endDateValue: String = ""
    
    var nextStepButton = UIButton()
    
    var warranties: [Warranty] = []
    var viewModel: NewWarrantyViewModel?
    
    
    var endDateDefaultText = "Produit sous garantie jusqu'au :\n"
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        print("Category : \(category ?? "Missing")")
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
    
    @objc func updateStartDateValue() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        startDateValue = "\(startDatePicker.date)"
    }
    
    @objc func updateDays() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        guard let newDate = startDatePicker.calendar.date(byAdding: .day, value: Int(weeksView.stepper.value * 7), to: Date()) else { return }
        let newDateStringFormat = formatter1.string(from: newDate)
        endDateLabel.text = endDateDefaultText + newDateStringFormat
        // today = startDate.date
    }
    
    @objc func updateMonths() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        guard let newDate = startDatePicker.calendar.date(byAdding: .month, value: Int(monthsView.stepper.value), to: Date()) else { return }
        let newDateStringFormat = formatter1.string(from: newDate)
        endDateLabel.text = endDateDefaultText + newDateStringFormat
        // today = startDate.date
    }
    
    @objc func updateYears() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        guard let newDate = startDatePicker.calendar.date(byAdding: .year, value: Int(yearsView.stepper.value), to: Date()) else { return }
        let newDateStringFormat = formatter1.string(from: newDate)
        endDateLabel.text = endDateDefaultText + newDateStringFormat
        // today = startDate.date
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
        
        startDatePicker.datePickerMode = .date
        startDatePicker.addTarget(self, action: #selector(updateStartDateValue), for: .editingDidEnd)
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        
        startDateStackView.addArrangedSubview(startDateTitle)
        startDateStackView.addArrangedSubview(startDatePicker)
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
        yearsView.stepper.addTarget(self, action: #selector(updateYears), for: .touchUpInside)
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
