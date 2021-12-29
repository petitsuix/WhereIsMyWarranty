//
//  WarrantyDetailsViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//

import UIKit

class WarrantyDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: WarrantyDetailsViewModel?
    var warranty: Warranty? // a virer, tout se choppe depuis le viewmodel
    
    let parentStackView = UIStackView()
    
    let topStackView = UIStackView()
    let productImageView = UIImageView()
    let productName = UILabel()
    let warrantyStatus = UILabel()
    
    let productInfo = WarrantyDetailsSectionView()
    let sellersInfo = WarrantyDetailsSectionView()
    
    let notesStackView = UIStackView()
    let notesSectionTitle = UILabel()
    let notes = UITextView()
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // MARK: - Methods
    
    func refreshWith(warranty: Warranty) {
        self.warranty = viewModel?.warranty
    }
}

// MARK: - View configuration

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
        activateConstraints()
    }
    
    private func configureParentStackView() {
        parentStackView.axis = .vertical
        parentStackView.spacing = 24
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        configureTopStackView()
        configureNotesStackView()
        configureProductAndSellerInfoViews()
        configureNotesStackView()
        
        parentStackView.addArrangedSubview(topStackView)
        parentStackView.addArrangedSubview(productInfo)
        parentStackView.addArrangedSubview(sellersInfo)
        parentStackView.addArrangedSubview(notesStackView)
        view.addSubview(parentStackView)
    }
    
    // MARK: Top stackView
    
    private func configureTopStackView() {
        topStackView.axis = .vertical
        topStackView.spacing = 24
        topStackView.alignment = .center
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        configureProductImageView()
        configureProductNameLabel()
        configureWarrantyStatus()
        
        topStackView.addArrangedSubview(productImageView)
        topStackView.addArrangedSubview(productName)
        topStackView.addArrangedSubview(warrantyStatus)
    }
    
    private func configureProductImageView() {
        let image = UIImage(named: "Launchscreen")
        // let image = warranty?.productImage
        productImageView.image = image
        productImageView.roundingViewCorners(radius: 15)
        productImageView.layer.borderWidth = 2
        productImageView.layer.borderColor = MWColor.bluegrey.cgColor
        productImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureProductNameLabel() {
        productName.backgroundColor = .lightGray
        productName.text = warranty?.name
        productName.font = UIFont.boldSystemFont(ofSize: 15)
        productName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWarrantyStatus() {
        warrantyStatus.backgroundColor = .green
        warrantyStatus.translatesAutoresizingMaskIntoConstraints = false
        warrantyStatus.roundingViewCorners(radius: 5)
        warrantyStatus.addShadow()
        guard let text = warranty?.warrantyStart else { return }
        warrantyStatus.text = "Couvert jusqu'au\n\(text)"
    }
    
    // MARK: Middle "Product and seller info views"
    
    private func configureProductAndSellerInfoViews() {
        productInfo.sectionTitle.text = "Informations produit"
        productInfo.firstRow.text = "Prix : 10€"
        productInfo.secondRow.text = "Modèle : MacBook Pro 2020"
        productInfo.thirdRow.text = "Numéro de série : 0A39987 9878 8789"
        productInfo.fourthRow.text = "Paiement : Espèces"
        productInfo.translatesAutoresizingMaskIntoConstraints = false
        productInfo.configureView()
        
        sellersInfo.sectionTitle.text = "Informations vendeur"
        sellersInfo.firstRow.text = "Enseigne : Apple Store"
        sellersInfo.secondRow.text = "Lieu : Confluence, Lyon"
        sellersInfo.thirdRow.text = "Site web : apple.com"
        sellersInfo.fourthRow.text = "Contact : john.appleseed@applestore.com"
        sellersInfo.translatesAutoresizingMaskIntoConstraints = false
        sellersInfo.configureView()
    }
    
    // MARK: Bottom "Notes stackView"
    
    private func configureNotesStackView() {
        notesSectionTitle.font.withSize(15)
        notesSectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        notes.backgroundColor = .lightGray
        notes.translatesAutoresizingMaskIntoConstraints = false
        
        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        notesStackView.spacing = 8
        notesStackView.addArrangedSubview(notesSectionTitle)
        notesStackView.addArrangedSubview(notes)
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            parentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            productImageView.heightAnchor.constraint(equalToConstant: 110),
            productImageView.widthAnchor.constraint(equalToConstant: 110),
            
            notes.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
}
