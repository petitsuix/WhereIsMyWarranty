//
//  WarrantyDetailsViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//

import UIKit

class WarrantyDetailsViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var viewModel: WarrantyDetailsViewModel?
    
    // MARK: - Private properties
    
    private let parentStackView = UIStackView()
    
    private let topParentStackView = UIStackView()
    private let topRightStackView = UIStackView()
    private let productImageView = UIImageView()
    private let productName = UILabel()
    private let warrantyStatusView = UIView()
    private let warrantyStatusLabel = UILabel()
    
    private let bottomBorder = UIView()
    
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
        let notificationName = NSNotification.Name(rawValue: Strings.warrantyUpdatedNotif)
        NotificationCenter.default.addObserver(self, selector: #selector(warrantyUpdated), name: notificationName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        setupData()
    }
    
    // MARK: - @objc methods
    
    @objc func warrantyUpdated() {
        // FIXME: peut être au lieu de re-setup la view juste pour refresh le controller, juste mettre à jour les textfields ?
        setupView()
        setupData()
    }
    
    @objc func showFullScreenImage() {
        viewModel?.showFullScreenInvoicePhoto()
    }
    
    func deleteWarranty() {
        viewModel?.deleteWarranty()
    }
    
    @objc func aboutToDeleteAlert() {
        let alertController = UIAlertController(title: Strings.delete, message: Strings.confirmDeletion, preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: Strings.delete, style: .destructive, handler: { [unowned self] _ in
            self.deleteWarranty()
            navigationController?.popToRootViewController(animated: true)
        })
        let abortAction = UIAlertAction(title: Strings.cancel, style: .default, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(abortAction)
        present(alertController, animated: true)
    }
    
    @objc func editWarranty() {
        viewModel?.editWarranty()
    }
    
    // MARK: - Methods
    
    private func getRemainingDaysFromEndDate() -> String {
        let calendar = NSCalendar.current
        
        guard let warrantyEnd = viewModel?.warranty.warrantyEnd else { return "0" }
        let date1 = calendar.startOfDay(for: Date())
        let date2 = calendar.startOfDay(for: warrantyEnd)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        guard let remainingDays = components.day else { return "0" }
        return String("\(remainingDays)")
    }
}

// MARK: - View configuration

extension WarrantyDetailsViewController {
    
    private func setupView() {
        self.title = Strings.warrantiesTitle
        view.backgroundColor = MWColor.white
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.roundingViewCorners(radius: 64)
        productImageView.layer.borderWidth = 1.5
        productImageView.layer.borderColor = MWColor.bluegrey.cgColor
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.font = MWFont.warrantyDetailsProductName
        productName.numberOfLines = 2
        
        warrantyStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        warrantyStatusLabel.textAlignment = .center
        warrantyStatusLabel.textColor = MWColor.white
        warrantyStatusLabel.font = MWFont.warrantyStatusLabel
        warrantyStatusLabel.numberOfLines = 2
        
        warrantyStatusView.roundingViewCorners(radius: 8)
        warrantyStatusView.addSubview(warrantyStatusLabel)
        
        topRightStackView.axis = .vertical
        topRightStackView.alignment = .center
        topRightStackView.distribution = .equalSpacing
        topRightStackView.spacing = 16
        topRightStackView.addArrangedSubview(productName)
        topRightStackView.addArrangedSubview(warrantyStatusView)
        
        topParentStackView.axis = .horizontal
        topParentStackView.alignment = .center
        topParentStackView.addArrangedSubview(productImageView)
        topParentStackView.addArrangedSubview(topRightStackView)

        bottomBorder.setBottomBorder()
        
        invoicePhotoTitle.text = Strings.invoice
        invoicePhotoTitle.font = MWFont.invoicePhotoTitle
        
        invoiceImageView.contentMode = .scaleAspectFit
        invoiceImageView.isUserInteractionEnabled = true
        invoiceImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showFullScreenImage)))
        
        invoicePhotoStackView.axis = .vertical
        invoicePhotoStackView.spacing = 8
        invoicePhotoStackView.alignment = .leading
        invoicePhotoStackView.addArrangedSubview(invoicePhotoTitle)
        invoicePhotoStackView.addArrangedSubview(invoiceImageView)
        
        editWarrantyButton.setTitle(Strings.edit, for: .normal)
        editWarrantyButton.titleLabel?.font = MWFont.editWarrantyButton
        editWarrantyButton.setTitleColor(MWColor.white, for: .normal)
        editWarrantyButton.backgroundColor = MWColor.bluegrey
        editWarrantyButton.roundingViewCorners(radius: 11)
        editWarrantyButton.addTarget(self, action: #selector(editWarranty), for: .touchUpInside)
        
        deleteWarrantyButton.setTitle(Strings.delete, for: .normal)
        deleteWarrantyButton.titleLabel?.font = MWFont.deleteWarrantyButton
        deleteWarrantyButton.setTitleColor(MWColor.white, for: .normal)
        deleteWarrantyButton.backgroundColor = MWColor.red
        deleteWarrantyButton.roundingViewCorners(radius: 11)
        deleteWarrantyButton.addTarget(self, action: #selector(aboutToDeleteAlert), for: .touchUpInside)
        
        bottomButtonsStackView.axis = .horizontal
        bottomButtonsStackView.alignment = .center
        bottomButtonsStackView.spacing = 18
        bottomButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonsStackView.addArrangedSubview(editWarrantyButton)
        bottomButtonsStackView.addArrangedSubview(deleteWarrantyButton)
        
        parentStackView.axis = .vertical
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.spacing = 24
        parentStackView.addArrangedSubview(topParentStackView)
        parentStackView.addArrangedSubview(bottomBorder)
        parentStackView.addArrangedSubview(invoicePhotoStackView)
        view.addSubview(parentStackView)
        view.addSubview(bottomButtonsStackView)
        
        NSLayoutConstraint.activate([
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomButtonsStackView.topAnchor, constant: -8),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
    
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 60),
            bottomButtonsStackView.centerXAnchor.constraint(equalTo: parentStackView.centerXAnchor),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            deleteWarrantyButton.widthAnchor.constraint(equalToConstant: 140),
            deleteWarrantyButton.heightAnchor.constraint(equalToConstant: 37),
            
            editWarrantyButton.widthAnchor.constraint(equalToConstant: 140),
            editWarrantyButton.heightAnchor.constraint(equalToConstant: 37),
            
            warrantyStatusLabel.leadingAnchor.constraint(equalTo: warrantyStatusView.leadingAnchor, constant: 8),
            warrantyStatusLabel.trailingAnchor.constraint(equalTo: warrantyStatusView.trailingAnchor, constant: -8),
            warrantyStatusLabel.topAnchor.constraint(equalTo: warrantyStatusView.topAnchor, constant: 4),
            warrantyStatusLabel.bottomAnchor.constraint(equalTo: warrantyStatusView.bottomAnchor, constant: -4),
            
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),

            productImageView.heightAnchor.constraint(equalToConstant: 130),
            productImageView.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
    
    func setupData() {
        if let image = viewModel?.warranty.productPhoto {
            productImageView.image = UIImage(data: image)
        }
        productName.text = viewModel?.warranty.name
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .long
        formatter1.locale = Locale(identifier: Strings.localeIdentifier)
        if viewModel?.warranty.lifetimeWarranty == false {
            if Int(getRemainingDaysFromEndDate()) ?? 0 < 0 {
                warrantyStatusLabel.text = Strings.warrantyExpired
                warrantyStatusView.backgroundColor = MWColor.warrantyExpiredRed
            } else {
                if let text = viewModel?.warranty.warrantyEnd {
                    warrantyStatusLabel.text = Strings.coveredUntil + "\n\(formatter1.string(from: text))"
                    warrantyStatusView.backgroundColor = MWColor.warrantyActiveGreen
                }
            }
        } else {
            warrantyStatusLabel.text = Strings.lifetimeWarrantyTextWithExtraLine
            warrantyStatusView.backgroundColor = MWColor.warrantyActiveGreen
        }
        if let invoicePhotoAsData = viewModel?.warranty.invoicePhoto {
            invoiceImageView.image = UIImage(data: invoicePhotoAsData)
        }
    }
}
