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
    let yearsStackView = UIStackView()
    let yearsTitle = UILabel()
   // let minusButton = //MinusButton
    
    // #1.2.3 monthsStackView
    let monthsStackView = UIStackView()
    // #1.2.4 weeksStackView
    let weeksStackView = UIStackView()
    
    // #1.3 endDateStackView
    let endDateStackView = UIStackView()
    
    
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
        guard nameField.text != "" else { return alert("le champ est vide", "remplir le champ nom") }
        guard let name = nameField.text else { return print("warrantyNameField has no value") }
        var date = Date()
        date = startDate.date
        // guard let date = warrantyStartDatePicker.date else { return print("warrantyStartDatePicker has no value") }
        let warrantyTest = Warranty(name: name, warrantyStart: date, warrantyEnd: nil, lifetimeWarranty: false, invoicePhoto: nil, price: nil, paymentMethod: nil, model: nil, serialNumber: nil, currency: nil, productPhoto: nil, sellersName: nil, sellersLocation: nil, sellersWebsite: nil, sellersContact: nil, category: nil)
        warranties.append(warrantyTest)
        do {
            try storageService.saveWarranty(warrantyTest)
        }
        catch {
            print(error)
        }
        viewModel?.goBack()
    }
}

// MARK: - View configuration

extension NewWarrantyViewController {
    
    func setupView() {
        view.backgroundColor = .white
        configureNavigationBar()
        parentStackView.backgroundColor = .green
        parentStackView.axis = .vertical
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.alignment = .leading
       // parentStackView.distribution = .fillEqually
        
        nameTitle.text = "Titre"
        nameTitle.textAlignment = .center
        nameTitle.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.backgroundColor = .lightGray
        
        startDateTitle.text = "Date de début de garantie"
        startDateTitle.textAlignment = .center
        startDateTitle.translatesAutoresizingMaskIntoConstraints = false
        
        startDate.backgroundColor = .lightGray
        startDate.translatesAutoresizingMaskIntoConstraints = false
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .orange
        saveButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
        saveButton.isUserInteractionEnabled = true
        
        view.addSubview(parentStackView)
        parentStackView.addArrangedSubview(nameTitle)
        parentStackView.addArrangedSubview(nameField)
        parentStackView.addArrangedSubview(startDateTitle)
        parentStackView.addArrangedSubview(startDate)
        view.addSubview(saveButton)
        activateConstraints()
    }
    
    func configureNavigationBar() {
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            // parentStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -8),
            
//            warrantyNameField.heightAnchor.constraint(equalTo: warrantyStartDatePicker.widthAnchor),
            nameField.widthAnchor.constraint(equalTo: startDate.widthAnchor),
//            warrantyStartDatePicker.centerXAnchor.constraint(equalTo: parentStackView.centerXAnchor),
//            warrantyStartDatePicker.widthAnchor.constraint(equalTo: warrantyNameField.widthAnchor),
//
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
