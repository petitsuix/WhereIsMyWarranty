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
    
    let editWarrantyButton = UIButton()
    let deleteWarrantyButton = UIButton()
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // MARK: - Methods
    
    @objc func deleteWarranty() {
        viewModel?.deleteWarranty()
    }
    
    @objc func editWarranty() {
        viewModel?.editWarranty()
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
        configureEditWarrantyButton()
        configureDeleteWarrantyButton()
        
        parentStackView.addArrangedSubview(topStackView)
        parentStackView.addArrangedSubview(productInfo)
        // parentStackView.addArrangedSubview(sellersInfo)
        parentStackView.addArrangedSubview(notesStackView)
        parentStackView.addArrangedSubview(editWarrantyButton)
        parentStackView.addArrangedSubview(deleteWarrantyButton)
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
        guard let image = viewModel?.warranty.invoicePhoto else { return }
        productImageView.image = UIImage(data: image)
        productImageView.roundingViewCorners(radius: 64)
        productImageView.layer.borderWidth = 1.5
        productImageView.layer.borderColor = MWColor.bluegrey.cgColor
        productImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureProductNameLabel() {
        productName.text = viewModel?.warranty.name
        productName.font = UIFont.boldSystemFont(ofSize: 20)
        productName.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureWarrantyStatus() {
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        warrantyStatus.roundingViewCorners(radius: 5)
        guard let text = viewModel?.warranty.warrantyEnd else { return }
        warrantyStatus.text = "Couvert jusqu'au\n\(formatter1.string(from: text))"
        warrantyStatus.textAlignment = .center
        warrantyStatus.numberOfLines = 2
        warrantyStatus.translatesAutoresizingMaskIntoConstraints = false
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
        notesSectionTitle.textColor = .black
        notesSectionTitle.text = "Notes"
        notesSectionTitle.translatesAutoresizingMaskIntoConstraints = false
        
        notes.layer.borderWidth = 0.5
        notes.layer.borderColor = MWColor.bluegrey.cgColor
        notes.roundingViewCorners(radius: 6)
        notes.translatesAutoresizingMaskIntoConstraints = false
        
        notesStackView.translatesAutoresizingMaskIntoConstraints = false
        notesStackView.axis = .vertical
        notesStackView.spacing = 8
        
        notesStackView.addArrangedSubview(notesSectionTitle)
        notesStackView.addArrangedSubview(notes)
    }
    
    private func configureEditWarrantyButton() {
        editWarrantyButton.setTitle("Modifier", for: .normal)
        editWarrantyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        editWarrantyButton.setTitleColor(.white, for: .normal)
        editWarrantyButton.backgroundColor = MWColor.bluegrey
        editWarrantyButton.roundingViewCorners(radius: 8)
        editWarrantyButton.addTarget(self, action: #selector(editWarranty), for: .touchUpInside)
        editWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureDeleteWarrantyButton() {
        deleteWarrantyButton.setTitle("Supprimer la garantie", for: .normal)
        deleteWarrantyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        deleteWarrantyButton.setTitleColor(.white, for: .normal)
        deleteWarrantyButton.backgroundColor = .red
        deleteWarrantyButton.roundingViewCorners(radius: 8)
        deleteWarrantyButton.addTarget(self, action: #selector(deleteWarranty), for: .touchUpInside)
        deleteWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            parentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            parentStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
          //  parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
          //  parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            productImageView.heightAnchor.constraint(equalToConstant: 130),
            productImageView.widthAnchor.constraint(equalToConstant: 130),
            
            notes.heightAnchor.constraint(equalToConstant: 140),
            notes.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
}
