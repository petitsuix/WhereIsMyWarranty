//
//  WarrantyExtraInfoViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 25/02/2022.
//

import UIKit

public enum WarrantyModalType {
    case newWarrantyModal
    case editWarrantyModal
    case showExtraInfo
}

class ExtraInfoViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case additionalProductInfo = 0
        case sellersInfo = 1
        case additionalNotes = 2
        func description() -> String {
            switch self {
            case .additionalProductInfo:
                return "Infos produit"
            case .sellersInfo:
                return "Infos vendeur"
            case .additionalNotes:
                return ""
            }
        }
    }
    
    enum Item: Hashable {
        case price
        case model
        case serialNumber
        case sellersName
        case sellersLocation
        case sellersContact
        case sellersWebsite
        case notes
        var placeholder: String {
            switch self {
            case .model:
                return "Modèle"
            case .serialNumber:
                return "Numéro de série"
            case .price:
                return "Prix"
            case .sellersName:
                return "Nom"
            case .sellersLocation:
                return "Adresse"
            case .sellersWebsite:
                return "Contact"
            case .sellersContact:
                return "Site web"
            case .notes:
                return "Notes"
            }
        }
    }
    
    var warrantyModalType: WarrantyModalType = .showExtraInfo
    var newWarrantyViewModel: NewWarrantyViewModel?
    var editWarrantyViewModel: EditWarrantyViewModel?
    
    private let extraInfoTitleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let parentStackView = UIStackView()
    private let endCurrentScreenButton = ActionButton()
    
    private var extraInfoTableViewDiffableDataSource: DataSource! = nil
    private var productInfoList: [Item] = [.price, .model, .serialNumber]
    private var sellersInfoItems: [Item] = [.sellersName, .sellersLocation, .sellersContact, .sellersWebsite]
    private var additionalNotesItem: [Item] = [.notes]
    
    // MARK: - View life cycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        setupView() // Setting up the view before configuring data source in viewDidLoad: doing the other way around causes crashes on versions before iOS 15
        startDodgingKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureExtraInfoTableViewDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopDodgingKeyboard()
    }
    
    // MARK: - objc methods
    
    @objc func saveWarranty() {
        let notesCell = tableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? TextViewTableViewCell // Unlike other cells, notes is a text view and cannot profit from the addTarget method to update the viewModel. Workaround found so far is to save its value here, when saving the warranty.
        if warrantyModalType == .newWarrantyModal {
            newWarrantyViewModel?.notes = notesCell?.textView.text
            newWarrantyViewModel?.saveWarranty()
        } else {
            editWarrantyViewModel?.notes = notesCell?.textView.text
            editWarrantyViewModel?.saveEditedWarranty()
        }
    }
    
    @objc func priceDidchange(textField: UITextField) {
        newWarrantyViewModel?.price = Double(textField.text!)
        editWarrantyViewModel?.price = Double(textField.text!)
    }
    
    @objc func modelDidChange(textField: UITextField) {
        newWarrantyViewModel?.model = textField.text
        editWarrantyViewModel?.model = textField.text
    }
    
    @objc func serialNumberDidChange(textField: UITextField) {
        newWarrantyViewModel?.serialNumber = textField.text
        editWarrantyViewModel?.serialNumber = textField.text
    }
    
    @objc func sellersNameDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersName = textField.text
        editWarrantyViewModel?.sellersName = textField.text
    }
    
    @objc func sellersLocationDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersLocation = textField.text
        editWarrantyViewModel?.sellersLocation = textField.text
    }
    
    @objc func sellersContactDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersContact = textField.text
        editWarrantyViewModel?.sellersContact = textField.text
    }
    
    @objc func sellersWebsiteDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersWebsite = textField.text
        editWarrantyViewModel?.sellersWebsite = textField.text
    }
    
    // MARK: - Methods
    //swiftlint:disable cyclomatic_complexity
    /// FIX ME : data source configuration method bellow initially created cells by switching on itemIdentifier. Depending on the case (.model, .price...), a cell was returned. But we needed to find a way to save the values held inside each
    /// cell's textField : both when creating and editing a warranty. Delegate method didSelectRowAt doesn't work, it is never called (probably because the interaction is handled by the textField right away, not the cell itself). Best way found
    /// so far is to add a target to the textField, create @objc methods that will be called upon editing. Another benefit is that while edtiting a warranty, only edited values are saved, instead of saving all values once again. But this method is very heavy.
    private func configureExtraInfoTableViewDataSource() {
        extraInfoTableViewDiffableDataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .notes :
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.notesCellIdentifier, for: indexPath) as? TextViewTableViewCell
                cell?.placeholder = itemIdentifier.placeholder
                if self.warrantyModalType == .editWarrantyModal {
                    cell?.textView.text = self.editWarrantyViewModel?.warranty.notes
                }
                cell?.textView.delegate = self
                return cell
            default :
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = itemIdentifier.placeholder
                
                if itemIdentifier == .price, self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = String(self.editWarrantyViewModel?.warranty.price ?? 0)
                    cell?.textField.addTarget(self, action: #selector(self.priceDidchange), for: .editingChanged)
//                    cell?.textField.delegate = self
                    cell?.textField.keyboardType = .decimalPad
                } else if itemIdentifier == .price, self.warrantyModalType == .newWarrantyModal {
                    cell?.textField.addTarget(self, action: #selector(self.priceDidchange), for: .editingChanged)
                    cell?.textField.keyboardType = .decimalPad
                }
                if itemIdentifier == .model, self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = self.editWarrantyViewModel?.warranty.model
                    cell?.textField.addTarget(self, action: #selector(self.modelDidChange), for: .editingChanged)
                } else if itemIdentifier == .model, self.warrantyModalType == .newWarrantyModal {
                    cell?.textField.addTarget(self, action: #selector(self.modelDidChange), for: .editingChanged)
                }
                if itemIdentifier == .serialNumber, self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = self.editWarrantyViewModel?.warranty.serialNumber
                    cell?.textField.addTarget(self, action: #selector(self.serialNumberDidChange), for: .editingChanged)
                } else if itemIdentifier == .serialNumber, self.warrantyModalType == .newWarrantyModal {
                    cell?.textField.addTarget(self, action: #selector(self.serialNumberDidChange), for: .editingChanged)
                }
                if itemIdentifier == .sellersName, self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = self.editWarrantyViewModel?.warranty.sellersName
                    cell?.textField.addTarget(self, action: #selector(self.sellersNameDidChange), for: .editingChanged)
                } else if itemIdentifier == .sellersName, self.warrantyModalType == .newWarrantyModal {
                    cell?.textField.addTarget(self, action: #selector(self.sellersNameDidChange), for: .editingChanged)
                }
                if itemIdentifier == .sellersLocation, self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = self.editWarrantyViewModel?.warranty.sellersLocation
                    cell?.textField.addTarget(self, action: #selector(self.sellersLocationDidChange), for: .editingChanged)
                } else if itemIdentifier == .sellersLocation, self.warrantyModalType == .newWarrantyModal {
                    cell?.textField.addTarget(self, action: #selector(self.sellersLocationDidChange), for: .editingChanged)
                }
                if itemIdentifier == .sellersContact, self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = self.editWarrantyViewModel?.warranty.sellersContact
                    cell?.textField.addTarget(self, action: #selector(self.sellersContactDidChange), for: .editingChanged)
                } else if itemIdentifier == .sellersContact, self.warrantyModalType == .newWarrantyModal {
                    cell?.textField.addTarget(self, action: #selector(self.sellersContactDidChange), for: .editingChanged)
                }
                if itemIdentifier == .sellersWebsite, self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = self.editWarrantyViewModel?.warranty.sellersWebsite
                    cell?.textField.addTarget(self, action: #selector(self.sellersWebsiteDidChange), for: .editingChanged)
                } else if itemIdentifier == .sellersWebsite, self.warrantyModalType == .newWarrantyModal {
                    cell?.textField.addTarget(self, action: #selector(self.sellersWebsiteDidChange), for: .editingChanged)
                }
                return cell
            }
        })
        let snapshot = createExtraInfosSnapshot()
        extraInfoTableViewDiffableDataSource.apply(snapshot)
    }
    
    private func createExtraInfosSnapshot() -> NSDiffableDataSourceSnapshot<Section, Item> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.additionalProductInfo, .sellersInfo, .additionalNotes])
        snapshot.appendItems(productInfoList, toSection: .additionalProductInfo)
        snapshot.appendItems(sellersInfoItems, toSection: .sellersInfo)
        snapshot.appendItems(additionalNotesItem, toSection: .additionalNotes)
        return snapshot
    }
}

extension ExtraInfoViewController: UITableViewDelegate, UITextViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Section.additionalNotes.rawValue {
            return 120
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.textLabel?.textColor = UIColor.label
            }
    }
}

private extension ExtraInfoViewController {
    
    enum Constant {
        static let notesCellIdentifier = "AdditionalNotesTableViewCell"
        static let extraInfoCellIdentifier = "ExtraInfoTableViewCell"
    }
    
    func setupView() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deletionAlert))
        
        extraInfoTitleLabel.text = "\tInfos complémentaires"
        extraInfoTitleLabel.textColor = MWColor.label
        extraInfoTitleLabel.font = MWFont.modalMainTitle
        extraInfoTitleLabel.textAlignment = .natural
        tableView.delegate = self
        tableView.backgroundColor = MWColor.background
        
        endCurrentScreenButton.setup(title: Strings.saveButtonTitle)
        endCurrentScreenButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
        
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 20
        parentStackView.addArrangedSubview(extraInfoTitleLabel)
        parentStackView.addArrangedSubview(tableView)
        
        view.backgroundColor = MWColor.background
        view.addSubview(parentStackView)
        view.addSubview(endCurrentScreenButton)
        
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            parentStackView.bottomAnchor.constraint(equalTo: endCurrentScreenButton.topAnchor, constant: -16),
            endCurrentScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endCurrentScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            endCurrentScreenButton.heightAnchor.constraint(equalToConstant: 55),
            endCurrentScreenButton.widthAnchor.constraint(equalToConstant: 170)
        ])
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: Constant.extraInfoCellIdentifier)
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: Constant.notesCellIdentifier)
    }
}

private extension ExtraInfoViewController {
    class DataSource: UITableViewDiffableDataSource<Section, Item> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
        override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return false
        }
    }
}
