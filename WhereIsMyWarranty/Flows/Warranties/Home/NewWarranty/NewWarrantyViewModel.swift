//
//  NewWarrantyViewModel.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 15/12/2021.
//

//extension Warranty {
//    convenience init() {
//        self.init()
//    }
//}

import Foundation
import UserNotifications

class NewWarrantyViewModel: NSObject {
    
    // MARK: - Internal properties
    
    var newWarranty: Warranty?
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    weak var newWarrantyProductInfoViewDelegate: NewWarrantyProductInfoViewController?
    weak var newWarrantyPhotoViewDelegate: NewWarrantyPhotoViewController?
    weak var newWarrantyExtraInfoViewDelegate: ExtraInfoViewController?
    
    var name: String? {
        didSet {
            newWarrantyProductInfoViewDelegate?.canGoToNextStep(canSave: canSaveWarranty)
        }
    }
    var startDate: Date?
    var endDate: Date?
    var isLifetimeWarranty: Bool?
    var productPhoto: Data?
    var invoicePhoto: Data?
    var price: Double? {
        didSet {
            newWarranty?.price = price ?? 0
        }
    }
    var model: String? {
        didSet {
            newWarranty?.model = model
        }
    }
    var serialNumber: String? {
        didSet {
            newWarranty?.serialNumber = serialNumber
        }
    }
    var sellersName: String? {
        didSet {
            newWarranty?.sellersName = sellersName
        }
    }
    var sellersLocation: String? {
        didSet {
            newWarranty?.sellersLocation = sellersLocation
        }
    }
    var sellersContact: String? {
        didSet {
            newWarranty?.sellersContact = sellersContact
        }
    }
    var sellersWebsite: String? {
        didSet {
            newWarranty?.sellersWebsite = sellersWebsite
        }
    }
    var notes: String?
    
    var canSaveWarranty: Bool {
            return name?.isEmpty == false
        }
    
    // MARK: - Private properties
    
    private let coordinator: WarrantiesCoordinatorProtocol
    private let storageService: StorageServiceProtocol
    
    // MARK: - Internal methods
    
    init(coordinator: WarrantiesCoordinatorProtocol, storageService: StorageServiceProtocol) {
        self.coordinator = coordinator
        self.storageService = storageService
    }
    
    func notifyWarrantiesListUpdated() {
        let notificationName = NSNotification.Name(rawValue: "warranties list updated")
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
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
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
    
    func goToAddProductPhotoScreen() {
        coordinator.showNewWarrantyProductPhotoScreen()
    }
    
    func goToAddInvoicePhotoScreen() {
        coordinator.showNewWarrantyInvoicePhotoScreen()
    }
    
    func goToExtraInfoScreen() {
        coordinator.showNewWarrantyExtraInfoScreen()
    }
    
    func saveWarranty() {
// Initializing newWarranty here, upon saving, because if it's initialized in init(), it automatically saves a newWarranty,
// even though the user cancels warranty creation
        newWarranty = Warranty(context: storageService.viewContext)
        // FIXME: losing interest of each value's didSet by "manually" saving them below
        newWarranty?.price = price ?? 0
        newWarranty?.model = model
        newWarranty?.serialNumber = serialNumber
        newWarranty?.sellersName = sellersName
        newWarranty?.sellersLocation = sellersLocation
        newWarranty?.sellersWebsite = sellersWebsite
        newWarranty?.sellersContact = sellersContact
        newWarranty?.notes = notes
        newWarranty?.name = name
        newWarranty?.warrantyStart = startDate
        newWarranty?.warrantyEnd = endDate
        newWarranty?.lifetimeWarranty = isLifetimeWarranty ?? false
        newWarranty?.invoicePhoto = invoicePhoto
        newWarranty?.productPhoto = productPhoto
        newWarranty?.notes = notes
        storageService.save()
        configureNotification()
        warrantySaved()
    }
    
    // MARK: - Private methods
    
    func warrantySaved() {
        coordinator.warrantySaved()
    }
}
