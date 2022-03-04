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
    
    enum ItemType {
        case textFieldItem, textViewItem
    }
    
    struct Item: Hashable {
        let placeHolder: String
        let type: ItemType
        
        init(placeHolder: String, type: ItemType) {
            self.placeHolder = placeHolder
            self.type = type
            self.identifier = UUID()
        }
        
        private let identifier: UUID
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.identifier)
        }
    }
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    let endCurrentScreenButton = WarrantyModalNextStepButton()

    var extraInfoTableViewDiffableDataSource: UITableViewDiffableDataSource<Section, ItemType>! = nil
    var currentSnapshot: NSDiffableDataSourceSnapshot<Section, Item>! = nil
    lazy var itemsList: [ItemType] = [ItemType.textFieldItem, ItemType.textFieldItem, ItemType.textFieldItem]
    
    // MARK: - View life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
                cell?.textField.placeholder = "Bonjour"
                return cell
            }
        })
        let snapshot = createExtraInfosSnapshot()
        extraInfoTableViewDiffableDataSource.apply(snapshot)
    }
    
    func createExtraInfosSnapshot() -> NSDiffableDataSourceSnapshot<Section, ItemType> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ItemType>()
        snapshot.appendSections([Section.additionalProductInfo, Section.sellersInfo, Section.additionalNotes])
        let items = itemsList
        snapshot.appendItems(items, toSection: .additionalProductInfo)
        return snapshot
    }
}

extension ExtraInfoViewController {
    
    private func layoutWithMultipleSections() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _ : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = self.extraInfoTableViewDiffableDataSource.sectionIdentifier(for: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            case .additionalProductInfo:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/10)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/10)),
                                                               subitems: [item])

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
            case .sellersInfo:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/10)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/10)),
                                                               subitems: [item])

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
            case .additionalNotes:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/10)))
                
                let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/10)),
                                                               subitems: [item])

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .none
            }
            return section
        }
        return layout
    }
    
    func configureExtraInfoTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        tableView.register(ExtraInfoCell.self, forCellReuseIdentifier: ExtraInfoCell.identifier)
    }
    
}
