//
//  MWAppearance.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 09/12/2021.
//

import UIKit


enum MWAppearance {
    static func setup() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.orange], for: .normal)
        UINavigationBar.appearance().tintColor = UIColor.purple
        UINavigationBar.appearance().backgroundColor = UIColor.yellow
    }
}
