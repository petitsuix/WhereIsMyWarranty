//
//  UICollectionViewDiffableDataSource.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/02/2022.
//

//import UIKit
//
//@available(iOS 13.0, *)
//extension UICollectionViewDiffableDataSourceReference {
//
//    /// A convenience initialiser to set up a `UICollectionViewDiffableDataSourceReference` with existing data source methods. This makes it low effort to use diffable datasources while keeping existing code untouched.
//    /// Eventually, when dropping iOS 12, you might want to revisit this code and remove the existing `UICollectionViewDataSource` implementations.
//    ///
//    /// - Parameters:
//    ///   - collectionView: The collection view for which we're setting the data source
//    ///   - collectionViewDataSource: The original existing collection view data source.
//    convenience init(collectionView: UICollectionView, collectionViewDataSource: UICollectionViewDataSource) {
//        self.init(collectionView: collectionView) { [weak collectionViewDataSource] (collectionView, indexPath, _) -> UICollectionViewCell? in
//            return collectionViewDataSource?.collectionView(collectionView, cellForItemAt: indexPath)
//        }
//
//        supplementaryViewProvider = { [weak collectionViewDataSource] (collectionView, kind, indexPath) -> UICollectionReusableView? in
//            return collectionViewDataSource?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
//        }
//    }
//}
