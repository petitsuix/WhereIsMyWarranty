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
    
    var warrantyModalType: WarrantyModalType = .newWarrantyModal
    var newWarrantyViewModel: NewWarrantyViewModel?
    var editWarrantyViewModel: EditWarrantyViewModel?
    
    private let extraInfoTitleLabel = UILabel()
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let parentStackView = UIStackView()
    private let endCurrentScreenButton = WarrantyModalNextStepButton()
    
    private var extraInfoTableViewDiffableDataSource: DataSource! = nil
    private var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Item>! = nil
    private var productInfoList: [Item] = [.price, .model, .serialNumber]
    private var sellersInfoItems: [Item] = [.sellersName, .sellersLocation, .sellersContact, .sellersWebsite]
    private var additionalNotesItem: [Item] = [.notes]
    
    // MARK: - View life cycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        configureExtraInfoTableViewDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - objc methods
    
    var currentObject: NSObject?
    var row = 0
    
    @objc func saveWarranty() {
            if warrantyModalType == .newWarrantyModal {
                newWarrantyViewModel?.saveWarranty()
            } else {
                editWarrantyViewModel?.saveEditedWarranty()
            }
    }
    
    // MARK: - Methods
    
    @objc func priceDidchange(textField: UITextField) {
       // newWarrantyViewModel?.price = Double(textField.text!)
        editWarrantyViewModel?.price = Double(textField.text!)
        print("\(newWarrantyViewModel?.price ?? 0)")
        print("\(editWarrantyViewModel?.price ?? 0)")
    }
    
    @objc func modelDidChange(textField: UITextField) {
        newWarrantyViewModel?.model = textField.text
        editWarrantyViewModel?.model = textField.text
        print("\(newWarrantyViewModel?.model ?? "")")
        print("\(editWarrantyViewModel?.model ?? "")")
    }
    
    @objc func serialNumberDidChange(textField: UITextField) {
        newWarrantyViewModel?.serialNumber = textField.text
        editWarrantyViewModel?.serialNumber = textField.text
        print("\(newWarrantyViewModel?.serialNumber ?? "")")
        print("\(editWarrantyViewModel?.serialNumber ?? "")")
    }
    
    @objc func sellersNameDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersName = textField.text
        editWarrantyViewModel?.sellersName = textField.text
        print("\(newWarrantyViewModel?.sellersName ?? "")")
        print("\(editWarrantyViewModel?.sellersName ?? "")")
    }
    
    @objc func sellersLocationDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersLocation = textField.text
        editWarrantyViewModel?.sellersLocation = textField.text
        print("\(newWarrantyViewModel?.sellersLocation ?? "")")
        print("\(editWarrantyViewModel?.sellersLocation ?? "")")
    }
    
    @objc func sellersContactDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersContact = textField.text
        editWarrantyViewModel?.sellersContact = textField.text
        print("\(newWarrantyViewModel?.sellersContact ?? "")")
        print("\(editWarrantyViewModel?.sellersContact ?? "")")
    }
    
    @objc func sellersWebsiteDidChange(textField: UITextField) {
        newWarrantyViewModel?.sellersWebsite = textField.text
        editWarrantyViewModel?.sellersWebsite = textField.text
        print("\(newWarrantyViewModel?.sellersWebsite ?? "")")
        print("\(editWarrantyViewModel?.sellersWebsite ?? "")")
    }
    
    private func configureExtraInfoTableViewDataSource() {
        extraInfoTableViewDiffableDataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
            cell?.placeholder = itemIdentifier.placeholder
            
            if itemIdentifier == .price, self.warrantyModalType == .editWarrantyModal {
                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.price ?? 0)
                cell?.textField.addTarget(self, action: #selector(self.priceDidchange), for: .editingChanged)
            }
             else if itemIdentifier == .price, self.warrantyModalType == .newWarrantyModal {
                cell?.textField.addTarget(self, action: #selector(self.priceDidchange), for: .editingChanged)
            }
            if itemIdentifier == .model, self.warrantyModalType == .editWarrantyModal {
                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.model ?? "")
                cell?.textField.addTarget(self, action: #selector(self.modelDidChange), for: .editingChanged)
            }
             else if itemIdentifier == .model, self.warrantyModalType == .newWarrantyModal {
                cell?.textField.addTarget(self, action: #selector(self.modelDidChange), for: .editingChanged)
            }
            if itemIdentifier == .serialNumber, self.warrantyModalType == .editWarrantyModal {
                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.serialNumber ?? "")
                cell?.textField.addTarget(self, action: #selector(self.serialNumberDidChange), for: .editingChanged)
            }
             else if itemIdentifier == .serialNumber, self.warrantyModalType == .newWarrantyModal {
                cell?.textField.addTarget(self, action: #selector(self.serialNumberDidChange), for: .editingChanged)
            }
            if itemIdentifier == .sellersName, self.warrantyModalType == .editWarrantyModal {
                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.sellersName ?? "")
                cell?.textField.addTarget(self, action: #selector(self.sellersNameDidChange), for: .editingChanged)
            }
             else if itemIdentifier == .sellersName, self.warrantyModalType == .newWarrantyModal {
                cell?.textField.addTarget(self, action: #selector(self.sellersNameDidChange), for: .editingChanged)
            }
            if itemIdentifier == .sellersLocation, self.warrantyModalType == .editWarrantyModal {
                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.sellersLocation ?? "")
                cell?.textField.addTarget(self, action: #selector(self.sellersLocationDidChange), for: .editingChanged)
            }
             else if itemIdentifier == .sellersLocation, self.warrantyModalType == .newWarrantyModal {
                cell?.textField.addTarget(self, action: #selector(self.sellersLocationDidChange), for: .editingChanged)
            }
            if itemIdentifier == .sellersContact, self.warrantyModalType == .editWarrantyModal {
                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.sellersContact ?? "")
                cell?.textField.addTarget(self, action: #selector(self.sellersContactDidChange), for: .editingChanged)
            }
             else if itemIdentifier == .sellersContact, self.warrantyModalType == .newWarrantyModal {
                cell?.textField.addTarget(self, action: #selector(self.sellersContactDidChange), for: .editingChanged)
            }
            if itemIdentifier == .sellersWebsite, self.warrantyModalType == .editWarrantyModal {
                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.sellersWebsite ?? "")
                cell?.textField.addTarget(self, action: #selector(self.sellersWebsiteDidChange), for: .editingChanged)
            }
             else if itemIdentifier == .sellersWebsite, self.warrantyModalType == .newWarrantyModal {
                cell?.textField.addTarget(self, action: #selector(self.sellersWebsiteDidChange), for: .editingChanged)
            }
            
//            if itemIdentifier == .notes, self.warrantyModalType == .editWarrantyModal {
//                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.notes ?? "")
//            }
            
            return cell
            
//            switch itemIdentifier {
//            case .price :
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//                cell?.placeholder = "Prix"
//                if self.warrantyModalType == .editWarrantyModal {
//                    cell?.textField.text = String(self.editWarrantyViewModel?.warranty.price ?? 0)
//                }
//
//                return cell
//            case .model:
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//                cell?.placeholder = "Modèle"
//                return cell
//            case .serialNumber:
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//                cell?.placeholder = "Numéro de série"
//                return cell
//            case .sellersName:
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//                cell?.placeholder = "Nom"
//                return cell
//            case .sellersLocation:
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//                cell?.placeholder = "Adresse"
//                return cell
//            case .sellersContact:
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//                cell?.placeholder = "Contact"
//                return cell
//            case .sellersWebsite:
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//                cell?.placeholder = "Site web"
//                return cell
//            case .notes:
//                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.notesCellIdentifier, for: indexPath) as? TextViewTableViewCell
//                cell?.placeholder = "Notes"
//                return cell
//            }
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
    
    private func extraInfoCellTapped() {
        print("cell tapped")
    }
}

extension ExtraInfoViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        extraInfoCellTapped()
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        if let textFieldText = cell?.textField.text {
//            if warrantyModalType == .newWarrantyModal {
//                newWarrantyViewModel?.price = Double(textFieldText)
//              //  newWarrantyViewModel?.model =
//                newWarrantyViewModel?.saveWarranty()
//            } else {
//                editWarrantyViewModel?.price = Double(textFieldText)
//                editWarrantyViewModel?.saveEditedWarranty()
//            }
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Section.additionalNotes.rawValue {
            return 120
        } else {
            return 50
        }
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView()
    //        view.backgroundColor = .orange
    //        return view
    //    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
}

private extension ExtraInfoViewController {
    
    // FIXME: Est-ce que ça se range avec les helpers ?
    enum Constant {
        static let notesCellIdentifier = "AdditionalNotesTableViewCell"
        static let extraInfoCellIdentifier = "ExtraInfoTableViewCell"
    }
    
    func setupView() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(deletionAlert))
        
        extraInfoTitleLabel.text = "\tInfos complémentaires"
        extraInfoTitleLabel.textColor = MWColor.black
        extraInfoTitleLabel.font = MWFont.modalMainTitle
        extraInfoTitleLabel.textAlignment = .natural
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 0.8973447084, green: 0.9166073203, blue: 0.9072605968, alpha: 1)
        endCurrentScreenButton.setup(title: Strings.saveButtonTitle)
        endCurrentScreenButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
        parentStackView.translatesAutoresizingMaskIntoConstraints = false
        parentStackView.axis = .vertical
        parentStackView.spacing = 20
        parentStackView.addArrangedSubview(extraInfoTitleLabel)
        parentStackView.addArrangedSubview(tableView)
        
        view.backgroundColor = #colorLiteral(red: 0.8973447084, green: 0.9166073203, blue: 0.9072605968, alpha: 1)
        view.addSubview(parentStackView)
        view.addSubview(endCurrentScreenButton)
        
        NSLayoutConstraint.activate([
            parentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            parentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            parentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            parentStackView.bottomAnchor.constraint(equalTo: endCurrentScreenButton.topAnchor, constant: -16),
            endCurrentScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endCurrentScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            endCurrentScreenButton.heightAnchor.constraint(equalToConstant: 55),
            endCurrentScreenButton.widthAnchor.constraint(equalToConstant: 170)
        ])
        tableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: Constant.extraInfoCellIdentifier)
        tableView.register(TextViewTableViewCell.self, forCellReuseIdentifier: Constant.notesCellIdentifier)
    }
    
    func setupData() {
        
    }
}

// peut etre faire un fichier a part-entiere extrainfodatasource
extension ExtraInfoViewController {
    class DataSource: UITableViewDiffableDataSource<Section, Item> {
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            let sectionKind = Section(rawValue: section)
            return sectionKind?.description()
        }
    }
}
