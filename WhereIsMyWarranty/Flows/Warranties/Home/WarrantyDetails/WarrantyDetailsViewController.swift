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
    
    let invoicePhotoStackView = UIStackView()
    let invoicePhotoTitle = UILabel()
    let invoiceImageView = UIImageView()
    
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
        let notificationName = NSNotification.Name(rawValue: "warranty updated")
        NotificationCenter.default.addObserver(self, selector: #selector(warrantyUpdated), name: notificationName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    // MARK: - Methods
    
    @objc func warrantyUpdated() {
        // FIXME: peut être au lieu de re-setup la view just pour refresh le controller, juste mettre à jour les textfields ?
        setupView()
    }
    
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
        
        guard let image = viewModel?.warranty.productPhoto else { return }
        productImageView.image = UIImage(data: image)
        productImageView.roundingViewCorners(radius: 64)
        productImageView.layer.borderWidth = 1.5
        productImageView.layer.borderColor = MWColor.bluegrey.cgColor
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        
        productName.text = viewModel?.warranty.name
        productName.font = UIFont.boldSystemFont(ofSize: 20)
        productName.translatesAutoresizingMaskIntoConstraints = false
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .full
        warrantyStatus.roundingViewCorners(radius: 5)
        warrantyStatus.textAlignment = .center
        warrantyStatus.numberOfLines = 2
        warrantyStatus.translatesAutoresizingMaskIntoConstraints = false
        if viewModel?.warranty.lifetimeWarranty == false {
            guard let text = viewModel?.warranty.warrantyEnd else { return }
            warrantyStatus.text = "Couvert jusqu'au\n\(formatter1.string(from: text))"
        } else {
            warrantyStatus.text = Strings.lifetimeWarrantyDefaultText
        }
        
        topStackView.axis = .vertical
        topStackView.spacing = 20
        topStackView.alignment = .center
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.addArrangedSubview(productImageView)
        topStackView.addArrangedSubview(productName)
        topStackView.addArrangedSubview(warrantyStatus)
        
        invoicePhotoTitle.text = "Facture"
        invoicePhotoTitle.font = UIFont.boldSystemFont(ofSize: 12)
        
        guard let invoicePhotoAsData = viewModel?.warranty.invoicePhoto else { return }
        invoiceImageView.image = UIImage(data: invoicePhotoAsData)
        
        invoicePhotoStackView.axis = .vertical
        invoicePhotoStackView.spacing = 4
        invoicePhotoStackView.alignment = .leading
        invoicePhotoStackView.addArrangedSubview(invoicePhotoTitle)
        invoicePhotoStackView.addArrangedSubview(invoiceImageView)
        
        
        editWarrantyButton.setTitle(" Modifier ", for: .normal)
        editWarrantyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        editWarrantyButton.setTitleColor(.white, for: .normal)
        editWarrantyButton.backgroundColor = MWColor.bluegrey
        editWarrantyButton.roundingViewCorners(radius: 8)
        editWarrantyButton.addTarget(self, action: #selector(editWarranty), for: .touchUpInside)
        editWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteWarrantyButton.setTitle(" Supprimer la garantie ", for: .normal)
        deleteWarrantyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        deleteWarrantyButton.setTitleColor(.white, for: .normal)
        deleteWarrantyButton.backgroundColor = .red
        deleteWarrantyButton.roundingViewCorners(radius: 8)
        deleteWarrantyButton.addTarget(self, action: #selector(deleteWarranty), for: .touchUpInside)
        deleteWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentStackView.axis = .vertical
        parentStackView.spacing = 24
        parentStackView.alignment = .center
        parentStackView.distribution = .fill
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        parentStackView.addArrangedSubview(topStackView)
        parentStackView.addArrangedSubview(productInfo)
        parentStackView.addArrangedSubview(invoicePhotoStackView)
        // parentStackView.addArrangedSubview(sellersInfo)
        // parentStackView.addArrangedSubview(notesStackView)
        parentStackView.addArrangedSubview(editWarrantyButton)
        parentStackView.addArrangedSubview(deleteWarrantyButton)
        view.addSubview(parentStackView)
        
        NSLayoutConstraint.activate([
            // parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            productImageView.heightAnchor.constraint(equalToConstant: 130),
            productImageView.widthAnchor.constraint(equalToConstant: 130),
            
            invoiceImageView.heightAnchor.constraint(equalToConstant: 130),
            invoiceImageView.widthAnchor.constraint(equalToConstant: 130),
            
            
            notes.heightAnchor.constraint(equalToConstant: 140),
            notes.widthAnchor.constraint(equalToConstant: 250)
        ])
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
}
