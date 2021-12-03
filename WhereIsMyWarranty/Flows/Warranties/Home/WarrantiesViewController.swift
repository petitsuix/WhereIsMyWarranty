//
//  WarrantiesViewController.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 29/11/2021.
//

import UIKit

class WarrantiesViewController: UIViewController, UINavigationBarDelegate {
    
    var categories = ["Toutes", "Non-catégorisées"]
   // var myCollectionView: UICollectionView!
    
    private var collectionView: UICollectionView!
    
    let navBarAppearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Garanties"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.size.width/5, height: view.frame.size.width/13.5)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // self.view.frame c'est pareil ?
        
        collectionView.register(TopCategoriesCell.self, forCellWithReuseIdentifier: TopCategoriesCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/6.5)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        configureNavigationBar()
        // configureCollectionView()

        activateConstraints()
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 27)!,
                                                                        NSAttributedString.Key.foregroundColor: UIColor.black]
        
        navBarAppearance.backgroundColor = #colorLiteral(red: 0.9285728335, green: 0.7623301148, blue: 0.6474828124, alpha: 1)
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
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
