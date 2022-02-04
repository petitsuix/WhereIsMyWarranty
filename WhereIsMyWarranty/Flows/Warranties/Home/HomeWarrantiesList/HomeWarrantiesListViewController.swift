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

class HomeWarrantiesListViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: HomeWarrantiesListViewModel?
    
    // MARK: - Private properties
    
    private weak var coordinator: AppCoordinator?
    // private var warranties: [Warranty] = []
    
    private var categories: [Category] = []
    private var categoriesCollectionView: UICollectionView!
    private var warrantiesCollectionView: UICollectionView!
    
    private let navBarAppearance = UINavigationBarAppearance()
    private let newWarrantyButton = UIButton()
    private let addCategoryButton = UIButton()
    private let categoriesStackView = UIStackView()
    private let bottomBorder = UIView()
    
    private let noWarrantyStackView = UIStackView()
    private let noWarrantyTitleLabel = UILabel()
    private let noWarrantyBodyLabel = UILabel()
    private let noWarrantyImageView = UIImageView()
    // private let noWarranty
    
    // MARK: - Computed properties
    
    private var viewState: State<Void> = .loading {
        didSet {
            resetViewState() // Hides tableview, stops activity indicator animation
            switch viewState {
            case .loading :
                print("loading")
            case .empty :
                noWarrantyStackView.isHidden = false
                noWarrantyImageView.isHidden = false
                print("fell into the .empty case of viewState. That means the collectionView is empty.")
            case .error :
                alert("Oops...", "Something went wrong, please try again.")
                print("error : fell into the .error case of viewState")
            case .showData :
                warrantiesCollectionView.reloadData()
                categoriesCollectionView.reloadData()
                warrantiesCollectionView.isHidden = false
                categoriesCollectionView.isHidden = false
                noWarrantyStackView.isHidden = true
                noWarrantyImageView.isHidden = true
            }
        }
    }
    
    // MARK: - View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName = NSNotification.Name(rawValue: "warranties list updated")
        NotificationCenter.default.addObserver(self, selector: #selector(warrantiesUpdated), name: notificationName, object: nil)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchCategoriesFromDatabase()
        viewModel?.fetchWarrantiesFromDatabase()
        didFinishLoadingWarranties()
    }
    
    // MARK: - objc methods
    
    @objc func warrantiesUpdated() {
        viewModel?.fetchWarrantiesFromDatabase()
        didFinishLoadingWarranties()
    }
    
    @objc func newWarrantyButtonAction() {
        viewModel?.showNewWarrantyScreen()
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Nouvelle categorie", message: "Donnez lui un nom", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "ajouter", style: .default) { [unowned self] _ in
            guard let textfield = alert.textFields?.first, let categoryToSave = textfield.text else { return }
            viewModel?.saveCategory(categoryToSave: categoryToSave)
            viewModel?.fetchCategoriesFromDatabase()
            refresh()
        }
        let cancelAction = UIAlertAction(title: "annuler", style: .cancel)
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
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
}

// MARK: - View Configuration

extension HomeWarrantiesListViewController {
    private func setupView() {
        self.title = Strings.warrantiesTitle
        view.backgroundColor = .white
        
        noWarrantyTitleLabel.text = "Des garanties plein les poches ! 🦘"
        noWarrantyTitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        noWarrantyTitleLabel.textAlignment = .center
        
        noWarrantyBodyLabel.text = "appuyez ici pour commencer"
        noWarrantyBodyLabel.font = UIFont.preferredFont(forTextStyle: .body)
        noWarrantyBodyLabel.textAlignment = .center
        
        noWarrantyImageView.image = UIImage(named: "fancy-arrow")
        noWarrantyImageView.contentMode = .scaleAspectFit
        noWarrantyImageView.translatesAutoresizingMaskIntoConstraints = false
        
        noWarrantyStackView.axis = .vertical
        noWarrantyStackView.translatesAutoresizingMaskIntoConstraints = false
        
        noWarrantyStackView.addArrangedSubview(noWarrantyTitleLabel)
        noWarrantyStackView.addArrangedSubview(noWarrantyBodyLabel)
        noWarrantyStackView.setCustomSpacing(8, after: noWarrantyBodyLabel)
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: MWColor.bluegrey, .font: UIFont.systemFont(ofSize: 19, weight: .semibold)]
        navBarAppearance.backgroundColor = MWColor.paleOrange
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        addCategoryButton.backgroundColor = .white
        addCategoryButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small)), for: .normal)
        addCategoryButton.tintColor = MWColor.bluegrey
        categoriesStackView.addArrangedSubview(addCategoryButton)
        addCategoryButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        
        categoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        categoriesStackView.backgroundColor = .white
        categoriesStackView.spacing = 5.5
        
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = MWColor.bluegrey
        
        let categoriesLayout = UICollectionViewFlowLayout()
        categoriesLayout.scrollDirection = .horizontal
        // layout.itemSize = CGSize(width: view.frame.size.width/5, height: view.frame.size.width/13.5)
        categoriesLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: categoriesLayout) // self.view.frame c'est pareil ?
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(TopCategoriesCell.self, forCellWithReuseIdentifier: TopCategoriesCell.identifier)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = .white
        categoriesStackView.addArrangedSubview(categoriesCollectionView)
        
        let warrantiesLayout = UICollectionViewFlowLayout()
        warrantiesLayout.scrollDirection = .vertical
        warrantiesLayout.itemSize = CGSize(width: view.frame.size.width-16, height: view.frame.size.width/3.3)
        warrantiesLayout.minimumLineSpacing = 24
        warrantiesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: warrantiesLayout)
        warrantiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        warrantiesCollectionView.register(WarrantiesCell.self, forCellWithReuseIdentifier: WarrantiesCell.identifier)
        warrantiesCollectionView.dataSource = self
        warrantiesCollectionView.delegate = self
        
        newWarrantyButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .light, scale: .small)), for: .normal)
        newWarrantyButton.tintColor = MWColor.bluegrey
        newWarrantyButton.addTarget(self, action: #selector(newWarrantyButtonAction), for: .touchUpInside)
        newWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(categoriesStackView)
        view.addSubview(bottomBorder)
        view.addSubview(warrantiesCollectionView)
        view.addSubview(newWarrantyButton)
        view.addSubview(noWarrantyStackView)
        view.addSubview(noWarrantyImageView)
        
        NSLayoutConstraint.activate([
            noWarrantyStackView.bottomAnchor.constraint(equalTo: noWarrantyImageView.topAnchor, constant: -8),
            noWarrantyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            noWarrantyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            noWarrantyImageView.heightAnchor.constraint(equalToConstant: 100),
            noWarrantyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 36),
            noWarrantyImageView.bottomAnchor.constraint(equalTo: newWarrantyButton.topAnchor, constant: 0),
            
            categoriesCollectionView.heightAnchor.constraint(equalToConstant: 60),
            
            categoriesStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            categoriesStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            categoriesStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            categoriesStackView.heightAnchor.constraint(equalToConstant: 60),
            
            newWarrantyButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0),
            newWarrantyButton.heightAnchor.constraint(equalToConstant: 50),
            newWarrantyButton.widthAnchor.constraint(equalToConstant: 50),
            newWarrantyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
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

extension HomeWarrantiesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
            warrantyCellTapped(warranty: selectedWarranty)
        } else {
            //  storageService.selectedWarranty = viewModel.warranties[indexPath.row]
            
            guard let selectedCategory = viewModel?.categories[indexPath.row] else { return }
            
            categoryCellTapped(category: selectedCategory)
        }
        // displayWarrantiesFor(selectedCategory)
    }
}

// MARK: - Viewmodel delegate

extension HomeWarrantiesListViewController {
    
    func refresh() {
        viewState = .showData
    }
  
    func didFinishLoadingWarranties() {
        if viewModel?.warranties.isEmpty == true {
            viewState = .empty
        } else {
            viewState = .showData
        }
    }
}
