//
//  WarrantiesViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/11/2021.
//

import UIKit

class WarrantiesViewController: UIViewController, UINavigationBarDelegate {
    
    var categories = ["Toutes", "Non-catégorisées"]
   
    private var collectionView: UICollectionView!
    
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
        configureAddWarrantyButton()
        activateConstraints()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 27)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.black]
        
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
        configureCollectionView()
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
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.size.width/5, height: view.frame.size.width/13.5)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // self.view.frame c'est pareil ?
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TopCategoriesCell.self, forCellWithReuseIdentifier: TopCategoriesCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/6.5)
        categoriesStackView.addArrangedSubview(collectionView)
    }
    
    func configureAddWarrantyButton() {
        addWarrantyButton.translatesAutoresizingMaskIntoConstraints = false
        addWarrantyButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small)), for: .normal)
        addWarrantyButton.tintColor = #colorLiteral(red: 0.2539245784, green: 0.3356729746, blue: 0.3600735664, alpha: 1)
        view.addSubview(addWarrantyButton)
        addWarrantyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
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
            bottomBorder.topAnchor.constraint(equalToSystemSpacingBelow: categoriesStackView.bottomAnchor, multiplier: 0)
        ])
    }
}

extension WarrantiesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return user.categories.count
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCategoriesCell.identifier, for: indexPath)
        
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
}
