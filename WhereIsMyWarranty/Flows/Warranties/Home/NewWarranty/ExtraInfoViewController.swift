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
//        var placeholder: String {
//            // switch self etc
//        }
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
    
    // faire une méthode et passer en paramètre indexpath, passer en paramètre le type de variable (price, model, serial number...)
    @objc func saveWarranty() {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldTableViewCell
        if let textFieldText = cell?.textField.text {
            if warrantyModalType == .newWarrantyModal {
                newWarrantyViewModel?.price = Double(textFieldText)
              //  newWarrantyViewModel?.model =
                newWarrantyViewModel?.saveWarranty()
            } else {
                editWarrantyViewModel?.price = Double(textFieldText)
                editWarrantyViewModel?.saveEditedWarranty()
            }
        }
    }
    
    // MARK: - Methods
    
    @objc func priceDidchange(textField: UITextField) {
        newWarrantyViewModel?.price = Double(textField.text!)
        print("\(newWarrantyViewModel?.price)")
    }
    private func configureExtraInfoTableViewDataSource() {
        extraInfoTableViewDiffableDataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
//            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
//           // cell?.placeholder = itemIdentifier.placeholder
//            if itemIdentifier == .price, self.warrantyModalType == .editWarrantyModal {
//                cell?.textField.text = String(self.editWarrantyViewModel?.warranty.price ?? 0)
//            }
//            return cell
            switch itemIdentifier {
            case .price :
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = "Prix"
                if self.warrantyModalType == .editWarrantyModal {
                    cell?.textField.text = String(self.editWarrantyViewModel?.warranty.price ?? 0)
                }
                cell?.textField.addTarget(self, action:#selector(self.priceDidchange), for: .editingChanged)
                return cell
            case .model:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = "Modèle"
                return cell
            case .serialNumber:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = "Numéro de série"
                return cell
            case .sellersName:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = "Nom"
                return cell
            case .sellersLocation:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = "Adresse"
                return cell
            case .sellersContact:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = "Contact"
                return cell
            case .sellersWebsite:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.extraInfoCellIdentifier, for: indexPath) as? TextFieldTableViewCell
                cell?.placeholder = "Site web"
                return cell
            case .notes:
                let cell = tableView.dequeueReusableCell(withIdentifier: Constant.notesCellIdentifier, for: indexPath) as? TextViewTableViewCell
                cell?.placeholder = "Notes"
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
        view.backgroundColor = #colorLiteral(red: 0.8973447084, green: 0.9166073203, blue: 0.9072605968, alpha: 1)
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
