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
    
    // MARK: - Private properties
    
    private let parentStackView = UIStackView()
    
    private let topStackView = UIStackView()
    private let productImageView = UIImageView()
    private let productName = UILabel()
    private let warrantyStatus = UILabel()
    
    private  let invoicePhotoStackView = UIStackView()
    private let invoicePhotoTitle = UILabel()
    private let invoiceImageView = UIImageView()
    
    private let notesStackView = UIStackView()
    private let notesSectionTitle = UILabel()
    private let notes = UITextView()
    
    private let bottomButtonsStackView = UIStackView()
    private let editWarrantyButton = UIButton()
    private let deleteWarrantyButton = UIButton()
    
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
    
    // MARK: - @objc methods
    
    @objc func warrantyUpdated() {
        // FIXME: peut être au lieu de re-setup la view juste pour refresh le controller, juste mettre à jour les textfields ?
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
        self.title = Strings.warrantiesTitle
        view.backgroundColor = .white
        
        if let image = viewModel?.warranty.productPhoto {
            productImageView.image = UIImage(data: image)
        }
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
            if let text = viewModel?.warranty.warrantyEnd {
                warrantyStatus.text = "Couvert jusqu'au\n\(formatter1.string(from: text))"
            }
        } else {
            warrantyStatus.text = Strings.lifetimeWarrantyDefaultText
        }
        
        topStackView.axis = .vertical
        topStackView.spacing = 16
        topStackView.alignment = .center
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        topStackView.addArrangedSubview(productImageView)
        topStackView.addArrangedSubview(productName)
        topStackView.addArrangedSubview(warrantyStatus)
        
        invoicePhotoTitle.text = "Facture"
        invoicePhotoTitle.font = UIFont.boldSystemFont(ofSize: 16)
        
        if let invoicePhotoAsData = viewModel?.warranty.invoicePhoto {
            invoiceImageView.image = UIImage(data: invoicePhotoAsData)
        }
        
        invoicePhotoStackView.axis = .vertical
        invoicePhotoStackView.spacing = 8
        invoicePhotoStackView.alignment = .center
        invoicePhotoStackView.addArrangedSubview(invoicePhotoTitle)
        invoicePhotoStackView.addArrangedSubview(invoiceImageView)
        
        
        editWarrantyButton.setTitle(" Modifier ", for: .normal)
        editWarrantyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        editWarrantyButton.setTitleColor(.white, for: .normal)
        editWarrantyButton.backgroundColor = MWColor.bluegrey
        editWarrantyButton.roundingViewCorners(radius: 8)
        editWarrantyButton.addShadow()
        editWarrantyButton.addTarget(self, action: #selector(editWarranty), for: .touchUpInside)
        editWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        
        deleteWarrantyButton.setTitle(" Supprimer la garantie ", for: .normal)
        deleteWarrantyButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        deleteWarrantyButton.setTitleColor(.white, for: .normal)
        deleteWarrantyButton.backgroundColor = .red
        deleteWarrantyButton.roundingViewCorners(radius: 8)
        deleteWarrantyButton.addShadow()
        deleteWarrantyButton.addTarget(self, action: #selector(deleteWarranty), for: .touchUpInside)
        deleteWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        
        bottomButtonsStackView.axis = .vertical
        bottomButtonsStackView.alignment = .center
        bottomButtonsStackView.spacing = 24
        bottomButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonsStackView.addArrangedSubview(editWarrantyButton)
        bottomButtonsStackView.addArrangedSubview(deleteWarrantyButton)
        
        parentStackView.axis = .vertical
        parentStackView.alignment = .center
        parentStackView.spacing = 80
        // parentStackView.distribution = .fill
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        parentStackView.addArrangedSubview(topStackView)
        parentStackView.addArrangedSubview(invoicePhotoStackView)
        //parentStackView.addArrangedSubview(editWarrantyButton)
        //parentStackView.addArrangedSubview(deleteWarrantyButton)
        view.addSubview(parentStackView)
        view.addSubview(bottomButtonsStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            // parentStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            bottomButtonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            bottomButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            
            productImageView.heightAnchor.constraint(equalToConstant: 130),
            productImageView.widthAnchor.constraint(equalToConstant: 130),
            
            invoiceImageView.heightAnchor.constraint(equalToConstant: 150),
            invoiceImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func colors() {
        // invoicePhotoStackView.backgroundColor = .yellow
        // topStackView.backgroundColor = .orange
        parentStackView.backgroundColor = .orange
    }
}
