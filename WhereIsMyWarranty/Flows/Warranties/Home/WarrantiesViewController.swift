//
//  WarrantiesViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/11/2021.
//

import UIKit

class WarrantiesViewController: UIViewController {
    
    var viewModel: WarrantiesViewModel?
    
    weak var coordinator: AppCoordinator?
    
    private var categoriesCollectionView: UICollectionView!
    private var warrantiesCollectionView: UICollectionView!
    
    let navBarAppearance = UINavigationBarAppearance()
    let addWarrantyButton = UIButton()
    let addCategoryButton = UIButton()
    let categoriesStackView = UIStackView()
    let bottomBorder = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Strings.warrantiesTitle
        view.backgroundColor = .white
        configureNavigationBar()
        configureCategoriesStackView()
        configureBottomBorder()
        configureWarrantiesCollectionView()
        configureAddWarrantyButton()
        activateConstraints()
        
        viewModel?.fetchWarranties()
        viewModel?.fetchCategories()
    }
    
    func configureNavigationBar() {
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func configureCategoriesStackView() {
        categoriesStackView.translatesAutoresizingMaskIntoConstraints = false
        categoriesStackView.backgroundColor = .white
        categoriesStackView.spacing = 5.5
        view.addSubview(categoriesStackView)
        configureAddCategoryButton()
        configureCategoriesCollectionView()
    }
    
    func configureBottomBorder() {
        bottomBorder.translatesAutoresizingMaskIntoConstraints = false
        bottomBorder.backgroundColor = #colorLiteral(red: 0.2539245784, green: 0.3356729746, blue: 0.3600735664, alpha: 1)
        view.addSubview(bottomBorder)
    }
    
    func configureAddCategoryButton() {
        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
        addCategoryButton.backgroundColor = .white
        addCategoryButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small)), for: .normal)
        addCategoryButton.tintColor = #colorLiteral(red: 0.2539245784, green: 0.3356729746, blue: 0.3600735664, alpha: 1)
        categoriesStackView.addArrangedSubview(addCategoryButton)
    }
    
    func configureCategoriesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.size.width/5, height: view.frame.size.width/13.5)
        categoriesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // self.view.frame c'est pareil ?
        categoriesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        categoriesCollectionView.register(TopCategoriesCell.self, forCellWithReuseIdentifier: TopCategoriesCell.identifier)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/6.5)
        categoriesStackView.addArrangedSubview(categoriesCollectionView)
    }
    
    func configureWarrantiesCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width-16, height: view.frame.size.width/3.3)
        layout.minimumLineSpacing = 24
        warrantiesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        warrantiesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        warrantiesCollectionView.register(WarrantiesCell.self, forCellWithReuseIdentifier: WarrantiesCell.identifier)
        warrantiesCollectionView.dataSource = self
        warrantiesCollectionView.delegate = self
        warrantiesCollectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.addSubview(warrantiesCollectionView)
    }
    
    func configureAddWarrantyButton() {
        addWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        addWarrantyButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small)), for: .normal)
        addWarrantyButton.tintColor = MWColor.bluegrey
        view.addSubview(addWarrantyButton)
        addWarrantyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addWarrantyButton.addTarget(self, action: #selector(addWarrantyButtonAction), for: .touchUpInside)
    }
    
    @objc func addWarrantyButtonAction() {
        viewModel?.showNewWarrantyScreen()
        // coordinator?.showNewWarrantiesScreenFor(category: "MA SUPER CATEGORY")
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            // FIXME: view.safeAreaLayoutGuide.topAnchor ??? Comment fixer une stackview à une navigationbar ?
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

extension WarrantiesViewController {
    private func setupView() {
        // Ici
        // creation des lable
        // configuration des view
        // config stack view
        
        // nalayoutconstraint ....
    }
}

extension WarrantiesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return user.categories.count
        if collectionView == self.categoriesCollectionView {
            return viewModel?.warranties.count ?? 0 // On devrait pouvoir retourner user.categories.count
        }
        return viewModel?.warranties.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if collectionView == self.categoriesCollectionView {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCategoriesCell.identifier, for: indexPath)
            print(viewModel?.categories[indexPath.row] as Any)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: WarrantiesCell.identifier, for: indexPath)
            print(viewModel?.warranties[indexPath.row] as Any)
        }
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("selected item nbr \(indexPath.row)")
        //  let selectedCategory = categories[indexPath.row]
        
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
    
    func refreshWith(warranties: [String]) {
        warrantiesCollectionView.reloadData()
    }
    
    func refreshWith(categories: [String]) {
        categoriesCollectionView.reloadData()
    }
}


