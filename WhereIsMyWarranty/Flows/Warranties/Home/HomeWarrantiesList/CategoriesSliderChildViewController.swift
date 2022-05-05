//
//  CategoriesSliderChildViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 21/02/2022.
//

import UIKit

class CategoriesSliderChildViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum CategoriesSection {
        case main
    }
    
    private enum CategoryItem: Hashable {
        case category(Category, id: UUID = UUID())
    }
    
    // MARK: - Internal properties
    
    var viewModel: HomeWarrantiesListViewModel?
    
    // MARK: - Private properties
    
    private var categoriesCVDiffableDataSource: UICollectionViewDiffableDataSource<CategoriesSection, CategoryItem>!
    private var categories: [Category] = []
    
    private let addCategoryButton = UIButton()
    private var categoriesCollectionView: UICollectionView!
    private let categoriesStackView = UIStackView()
    private let bottomBorder = UIView()
    
    // MARK: - View life cycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchCategoriesFromDatabase()
        configureCategoriesCollectionViewDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setupView()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - objc methods
    
    @objc func showAlert() {
        let alert = UIAlertController(title: Strings.newCategory, message: Strings.giveItAName, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: Strings.add, style: .default) { [unowned self] _ in
            guard let textfield = alert.textFields?.first, let categoryToSave = textfield.text else { return }
            viewModel?.saveCategory(categoryToSave: categoryToSave)
            viewModel?.fetchCategoriesFromDatabase()
            if let categories = viewModel?.categories {
                let snapshot = createCategoriesSnapshot(array: categories)
                if let categoriesDiffDataSource = categoriesCVDiffableDataSource {
                    categoriesDiffDataSource.apply(snapshot)
                }
            }
        }
        let cancelAction = UIAlertAction(title: Strings.cancel, style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    // MARK: - Methods
    
    private func configureCategoriesCollectionViewDataSource() {
        categoriesCVDiffableDataSource =
        UICollectionViewDiffableDataSource<CategoriesSection, CategoryItem>(collectionView: categoriesCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .category(let result, _):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.categoryCellIdentifier, for: indexPath) as? TopCategoriesCell
                cell?.category = result
                return cell
            }
        })

        // Apply initial snapshot
        if let categories = viewModel?.categories {
            let snapshot = createCategoriesSnapshot(array: categories)
            categoriesCVDiffableDataSource.apply(snapshot)
        }
    }
    
    private func createCategoriesSnapshot(array: [Category]) -> NSDiffableDataSourceSnapshot<CategoriesSection, CategoryItem> {
        var snapshot = NSDiffableDataSourceSnapshot<CategoriesSection, CategoryItem>()
        snapshot.appendSections([CategoriesSection.main])
        let items = array.map { value in
            CategoryItem.category(value)
        }
        snapshot.appendItems(items, toSection: .main)
        return snapshot
    }
    
    private func categoryCellTapped(category: Category) {
        print("CategoriesCV cell tapped")
    }
}

// MARK: - CollectionViews configuration

extension CategoriesSliderChildViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedCategory = viewModel?.categories[indexPath.row] else { return }
        categoryCellTapped(category: selectedCategory)
    }
}

// MARK: - View Configuration

extension CategoriesSliderChildViewController {
    
    @available(iOS 15.0, *)
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, _ : NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            guard let sectionKind = self.categoriesCVDiffableDataSource.sectionIdentifier(for: sectionIndex) else { return nil }
            let section: NSCollectionLayoutSection
            
            switch sectionKind {
            case .main:
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .estimated(20),
                    heightDimension: .absolute(30)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.18),
                    heightDimension: .fractionalHeight(1)),
                                                               subitems: [item])
                group.interItemSpacing = .fixed(8)

                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            }
            return section
        }
        return layout
    }
    
    private func setupView() {
        view.backgroundColor = MWColor.white
        
        addCategoryButton.backgroundColor = MWColor.white
        addCategoryButton.setImage(MWImages.addCategoryButtonImage, for: .normal)
        addCategoryButton.tintColor = MWColor.bluegrey
        addCategoryButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
//        let categoriesLayout = UICollectionViewFlowLayout()
//        categoriesLayout.scrollDirection = .horizontal
//        categoriesLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        categoriesCollectionView.register(TopCategoriesCell.self, forCellWithReuseIdentifier: TopCategoriesCell.identifier)
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = MWColor.white
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        categoriesCollectionView.alwaysBounceVertical = false
        categoriesCollectionView.contentInset = UIEdgeInsets(top: 2.5, left: 0, bottom: 2, right: 0)
        
        categoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        categoriesStackView.backgroundColor = MWColor.white
        categoriesStackView.spacing = 6
        categoriesStackView.alignment = .fill
        categoriesStackView.distribution = .fill
        
        categoriesStackView.addArrangedSubview(addCategoryButton)
        categoriesStackView.addArrangedSubview(categoriesCollectionView)
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = MWColor.bluegrey
        
        view.addSubview(categoriesStackView)
        view.addSubview(bottomBorder)
         
        //colorization()
        
        NSLayoutConstraint.activate([
            categoriesStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            categoriesStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 1.0),
            categoriesStackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.5),
            bottomBorder.topAnchor.constraint(equalToSystemSpacingBelow: categoriesStackView.bottomAnchor, multiplier: 1.5),
            bottomBorder.heightAnchor.constraint(equalToConstant: 0.4),
            bottomBorder.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomBorder.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomBorder.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension CategoriesSliderChildViewController {
    func colorization() {
        categoriesCollectionView.backgroundColor = .orange
        categoriesStackView.backgroundColor = .yellow
    }
}
