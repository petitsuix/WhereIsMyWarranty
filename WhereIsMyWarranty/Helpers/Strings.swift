//
//  Strings.swift
//  Où est ma garantie ?
//
//  Created by Richardier on 03/12/2021.
//

import Foundation

enum Strings {
    // Home VC
    static let warrantiesInMyPockets = "Des garanties plein les poches ! 🦘"
    static let tapHereToStart = "appuyez ici pour commencer"
    
    // View titles
    static let warrantiesTitle = "Garanties"
    static let settingsTitle = "Réglages"
    
    // Warranties lifespan
    static let lifetimeWarrantyDefaultText = "Produit garanti à vie 🍾"
    static let warrantyExpiredSince = "Produit hors garantie depuis le\n"
    static let warrantyExpiredCellStyle = "Produit hors garantie"
    static let warrantyExpired = "Produit hors\ngarantie"
    static let lifetimeWarrantyTextWithExtraLine = "Produit garanti\n    à vie 🍾"
    static let productCoveredUntil = "Produit sous garantie jusqu'au :\n"
    static let coveredUntil = "Couvert jusqu'au "
    static let remainingDays = " jours restants"
    
    // Warranty details VC
    static let edit = "  Modifier  "
    static let delete = "  Supprimer  "
    static let invoice = "Facture"
    
    // Settings
    static let about = "À propos"
    static let cloudSync = "Synchronisation cloud"
    static let notifications = "Notifications"
    static let privacyPolicy = "Politique de confidentialité  "
    static let termsAndConditions = "Termes et conditions  "
    static let version = "Où est ma garantie ?\nv1.0"
    static let settingsPresentationLabel = "Merci d'utiliser Où est ma garantie 🕵️\n\n Restez dans les environs,\nd'autres fonctionnalités sont à venir !👇"
    static let chevron = "chevron.right"
    
    // Miscellaneous
    static let warrantyUpdatedNotif = "warranty updated"
    static let warrantiesListUpdatedNotif = "warranties list updated"
    static let dequeueCellIsOfUnknownType = "The dequeue collection view cell was of an unknown type!"
    static let cellIdentifier = "WarrantiesCollectionViewCell"
}
