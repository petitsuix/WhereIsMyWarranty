//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//

import UIKit

class NewWarrantyViewController: UIViewController {
    
    // MARK: - Properties
    
    let navBarAppearance = UINavigationBarAppearance()
    var category: String?
    
    // #1 Parent StackView
    var parentStackView = UIStackView()
    
    // #1.1 nameAndStartDateStackView
    let nameAndStartDateStackView = UIStackView()
    // #1.1.1 nameStackView
    let nameStackView = UIStackView()
    let nameTitle = UILabel()
    var nameField = UITextField()
    // #1.1.2 startDateStackView
    let startDateStackView = UIStackView()
    let startDateTitle = UILabel()
    var startDate = UIDatePicker()
    
    // #1.2 validityLengthStackView
    let customLengthStackView = UIStackView()
    let validityLengthTitle = UILabel()
    // #1.2.1 lifetimeWarrantyStackView
    let lifetimeWarrantyStackView = UIStackView()
    let lifetimeWarrantyTitle = UILabel()
    let lifetimeWarrantySwitch = UISwitch()
    
    // #1.2.2 yearsStackView
    let yearsView = TextWithStepperView()
    // #1.2.3 monthsStackView
    let monthsView = TextWithStepperView()
   // let monthsStackView = UIStackView()
    // #1.2.4 weeksStackView
    let weeksView = TextWithStepperView()
    // let weeksStackView = UIStackView()
    
    // #1.3 endDateStackView
    let endDate = UILabel()
    
    
 //   let textWithStepperView: TextWithStepperView
    var saveButton = UIButton()
    
    var warranties: [Warranty] = []
    var viewModel: NewWarrantyViewModel?
    var storageService = StorageService()
    
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Category : \(category ?? "Missing")")
    }
    
    // MARK: - Methods
    
    
    // MARK: - objc methods
    
    @objc func saveWarranty() {
        viewModel?.saveWarranty()
    }
    
    @objc func nameTextfieldDidChange(textfield: UITextField) { // comment le controller communique avec le viewmodel
        viewModel?.name = textfield.text
    }
}

extension NewWarrantyViewController { // comment le viewmodel communique avec le viewcontroller
    
    func canSaveStatusDidChange(canSave: Bool) { // pour checker que les champs soient pas vides ?
        saveButton.isEnabled = canSave
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
        
        configureSaveButton()
        view.addSubview(parentStackView)
        view.addSubview(saveButton)
        activateConstraints()
    }
    
    func configureParentStackView() {
        parentStackView.backgroundColor = .green
        parentStackView.distribution = .fillProportionally
        parentStackView.axis = .vertical
        parentStackView.spacing = 40
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        configureEndDate()
        parentStackView.addArrangedSubview(nameAndStartDateStackView)
        parentStackView.addArrangedSubview(customLengthStackView)
        parentStackView.addArrangedSubview(endDate)
    }
    
    func configureNameAndStartDateStackView() {
        nameAndStartDateStackView.axis = .vertical
      //  nameAndStartDateStackView.spacing = 40
        nameAndStartDateStackView.translatesAutoresizingMaskIntoConstraints = false
        nameAndStartDateStackView.addArrangedSubview(nameStackView)
        nameAndStartDateStackView.addArrangedSubview(startDateStackView)
    }
    
    func configureNameStackView() {
        nameStackView.axis = .vertical
        nameStackView.translatesAutoresizingMaskIntoConstraints = false
        nameTitle.text = "Titre"
        nameTitle.textAlignment = .left
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        nameField.addTarget(self, action: #selector(nameTextfieldDidChange), for: .editingChanged)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameStackView.addArrangedSubview(nameTitle)
        nameStackView.addArrangedSubview(nameField)
    }
    
    func configureStartDateStackView() {
        startDateStackView.axis = .vertical
        startDateStackView.alignment = .leading
        startDateStackView.translatesAutoresizingMaskIntoConstraints = false
        startDateTitle.text = "Date de début de garantie"
        startDateTitle.textAlignment = .left
        startDateTitle.translatesAutoresizingMaskIntoConstraints = false
        startDateStackView.backgroundColor = .yellow
        startDate.backgroundColor = .red
        startDate.translatesAutoresizingMaskIntoConstraints = false
        startDateStackView.addArrangedSubview(startDateTitle)
        startDateStackView.addArrangedSubview(startDate)
    }
    
    func configureCustomLengthStackView() {
        monthsView.configureView()
        weeksView.configureView()
        yearsView.configureView()
        
        customLengthStackView.axis = .vertical
        customLengthStackView.spacing = 16
        customLengthStackView.translatesAutoresizingMaskIntoConstraints = false
        
        validityLengthTitle.text = "Durée de validité"
        validityLengthTitle.backgroundColor = .blue
        validityLengthTitle.translatesAutoresizingMaskIntoConstraints = false
        
        yearsView.timeUnitTitle.text = "années"
        yearsView.translatesAutoresizingMaskIntoConstraints = false
        
        monthsView.timeUnitTitle.text = "mois"
        monthsView.translatesAutoresizingMaskIntoConstraints = false
        
        weeksView.timeUnitTitle.text = "semaines"
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
        lifetimeWarrantyTitle.text = "garantie à vie"
        lifetimeWarrantyTitle.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantySwitch.translatesAutoresizingMaskIntoConstraints = false
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantyTitle)
        lifetimeWarrantyStackView.addArrangedSubview(lifetimeWarrantySwitch)
    }
    
    func configureEndDate() {
        endDate.textAlignment = .center
        endDate.translatesAutoresizingMaskIntoConstraints = false
        endDate.text = "Produit sous garantie jusqu'au\n\(startDate)"
    }
    
    func configureSaveButton() {
        saveButton.backgroundColor = .orange
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
        saveButton.isUserInteractionEnabled = true
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            parentStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -24),
            
            yearsView.heightAnchor.constraint(equalTo: lifetimeWarrantyStackView.heightAnchor),
            monthsView.heightAnchor.constraint(equalTo: lifetimeWarrantyStackView.heightAnchor),
            weeksView.heightAnchor.constraint(equalTo: lifetimeWarrantyStackView.heightAnchor),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
