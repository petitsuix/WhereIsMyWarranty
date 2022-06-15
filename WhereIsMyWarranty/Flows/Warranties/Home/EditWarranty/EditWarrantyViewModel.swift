//
//  EditWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 14/01/2022.
//

import Foundation
import UserNotifications

class EditWarrantyViewModel {
    
    // MARK: - Internal properties
    
    weak var productInfoViewDelegate: EditWarrantyProductInfoViewController?
    weak var photoViewDelegate: EditWarrantyPhotoViewController?
    weak var extraInfoViewDelegate: ExtraInfoViewController?
    
    var warranty: Warranty
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    var name: String? {
        didSet {
            productInfoViewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    var startDate: Date?
    var isLifetimeWarranty: Bool?
    var endDate: Date?
    var productPhoto: Data?
    var invoicePhoto: Data?
    var price: Double? {
        didSet {
            warranty.price = price ?? 0
        }
    }
    var model: String? {
        didSet {
            warranty.model = model
        }
    }
    var serialNumber: String? {
        didSet {
            warranty.serialNumber = serialNumber
        }
    }
    var sellersName: String? {
        didSet {
            warranty.sellersName = sellersName
        }
    }
    var sellersLocation: String? {
        didSet {
            warranty.sellersLocation = sellersLocation
        }
    }
    var sellersContact: String? {
        didSet {
            warranty.sellersContact = sellersContact
        }
    }
    var sellersWebsite: String? {
        didSet {
            warranty.sellersWebsite = sellersWebsite
        }
    }
    var notes: String?
    
    private var canSaveWarranty: Bool {
            return name?.isEmpty == false
    }
    
    // MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    // MARK: - Methods
    
    init(coordinator: WarrantiesCoordinatorProtocol, storageService: StorageServiceProtocol, warranty: Warranty) {
        self.coordinator = coordinator
        self.storageService = storageService
        self.warranty = warranty
    }
    
    func notifyWarrantyUpdated() {
        let notificationName = NSNotification.Name(rawValue: Strings.warrantyUpdatedNotif)
        let notification = Notification(name: notificationName)
        NotificationCenter.default.post(notification)
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (_, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }

    func configureNotification() {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "Une garantie arrive bientôt à expiration : \(name ?? "")"
        notificationContent.body = "Tout fonctionne ? Sinon, c'est le moment de contacter le SAV 🦦"
        notificationContent.badge = NSNumber(value: 3)

        // Add an attachment to the notification content
        if let url = Bundle.main.url(forResource: "icon-60",
                                        withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "icon-60",
                                                                url: url,
                                                                options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        guard var nextTriggerDate = endDate else { return }
        nextTriggerDate.addTimeInterval(-30*86400)
        var comps = Calendar.current.dateComponents([.year, .month, .day], from: nextTriggerDate)
        comps.hour = 18
        comps.minute = 0
        comps.second = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
        let request = UNNotificationRequest(identifier: "expiringWarrantyNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    func goToEditProductPhotoScreen() {
        coordinator.showEditWarrantyProductPhotoScreen()
    }
    
    func goToEditInvoicePhotoScreen() {
        coordinator.showEditWarrantyInvoicePhotoScreen()
    }
    
    func goToEditExtraInfoScreen() {
        coordinator.showEditWarrantyExtraInfoScreen()
    }
    
    func saveEditedWarranty() {
        warranty.name = name
        warranty.warrantyStart = startDate
        warranty.lifetimeWarranty = isLifetimeWarranty ?? false
        warranty.warrantyEnd = endDate
        warranty.productPhoto = productPhoto
        warranty.invoicePhoto = invoicePhoto
        warranty.notes = notes
        storageService.save()
        configureNotification()
        warrantySaved()
    }
    
    func calculateNumberOfYears() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.year ?? 0)
    }
    
    func calculateNumberOfMonths() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.month ?? 0)
    }
    
    func calculateNumberOfWeeks() -> Double {
        let calendar = Calendar.current
        guard let warrantyStart = warranty.warrantyStart, let warrantyEnd = warranty.warrantyEnd else { return 0.0 }
        let components = calendar.dateComponents([.year, .month, .day], from: warrantyStart.startOfDay, to: warrantyEnd)
        return Double(components.day ?? 0) / 7
    }
    
    // MARK: - Private methods
    
    func warrantySaved() {
        coordinator.editedWarrantySaved()
    }
}
