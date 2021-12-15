//
//  NewWarrantyViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 07/12/2021.
//

import UIKit

class NewWarrantyViewController: UIViewController {
    
    let navBarAppearance = UINavigationBarAppearance()
    
    var category: String?
    var warranties: [Warranty] = []
    var storageService = StorageService()
    var warrantyNameLabel = UILabel()
    var warrantyNameField = UITextField()
    var viewModel: NewWarrantyViewModel?
    var saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        configureNavigationBar()
        warrantyNameLabel.text = "Titre"
        warrantyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        warrantyNameField.translatesAutoresizingMaskIntoConstraints = false
        warrantyNameField.backgroundColor = .white
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = .orange
        saveButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
        saveButton.isUserInteractionEnabled = true
        
        view.addSubview(warrantyNameField)
        view.addSubview(warrantyNameLabel)
        view.addSubview(saveButton)
        activateConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Category : \(category ?? "Missing")")
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 27)!,
                                                                   NSAttributedString.Key.foregroundColor: UIColor.black]
        
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    @objc func saveWarranty() {
        guard warrantyNameField.text != "" else { return alert("le champ est vide", "remplir le champ nom") }
        guard let name = warrantyNameField.text else { return print("nope") }
        let warrantyTest = Warranty(name: name, warrantyStart: NSDate.distantPast, warrantyEnd: nil, lifetimeWarranty: false, invoicePhoto: nil, price: nil, paymentMethod: nil, model: nil, serialNumber: nil, currency: nil, productPhoto: nil, sellersName: nil, sellersLocation: nil, sellersWebsite: nil, sellersContact: nil, category: nil)
        warranties.append(warrantyTest)
        do {
            try storageService.saveWarranty(warrantyTest)
        }
        catch {
            print(error)
        }
        viewModel?.goBack()
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            warrantyNameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warrantyNameField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            warrantyNameField.heightAnchor.constraint(equalToConstant: 50),
            warrantyNameField.widthAnchor.constraint(equalToConstant: 120),
            
            warrantyNameLabel.heightAnchor.constraint(equalToConstant: 30),
            warrantyNameLabel.widthAnchor.constraint(equalToConstant: 60),
            warrantyNameLabel.bottomAnchor.constraint(equalTo: warrantyNameField.topAnchor, constant: 8),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalToConstant: 80)
        ])
    }
}
