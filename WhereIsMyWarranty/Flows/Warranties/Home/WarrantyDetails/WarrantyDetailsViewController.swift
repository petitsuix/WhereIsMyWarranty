//
//  WarrantyDetailsViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 22/12/2021.
//
//swiftlint:disable file_length
//swiftlint:disable cyclomatic_complexity

import UIKit

class WarrantyDetailsViewController: UIViewController {
    
    private enum Section: Int, CaseIterable {
        case productPresentation
        case invoice
        case extraInfo
        func description() -> String {
            switch self {
            case .productPresentation:
                return ""
            case .invoice:
                return "Facture"
            case .extraInfo:
                return "Informations additionnelles"
            }
        }
    }
    
    private enum Item: Hashable {
        case topPresentation
        case invoice
        case price
        case model
        case serialNumber
        case sellersName
        case sellersLocation
        case sellersContact
        case sellersWebsite
        case notes
    }
    
    var viewModel: WarrantyDetailsViewModel?
    
    // MARK: - Private properties
    
    private var tableViewDiffableDataSource: DataSource!
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let bottomButtonsStackView = UIStackView()
    private let editWarrantyButton = UIButton()
    private let deleteWarrantyButton = UIButton()
    
    private var extraInfoItems: [Item] = [.price, .model, .serialNumber, .sellersName, .sellersLocation, .sellersContact, .sellersWebsite, .notes]
    
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
    
    // MARK: - Methods
    
    private func configureExtraInfoTableViewDataSource() {
        tableViewDiffableDataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .topPresentation:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopPresentationCell", for: indexPath) as? TopPresentationCell
                cell?.warranty = self.viewModel?.warranty
                return cell
            case .invoice:
                let cell = tableView.dequeueReusableCell(withIdentifier: "InvoicePhotoCell", for: indexPath) as? InvoicePhotoCell
                if let invoicePhotoAsData = self.viewModel?.warranty.invoicePhoto {
                    cell?.invoiceImageView.image = UIImage(data: invoicePhotoAsData)
                }
                return cell
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
        tableViewDiffableDataSource.apply(snapshot)
    }
    
    private func createExtraInfosSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.productPresentation, .invoice, .extraInfo])
        snapshot.appendItems([.topPresentation], toSection: .productPresentation)
        snapshot.appendItems([.invoice], toSection: .invoice)
        snapshot.appendItems(extraInfoItems, toSection: .extraInfo)
        return snapshot
    }
    
    // MARK: - @objc methods
    
    @objc func warrantyUpdated() {
        setupData()
        configureExtraInfoTableViewDataSource()
        let snapshot = createExtraInfosSnapshot()
        tableViewDiffableDataSource.apply(snapshot)
    }
    
    @objc func showFullScreenImage() {
        viewModel?.showFullScreenInvoicePhoto()
    }
    
    @objc func editWarranty() {
        viewModel?.editWarranty()
    }
    
    private func deleteWarranty() {
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
}

// MARK: - View configuration

extension WarrantyDetailsViewController {
    
    private func setupView() {
        view.backgroundColor = MWColor.background
        
        editWarrantyButton.setTitle(Strings.edit, for: .normal)
        editWarrantyButton.titleLabel?.font = MWFont.editWarrantyButton
        editWarrantyButton.setTitleColor(MWColor.label, for: .normal)
        editWarrantyButton.backgroundColor = MWColor.bluegreyElement
        editWarrantyButton.roundingViewCorners(radius: 11)
        editWarrantyButton.addTarget(self, action: #selector(editWarranty), for: .touchUpInside)
        
        deleteWarrantyButton.setTitle(Strings.delete, for: .normal)
        deleteWarrantyButton.titleLabel?.font = MWFont.deleteWarrantyButton
        deleteWarrantyButton.setTitleColor(MWColor.label, for: .normal)
        deleteWarrantyButton.backgroundColor = MWColor.red
        deleteWarrantyButton.roundingViewCorners(radius: 11)
        deleteWarrantyButton.addTarget(self, action: #selector(aboutToDeleteAlert), for: .touchUpInside)
        
        bottomButtonsStackView.axis = .horizontal
        bottomButtonsStackView.alignment = .center
        bottomButtonsStackView.spacing = 18
        bottomButtonsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomButtonsStackView.addArrangedSubview(editWarrantyButton)
        bottomButtonsStackView.addArrangedSubview(deleteWarrantyButton)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.register(TopPresentationCell.self, forCellReuseIdentifier: "TopPresentationCell")
        tableView.register(InvoicePhotoCell.self, forCellReuseIdentifier: "InvoicePhotoCell")
        tableView.register(WarrantyDetailsExtraInfoCell.self, forCellReuseIdentifier: "WarrantyDetailsExtraInfoCell")
        tableView.backgroundColor = MWColor.background
        
        view.addSubview(tableView)
        view.addSubview(bottomButtonsStackView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            editWarrantyButton.widthAnchor.constraint(equalToConstant: 140),
            editWarrantyButton.heightAnchor.constraint(equalToConstant: 37),
            
            deleteWarrantyButton.widthAnchor.constraint(equalToConstant: 140),
            deleteWarrantyButton.heightAnchor.constraint(equalToConstant: 37),
            
            bottomButtonsStackView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 8),
            bottomButtonsStackView.heightAnchor.constraint(equalToConstant: 60),
            bottomButtonsStackView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            bottomButtonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
    func setupData() {
        self.title = viewModel?.warranty.name
    }
}

extension WarrantyDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Section.extraInfo.rawValue {
            return 60
        } else if indexPath.section == Section.productPresentation.rawValue {
            return 190
        } else {
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == Section.invoice.rawValue {
            showFullScreenImage()
        }
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
