//
//  WarrantiesViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/11/2021.
//

import UIKit

enum State<Data> { // To execute particular actions according to the situation
    case loading
    case empty
    case error
    case showData
}

class WarrantiesViewController: UIViewController {
    
    
    // MARK: - Properties
    
    var viewModel: WarrantiesViewModel?
    
    // MARK: - Private properties
    
    private weak var coordinator: AppCoordinator?
    // private var warranties: [Warranty] = []
    
    private var categories: [Category] = []
    private var categoriesCollectionView: UICollectionView!
    private var warrantiesCollectionView: UICollectionView!
    
    private let navBarAppearance = UINavigationBarAppearance()
    private let addWarrantyButton = UIButton()
    private let addCategoryButton = UIButton()
    private let categoriesStackView = UIStackView()
    private let bottomBorder = UIView()
    
    // MARK: - Computed properties
    
    private var viewState: State<Void> = .loading {
        didSet {
            resetViewState() // Hides tableview, stops activity indicator animation
            switch viewState {
            case .loading :
                print("loading")
            case .empty :
                // displayNoWarrantiesView()
                print("fell into the .empty case of viewState. That means the collectionView is empty.")
            case .error :
                alert("Oops...", "Something went wrong, please try again.")
                print("error : fell into the .error case of viewState")
            case .showData :
                //self.warranties = warranties
                warrantiesCollectionView.reloadData()
                categoriesCollectionView.reloadData()
                warrantiesCollectionView.isHidden = false
                categoriesCollectionView.isHidden = false
            }
        }
    }
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchCategoriesFromDatabase()
        viewModel?.fetchWarrantiesFromDatabase()
        viewState = .showData
    }
    
    // MARK: - Methods
    
    func warrantyCellTapped(warranty: Warranty) {
        viewModel?.showWarrantyDetailsScreen(warranty: warranty)
    }
    
    func categoryCellTapped(category: Category) {
    }
    
    // MARK: - Private methods
    
    private func resetViewState() {
        warrantiesCollectionView.isHidden = true
    }
    
    
    // MARK: - objc methods
    @objc func addWarrantyButtonAction() {
        viewModel?.showNewWarrantyScreen()
        // coordinator?.showNewWarrantiesScreenFor(category: "MA SUPER CATEGORY")
    }
    
    @objc func addCategoryButtonAction() {
        viewModel?.showAddCategoryAlert()
    }
}
// MARK: - View Configuration

extension WarrantiesViewController {
    private func setupView() {
        // Ici
        // creation des lable
        // configuration des view
        // config stack view
        
        // nalayoutconstraint ....
        self.title = Strings.warrantiesTitle
        view.backgroundColor = .white
        configureNavigationBar()
        configureCategoriesStackView()
        configureBottomBorder()
        configureWarrantiesCollectionView()
        configureAddWarrantyButton()
        activateConstraints()
    }
    
    private func configureNavigationBar() {
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func configureBottomBorder() {
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = MWColor.bluegrey
        view.addSubview(bottomBorder)
    }
    
    private func displayNoWarrantiesView() {
        let noResultTextView = UITextView.init(frame: self.view.frame)
        noResultTextView.text = "\n\n\n\n\nOops, nothing to show here !"
        noResultTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
        noResultTextView.textColor = .systemGray
        noResultTextView.textAlignment = .center
        noResultTextView.isEditable = false
        noResultTextView.translatesAutoresizingMaskIntoConstraints = false
        noResultTextView.adjustsFontForContentSizeCategory = true
        view.addSubview(noResultTextView)
    }
    
    // MARK: categoriesCollectionView configuration
    
    private func configureCategoriesStackView() {
        categoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        categoriesStackView.backgroundColor = .white
        categoriesStackView.spacing = 5.5
        view.addSubview(categoriesStackView)
        configureAddCategoryButton()
        configureCategoriesCollectionView()
    }
    
    private func configureAddCategoryButton() {
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        addCategoryButton.backgroundColor = .white
        addCategoryButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small)), for: .normal)
        addCategoryButton.tintColor = MWColor.bluegrey
        categoriesStackView.addArrangedSubview(addCategoryButton)
        addCategoryButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    // showAlert is the alert displayed upon touching the "+" button.
    @objc func showAlert() {
        let alert = UIAlertController(title: "Nouvelle categorie", message: "Donnez lui un nom", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "ajouter", style: .default) { [unowned self] action in
            guard let textfield = alert.textFields?.first, let categoryToSave = textfield.text else { return }
            viewModel?.saveCategory(categoryToSave: categoryToSave)
            // FIXME: Comment refresh la collection view après le completion
            viewModel?.fetchCategoriesFromDatabase()
            refresh()
        }
        let cancelAction = UIAlertAction(title: "annuler", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func configureCategoriesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
       // layout.itemSize = CGSize(width: view.frame.size.width/5, height: view.frame.size.width/13.5)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // self.view.frame c'est pareil ?
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(TopCategoriesCell.self, forCellWithReuseIdentifier: TopCategoriesCell.identifier)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = .white
        categoriesStackView.addArrangedSubview(categoriesCollectionView)
    }
    
    // MARK: warrantiesCollectionView configuration
    
    private func configureWarrantiesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width-16, height: view.frame.size.width/3.3)
        layout.minimumLineSpacing = 24
        warrantiesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        warrantiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        warrantiesCollectionView.register(WarrantiesCell.self, forCellWithReuseIdentifier: WarrantiesCell.identifier)
        warrantiesCollectionView.dataSource = self
        warrantiesCollectionView.delegate = self
        warrantiesCollectionView.backgroundColor = .yellow
        view.addSubview(warrantiesCollectionView)
    }
    
    private func configureAddWarrantyButton() {
        addWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        addWarrantyButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small)), for: .normal)
        addWarrantyButton.tintColor = MWColor.bluegrey
        view.addSubview(addWarrantyButton)
        addWarrantyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addWarrantyButton.addTarget(self, action: #selector(addWarrantyButtonAction), for: .touchUpInside)
    }
    
    // MARK: Constraints
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            // FIXME: view.safeAreaLayoutGuide.topAnchor ??? Comment fixer une stackview à une navigationbar ?
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            categoriesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            categoriesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            categoriesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            categoriesStackView.heightAnchor.constraint(equalToConstant: 60),
            
            addWarrantyButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0),
            addWarrantyButton.heightAnchor.constraint(equalToConstant: 50),
            addWarrantyButton.widthAnchor.constraint(equalToConstant: 50),
            
            bottomBorder.heightAnchor.constraint(equalToConstant: 0.4),
            bottomBorder.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            bottomBorder.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            bottomBorder.topAnchor.constraint(equalToSystemSpacingBelow: categoriesStackView.bottomAnchor, multiplier: 0),
            
            warrantiesCollectionView.topAnchor.constraint(equalTo: bottomBorder.bottomAnchor, constant: 14),
            warrantiesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            warrantiesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            warrantiesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - CollectionViews configuration

extension WarrantiesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return user.categories.count
        if collectionView == categoriesCollectionView {
            return viewModel?.categories.count ?? 1 // On devrait pouvoir retourner user.categories.count
        } else {
            return viewModel?.warranties.count ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoriesCollectionView {
            guard let categoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCategoriesCell.identifier, for: indexPath) as? TopCategoriesCell else {
                assertionFailure("The dequeue collection view cell was of an unknown type!")
                return UICollectionViewCell()
            }
            categoryCell.category = viewModel?.categories[indexPath.row]
            return categoryCell
        } else {
            guard let warrantyCell = collectionView.dequeueReusableCell(withReuseIdentifier: WarrantiesCell.identifier, for: indexPath) as? WarrantiesCell else {
                assertionFailure("The dequeue collection view cell was of an unknown type!")
                return UICollectionViewCell()
            }
            warrantyCell.warranty = viewModel?.warranties[indexPath.row]
            return warrantyCell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected item nbr \(indexPath.row)")
        if collectionView == warrantiesCollectionView {
        guard let selectedWarranty = viewModel?.warranties[indexPath.row] else { return }
            warrantyCellTapped(warranty: selectedWarranty) }
        else {
        //  storageService.selectedWarranty = viewModel.warranties[indexPath.row]
        
        guard let selectedCategory = viewModel?.categories[indexPath.row] else { return }
        
        categoryCellTapped(category: selectedCategory)
        }
        // displayWarrantiesFor(selectedCategory)
    }
    
    /* func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
     let categoryCell = TopCategoriesCell()
     if collectionView == categoriesCollectionView {
     return categoryCell.titleLabel.frame.size
     } else {
     return CGSize(width: view.frame.size.width-16, height: view.frame.size.width/3.3)
     }
     } */
    
    
}

// MARK: - Viewmodel delegate

extension WarrantiesViewController {
    func refreshWith(warranties: [Warranty]) {
        if warranties.isEmpty {
            //   viewState = .empty // Displays "no results found" view
        } else {
            viewState = .showData
        }
        // pas de reloaddata ici
        //viewState = .showData(warranties)
    }
    
    func refresh() {
        viewState = .showData
    }
    
    func didFinishLoadingWarranties() {
        warrantiesCollectionView.reloadData()
    }
    
    func didFinishLoadingWarranties2() {
        if viewModel?.warranties.isEmpty == true {
            viewState = .empty
        } else {
            
            viewState = .showData
        }
    }
}
