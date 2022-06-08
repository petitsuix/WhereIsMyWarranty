//
//  WarrantyDetailsViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//

import UIKit

class WarrantyDetailsViewController: UIViewController {
    
    private enum Section: Int, CaseIterable {
        case additionalProductInfo
        case sellersInfo
        case additionalNotes
        func description() -> String {
            switch self {
            case .additionalProductInfo:
                return "Infos produit"
            case .sellersInfo:
                return "Infos vendeur"
            case .additionalNotes:
                return "Notes"
            }
        }
    }
    
    private enum Item: Hashable {
        case price
        case model
        case serialNumber
        case sellersName
        case sellersLocation
        case sellersContact
        case sellersWebsite
        case notes
    }
    
    // MARK: - Internal properties
    
    var viewModel: WarrantyDetailsViewModel?
    
    // MARK: - Private properties
    
    private var extraInfoTVDiffableDataSource: DataSource! = nil
    
    private let parentStackView = UIStackView()
    
    private let topParentStackView = UIStackView()
    private let topRightStackView = UIStackView()
    private let productImageView = UIImageView()
    private let productName = UILabel()
    private let warrantyStatusView = UIView()
    private let warrantyStatusLabel = UILabel()
    
    private let bottomBorder = UIView()
    
    private let invoicePhotoStackView = UIStackView()
    private let invoicePhotoTitle = UILabel()
    private let invoiceImageView = UIImageView()
    
    private let extraWarrantyInfoStackView = UIStackView()
    private let extraWarrantyInfoTitle = UILabel()
    private let extraInfoTableView = UITableView(frame: .zero, style: .plain)
    
    private let bottomButtonsStackView = UIStackView()
    private let editWarrantyButton = UIButton()
    private let deleteWarrantyButton = UIButton()
    
    private var productInfoList: [Item] = [.price, .model, .serialNumber]
    private var sellersInfoItems: [Item] = [.sellersName, .sellersLocation, .sellersContact, .sellersWebsite]
    private var additionalNotesItem: [Item] = [.notes]
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName = NSNotification.Name(rawValue: Strings.warrantyUpdatedNotif)
        NotificationCenter.default.addObserver(self, selector: #selector(warrantyUpdated), name: notificationName, object: nil)
        configureExtraInfoTableViewDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        setupData()
    }
    
    // MARK: - @objc methods
    
    @objc func warrantyUpdated() {
        setupData()
        let snapshot = createExtraInfosSnapshot()
        extraInfoTVDiffableDataSource.apply(snapshot)
    }
    
    @objc func showFullScreenImage() {
        viewModel?.showFullScreenInvoicePhoto()
    }
    
    @objc func editWarranty() {
        viewModel?.editWarranty()
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
    
    // MARK: - Methods
    
    private func configureExtraInfoTableViewDataSource() {
        extraInfoTVDiffableDataSource = DataSource(tableView: extraInfoTableView, cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .price:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Prix"
                cell?.body.text = String(self.viewModel?.warranty.price ?? 0)
                return cell
            case .model:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Modèle"
                cell?.body.text = self.viewModel?.warranty.model
                return cell
            case .serialNumber:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Numéro de série"
                cell?.body.text = self.viewModel?.warranty.serialNumber
                return cell
            case .sellersName:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Nom"
                cell?.body.text = self.viewModel?.warranty.sellersName
                return cell
            case .sellersLocation:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Adresse"
                cell?.body.text = self.viewModel?.warranty.sellersLocation
                return cell
            case .sellersWebsite:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Site web"
                cell?.body.text = self.viewModel?.warranty.sellersWebsite
                return cell
            case .sellersContact:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Contact"
                cell?.body.text = self.viewModel?.warranty.sellersContact
                return cell
            case .notes:
                let cell = tableView.dequeueReusableCell(withIdentifier: "WarrantyDetailsExtraInfoCell", for: indexPath) as? WarrantyDetailsExtraInfoCell
                cell?.title.text = "Notes"
                cell?.body.text = self.viewModel?.warranty.notes
                return cell
            }
        })
        let snapshot = createExtraInfosSnapshot()
        extraInfoTVDiffableDataSource.apply(snapshot)
    }
    
    private func createExtraInfosSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.additionalProductInfo, .sellersInfo, .additionalNotes])
        snapshot.appendItems(productInfoList, toSection: .additionalProductInfo)
        snapshot.appendItems(sellersInfoItems, toSection: .sellersInfo)
        snapshot.appendItems(additionalNotesItem, toSection: .additionalNotes)
        return snapshot
    }
    
    private func deleteWarranty() {
        viewModel?.deleteWarranty()
    }
    
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
        view.backgroundColor = MWColor.systemBackground
        
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.isAccessibilityElement = false
        productImageView.roundingViewCorners(radius: 64)
        productImageView.layer.borderWidth = 1.5
        productImageView.layer.borderColor = MWColor.bluegreyElement.cgColor
        
        productName.translatesAutoresizingMaskIntoConstraints = false
        productName.font = MWFont.warrantyDetailsProductName
        productName.accessibilityLabel = Strings.warrantyName
        productName.numberOfLines = 2
        
        warrantyStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        warrantyStatusLabel.textAlignment = .center
        warrantyStatusLabel.textColor = MWColor.systemBackground
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
     //   invoicePhotoStackView.backgroundColor = .green
        
        extraWarrantyInfoTitle.text = "Informations additionnelles"
        extraWarrantyInfoTitle.font = MWFont.invoicePhotoTitle
        
        extraInfoTableView.translatesAutoresizingMaskIntoConstraints = false
      //  extraInfoTableView.backgroundColor = .blue
        extraInfoTableView.register(WarrantyDetailsExtraInfoCell.self, forCellReuseIdentifier: "WarrantyDetailsExtraInfoCell")
        extraInfoTableView.delegate = self

        extraWarrantyInfoStackView.axis = .vertical
       // extraWarrantyInfoStackView.spacing = 124
        //extraWarrantyInfoStackView.alignment = .leading
        //extraWarrantyInfoStackView.distribution = .fillProportionally
        extraWarrantyInfoStackView.addArrangedSubview(extraWarrantyInfoTitle)
        extraWarrantyInfoStackView.addArrangedSubview(extraInfoTableView)
       // extraWarrantyInfoStackView.backgroundColor = .orange
        
        parentStackView.axis = .vertical
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.spacing = 24
        parentStackView.addArrangedSubview(topParentStackView)
        parentStackView.addArrangedSubview(bottomBorder)
        parentStackView.addArrangedSubview(invoicePhotoStackView)
        parentStackView.addArrangedSubview(extraWarrantyInfoStackView)
      //  parentStackView.backgroundColor = .red
        
        editWarrantyButton.setTitle(Strings.edit, for: .normal)
        editWarrantyButton.titleLabel?.font = MWFont.editWarrantyButton
        editWarrantyButton.setTitleColor(MWColor.systemBackground, for: .normal)
        editWarrantyButton.backgroundColor = MWColor.bluegreyElement
        editWarrantyButton.roundingViewCorners(radius: 11)
        editWarrantyButton.addTarget(self, action: #selector(editWarranty), for: .touchUpInside)
        
        deleteWarrantyButton.setTitle(Strings.delete, for: .normal)
        deleteWarrantyButton.titleLabel?.font = MWFont.deleteWarrantyButton
        deleteWarrantyButton.setTitleColor(MWColor.systemBackground, for: .normal)
        deleteWarrantyButton.backgroundColor = MWColor.red
        deleteWarrantyButton.roundingViewCorners(radius: 11)
        deleteWarrantyButton.addTarget(self, action: #selector(aboutToDeleteAlert), for: .touchUpInside)
        
        bottomButtonsStackView.axis = .horizontal
        bottomButtonsStackView.alignment = .center
        bottomButtonsStackView.spacing = 18
        bottomButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonsStackView.addArrangedSubview(editWarrantyButton)
        bottomButtonsStackView.addArrangedSubview(deleteWarrantyButton)
        
        view.addSubview(parentStackView)
        view.addSubview(extraInfoTableView)
        view.addSubview(bottomButtonsStackView)
        
        NSLayoutConstraint.activate([
            invoiceImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150),
            invoiceImageView.centerXAnchor.constraint(equalTo: invoicePhotoStackView.centerXAnchor),
           
            
            warrantyStatusLabel.leadingAnchor.constraint(equalTo: warrantyStatusView.leadingAnchor, constant: 8),
            warrantyStatusLabel.trailingAnchor.constraint(equalTo: warrantyStatusView.trailingAnchor, constant: -8),
            warrantyStatusLabel.topAnchor.constraint(equalTo: warrantyStatusView.topAnchor, constant: 4),
            warrantyStatusLabel.bottomAnchor.constraint(equalTo: warrantyStatusView.bottomAnchor, constant: -4),
            
            bottomBorder.heightAnchor.constraint(equalToConstant: 1),

            productImageView.heightAnchor.constraint(equalToConstant: 130),
            productImageView.widthAnchor.constraint(equalToConstant: 130),
            
            extraInfoTableView.topAnchor.constraint(equalTo: extraWarrantyInfoTitle.bottomAnchor, constant: 0),
            extraInfoTableView.leadingAnchor.constraint(equalTo: parentStackView.leadingAnchor, constant: 0),
            extraInfoTableView.trailingAnchor.constraint(equalTo: parentStackView.trailingAnchor, constant: 0),
            // extraInfoTableView.heightAnchor.constraint(equalToConstant: 200),
            extraInfoTableView.bottomAnchor.constraint(equalTo: bottomButtonsStackView.topAnchor, constant: -8),
            
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            parentStackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomButtonsStackView.topAnchor, constant: -8),
            parentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            parentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            editWarrantyButton.widthAnchor.constraint(equalToConstant: 140),
            editWarrantyButton.heightAnchor.constraint(equalToConstant: 37),
            
            deleteWarrantyButton.widthAnchor.constraint(equalToConstant: 140),
            deleteWarrantyButton.heightAnchor.constraint(equalToConstant: 37),
            
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 60),
            bottomButtonsStackView.centerXAnchor.constraint(equalTo: parentStackView.centerXAnchor),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func setupData() {
        self.title = viewModel?.warranty.name
        if let image = viewModel?.warranty.productPhoto {
            productImageView.image = UIImage(data: image)
        }
        productName.text = viewModel?.warranty.name
        productName.accessibilityValue = productName.text
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

extension WarrantyDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Section.additionalNotes.rawValue {
            return 120
        } else {
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}

extension WarrantyDetailsViewController {
    private class DataSource: UITableViewDiffableDataSource<Section, Item> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return false
        }
    }
}
