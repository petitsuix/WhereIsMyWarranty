//
//  WarrantiesViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/11/2021.
//

import UIKit

enum State { // To execute particular actions according to the situation
    case empty
    case error
    case showData
}

class HomeWarrantiesListViewController: UIViewController {
    
    // MARK: - Enums
    
    private enum WarrantiesSection {
        case main
    }
    
    private enum WarrantyItem: Hashable {
        case warranty(Warranty, id: UUID = UUID())
    }
    
    // MARK: - Internal properties
    
    var viewModel: HomeWarrantiesListViewModel?
    
    // MARK: - Private properties
    
    private weak var coordinator: AppCoordinator?
    private var warrantiesCVDiffableDataSource: UICollectionViewDiffableDataSource<WarrantiesSection, WarrantyItem>!
    
    private var warrantiesCollectionView: UICollectionView!
    
    private let navBarAppearance = UINavigationBarAppearance()
    
    // TODO:
    private let editCategoriesButton = UIButton()
    
    private let newWarrantyButton = UIButton()
    
    private let noWarrantyTitleLabel = UILabel()
    private let noWarrantyBodyLabel = UILabel()
    private let noWarrantyImageView = UIImageView()
    private let noWarrantyStackView = UIStackView()
    
    // MARK: - Computed properties
    
    private var viewState: State = .showData {
        didSet {
            switch viewState {
            case .empty :
                noWarrantyStackView.isHidden = false
                noWarrantyImageView.isHidden = false
            case .error :
                alert(Strings.oops, Strings.somethingWentWrong)
            case .showData :
                noWarrantyStackView.isHidden = true
                noWarrantyImageView.isHidden = true
            }
        }
    }
    
    // MARK: - View life cycle methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchWarrantiesFromDatabase()
        configureWarrantiesCollectionViewDataSource()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName = NSNotification.Name(rawValue: Strings.warrantiesListUpdatedNotif)
        NotificationCenter.default.addObserver(self, selector: #selector(warrantiesUpdated), name: notificationName, object: nil)
        
        setupView()
    }
    
    // MARK: - objc methods
    
    @objc func warrantiesUpdated() {
        viewModel?.fetchWarrantiesFromDatabase()
        if let warranties = viewModel?.warranties {
            let snapshot = createWarrantiesSnapshot(array: warranties)
            warrantiesCVDiffableDataSource.apply(snapshot)
        }
        didFinishLoadingWarranties()
    }
    
    @objc func newWarrantyButtonAction() {
        viewModel?.showNewWarrantyScreen()
    }
    
    // MARK: - Methods
    
    private func configureWarrantiesCollectionViewDataSource() {
        warrantiesCVDiffableDataSource =
        UICollectionViewDiffableDataSource<WarrantiesSection, WarrantyItem>(collectionView: warrantiesCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .warranty(let result, _):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.warrantyCellIdentifier, for: indexPath) as? WarrantiesCell
                cell?.warranty = result
                return cell
            }
        })
        // Apply initial snapshot
        if let warranties = viewModel?.warranties {
            let snapshot = createWarrantiesSnapshot(array: warranties)
            warrantiesCVDiffableDataSource.apply(snapshot)
        }
    }
    
    private func createWarrantiesSnapshot(array: [Warranty]) -> NSDiffableDataSourceSnapshot<WarrantiesSection, WarrantyItem> {
        var snapshot = NSDiffableDataSourceSnapshot<WarrantiesSection, WarrantyItem>()
        snapshot.appendSections([WarrantiesSection.main])
        let items = array.map { value in
            WarrantyItem.warranty(value)
        }
        snapshot.appendItems(items, toSection: .main)
        return snapshot
    }
    
    private func warrantyCellTapped(warranty: Warranty) {
        viewModel?.showWarrantyDetailsScreen(warranty: warranty)
    }
}

// MARK: - CollectionViews configuration

extension HomeWarrantiesListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedWarranty = viewModel?.warranties[indexPath.row] else { return }
        warrantyCellTapped(warranty: selectedWarranty)
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

// MARK: - View Configuration

extension HomeWarrantiesListViewController {
    private func setupView() {
        self.title = Strings.warrantiesTitle
        view.backgroundColor = MWColor.white
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: MWColor.bluegrey, .font: MWFont.navBar]
        navBarAppearance.backgroundColor = MWColor.paleOrange
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        noWarrantyTitleLabel.text = Strings.warrantiesInMyPockets
        noWarrantyTitleLabel.font = MWFont.title3
        noWarrantyTitleLabel.textAlignment = .center
        
        noWarrantyBodyLabel.text = Strings.tapHereToStart
        noWarrantyBodyLabel.font = MWFont.body
        noWarrantyBodyLabel.textAlignment = .center
        
        noWarrantyImageView.translatesAutoresizingMaskIntoConstraints = false
        noWarrantyImageView.image = MWImages.arrow
        noWarrantyImageView.contentMode = .scaleAspectFit
        
        noWarrantyStackView.translatesAutoresizingMaskIntoConstraints = false
        noWarrantyStackView.axis = .vertical
        
        noWarrantyStackView.addArrangedSubview(noWarrantyTitleLabel)
        noWarrantyStackView.addArrangedSubview(noWarrantyBodyLabel)
        noWarrantyStackView.setCustomSpacing(8, after: noWarrantyBodyLabel)
        
        //        showAllWarrantiesCategoryButton.setTitle("  Tout  ", for: .normal)
        //        showAllWarrantiesCategoryButton.setTitleColor(MWColor.bluegrey, for: .normal)
        //        showAllWarrantiesCategoryButton.setTitleColor(MWColor.red, for: .selected)
        //        showAllWarrantiesCategoryButton.layer.borderColor = MWColor.bluegrey.cgColor
        //        showAllWarrantiesCategoryButton.layer.borderWidth = 1
        //        showAllWarrantiesCategoryButton.roundingViewCorners(radius: 14.8)
        
        
        let warrantiesLayout = UICollectionViewFlowLayout()
        warrantiesLayout.scrollDirection = .vertical
        warrantiesLayout.itemSize = CGSize(width: view.frame.size.width-16, height: view.frame.size.width/3.3)
        warrantiesLayout.minimumLineSpacing = 24
        warrantiesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: warrantiesLayout)
        warrantiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        warrantiesCollectionView.register(WarrantiesCell.self, forCellWithReuseIdentifier: WarrantiesCell.identifier)
        warrantiesCollectionView.delegate = self
        
        newWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        newWarrantyButton.setImage(MWImages.newWarrantyButtonImage, for: .normal)
        newWarrantyButton.tintColor = MWColor.bluegrey
        newWarrantyButton.addTarget(self, action: #selector(newWarrantyButtonAction), for: .touchUpInside)
        
        let categoriesSliderChildVC = CategoriesSliderChildViewController()
        categoriesSliderChildVC.view.translatesAutoresizingMaskIntoConstraints = false
        categoriesSliderChildVC.viewModel = viewModel
        add(categoriesSliderChildVC)
        view.addSubview(warrantiesCollectionView)
        view.addSubview(newWarrantyButton)
        view.addSubview(noWarrantyStackView)
        view.addSubview(noWarrantyImageView)
        
        colorization()
        
        NSLayoutConstraint.activate([
            noWarrantyStackView.bottomAnchor.constraint(equalTo: noWarrantyImageView.topAnchor, constant: -8),
            noWarrantyStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            noWarrantyStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            noWarrantyImageView.heightAnchor.constraint(equalToConstant: 100),
            noWarrantyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 36),
            noWarrantyImageView.bottomAnchor.constraint(equalTo: newWarrantyButton.topAnchor, constant: 0),
            
            //   showAllWarrantiesCategoryButton.heightAnchor.constraint(equalToConstant: 30),
            
            categoriesSliderChildVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesSliderChildVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            categoriesSliderChildVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            warrantiesCollectionView.topAnchor.constraint(equalTo: categoriesSliderChildVC.view.bottomAnchor),
            //warrantiesCollectionView.topAnchor.constraint(equalTo: categoriesSliderChildVC.view.bottomAnchor, constant: 14),
            warrantiesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            warrantiesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            warrantiesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            newWarrantyButton.bottomAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.bottomAnchor, multiplier: 0),
            newWarrantyButton.heightAnchor.constraint(equalToConstant: 50),
            newWarrantyButton.widthAnchor.constraint(equalToConstant: 50),
            newWarrantyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

extension HomeWarrantiesListViewController {
    func colorization() {
        //categoriesSliderChildVC.view.backgroundColor = .yellow
        warrantiesCollectionView.backgroundColor = .orange
    }
}
