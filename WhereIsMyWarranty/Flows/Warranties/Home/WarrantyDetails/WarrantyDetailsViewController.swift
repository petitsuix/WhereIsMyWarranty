//
//  WarrantyDetailsViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//

import UIKit

class WarrantyDetailsViewController: UIViewController {
    var viewModel: WarrantyDetailsViewModel?
    var warranty: Warranty? // a virer, tout se choppe depuis le viewmodel
    
    let parentStackView = UIStackView()
    
    let topStackView = UIStackView()
    let productImageView = UIImageView()
    let productName = UILabel()
    let warrantyStatus = UILabel()
    
    let productInfoStackView = UIStackView()
    let productInfoTitle = UILabel()
    let price = UILabel()
    let model = UILabel()
    let serialNumber = UILabel()
    let currency = UILabel()

    let sellersInfoStackView = UIStackView()
    let sellersInfoTitle = UILabel()
    let sellersName = UILabel()
    let sellersLocation = UILabel()
    let sellersWebsite = UILabel()
    let sellersContact = UILabel()
    
    let notes = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel?.warranty = warranty
        setupView()
    }
    
    
    
}

extension WarrantyDetailsViewController {
    private func setupView() {
        // Ici
        // creation des lable
        // configuration des view
        // config stack view
        
        // nalayoutconstraint ....
        self.title = Strings.warrantiesTitle
        view.backgroundColor = .white
        configureParentStackView()
        configureTopStackView()
        activateConstraints()
        // configureCategoriesStackView()
        // configureBottomBorder()
       // configureWarrantiesCollectionView()
       // configureAddWarrantyButton()
       // activateConstraints()
    }
    
    private func configureParentStackView() {
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        view.addSubview(parentStackView)
        parentStackView.addArrangedSubview(topStackView)
      //  parentStackView.addArrangedSubview(productInfoStackView)
       // parentStackView.addArrangedSubview(sellersInfoStackView)
      // parentStackView.addArrangedSubview(notes)
    }
    
    private func configureTopStackView() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        topStackView.axis = .vertical
        productName.backgroundColor = .lightGray
        productName.text = warranty?.name
       // topStackView.addArrangedSubview(productImageView)
        topStackView.addArrangedSubview(productName)
        // topStackView.addArrangedSubview(warrantyStatus)
    }
    
    private func configureProductInfoStackView() {
        productInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        productInfoStackView.axis = .vertical
        productInfoStackView.addArrangedSubview(productInfoTitle)
        productInfoStackView.addArrangedSubview(price)
        productInfoStackView.addArrangedSubview(model)
        productInfoStackView.addArrangedSubview(serialNumber)
        productInfoStackView.addArrangedSubview(currency)
    }
    
    private func configureSellersInfoStackView() {
        sellersInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        sellersInfoStackView.axis = .vertical
        sellersInfoStackView.addArrangedSubview(sellersInfoTitle)
        sellersInfoStackView.addArrangedSubview(sellersName)
        sellersInfoStackView.addArrangedSubview(sellersLocation)
        sellersInfoStackView.addArrangedSubview(sellersWebsite)
        sellersInfoStackView.addArrangedSubview(sellersContact)
    }
    
    private func configureNotesTextView() {
        notes.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            parentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
