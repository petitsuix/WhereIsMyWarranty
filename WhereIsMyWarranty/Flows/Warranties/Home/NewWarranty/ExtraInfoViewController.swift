//
//  WarrantyExtraInfoViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 25/02/2022.
//

import UIKit

class ExtraInfoViewController: UIViewController {
    
    enum Section: CaseIterable {
        case additionalProductInfo, sellersInfo, additionalNotes
    }
    
    enum ItemType: Hashable {
        case textFieldItem(id: UUID = UUID()), textViewItem
    }
    
//    struct Item: Hashable {
//        let placeHolder: String
//        let type: ItemType
//
//        init(placeHolder: String, type: ItemType) {
//            self.placeHolder = placeHolder
//            self.type = type
//            self.identifier = UUID()
//        }
//
//        private let identifier: UUID
//        func hash(into hasher: inout Hasher) {
//            hasher.combine(self.identifier)
//        }
//    }
    
    var viewModel: NewWarrantyViewModel?
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let endCurrentScreenButton = WarrantyModalNextStepButton()

    var extraInfoTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, ItemType>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, ItemType>! = nil
    var itemsList: [ItemType] = [.textFieldItem(), .textFieldItem()]
    var sellersInfoItems: [ItemType] = [.textFieldItem(), .textFieldItem()]
    var additionalNotesItem: [ItemType] = [.textViewItem]

    
    // MARK: - View life cycle methods

    override func viewWillAppear(_ animated: Bool) {
        configureExtraInfoTableViewDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // view.backgroundColor = .orange
       setup()
    }
    
    // MARK: - objc methods
    
    @objc func saveWarranty() {
        viewModel?.saveWarranty()
    }
    
    // MARK: - Methods
    
    func configureExtraInfoTableViewDataSource() {
        extraInfoTableViewDiffableDataSource = UITableViewDiffableDataSource
        <Section, ItemType>(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .textFieldItem:
                let cell = tableView.dequeueReusableCell(withIdentifier: Strings.extraInfoCellIdentifier, for: indexPath) as? ExtraInfoCell
                cell?.textField.placeholder = "Bonjour"
                return cell
            case .textViewItem:
                let cell = tableView.dequeueReusableCell(withIdentifier: Strings.extraInfoCellIdentifier, for: indexPath) as? ExtraInfoCell
                cell?.textField.placeholder = "Notes"
                return cell
            }
        })
        let snapshot = createExtraInfosSnapshot()
        extraInfoTableViewDiffableDataSource.apply(snapshot)
    }
    
    func createExtraInfosSnapshot() -> NSDiffableDataSourceSnapshot<Section, ItemType> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemType>()
        snapshot.appendSections([.additionalProductInfo, .sellersInfo, .additionalNotes])
        let items = itemsList
        snapshot.appendItems(items, toSection: .additionalProductInfo)
        snapshot.appendItems(sellersInfoItems, toSection: .sellersInfo)
        snapshot.appendItems(additionalNotesItem, toSection: .additionalNotes)
        return snapshot
    }
    
    private func extraInfoCellTapped() {
        print("CategoriesCV cell tapped")
    }
}

extension ExtraInfoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        extraInfoCellTapped()
    }
}

extension ExtraInfoViewController {
    
    func setup() {
        view.backgroundColor = MWColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        endCurrentScreenButton.setup(title: Strings.saveButtonTitle)
        endCurrentScreenButton.addTarget(self, action: #selector(saveWarranty), for: .touchUpInside)
        view.addSubview(tableView)
        view.addSubview(endCurrentScreenButton)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: endCurrentScreenButton.topAnchor, constant: -16),
            endCurrentScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            endCurrentScreenButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            endCurrentScreenButton.heightAnchor.constraint(equalToConstant: 55),
            endCurrentScreenButton.widthAnchor.constraint(equalToConstant: 170)
            ])
        tableView.register(ExtraInfoCell.self, forCellReuseIdentifier: ExtraInfoCell.identifier)
        tableView.register(AdditionalNotesCell.self, forCellReuseIdentifier: AdditionalNotesCell.identifier)
    }
    
//    private func layoutWithMultipleSections() -> UICollectionViewLayout {
//        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _ : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//            guard let sectionKind = self.extraInfoTableViewDiffableDataSource.sectionIdentifier(for: sectionIndex) else { return nil }
//            let section: NSCollectionLayoutSection
//
//            switch sectionKind {
//            case .additionalProductInfo:
//                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalWidth(1/10)))
//
//                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalWidth(1/10)),
//                                                               subitems: [item])
//
//                section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .none
//            case .sellersInfo:
//                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalWidth(1/10)))
//
//                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalWidth(1/10)),
//                                                               subitems: [item])
//
//                section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .none
//            case .additionalNotes:
//                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalWidth(1/10)))
//
//                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//                    widthDimension: .fractionalWidth(1),
//                    heightDimension: .fractionalWidth(1/10)),
//                                                               subitems: [item])
//
//                section = NSCollectionLayoutSection(group: group)
//                section.orthogonalScrollingBehavior = .none
//            }
//            return section
//        }
//        return layout
//    }
}
