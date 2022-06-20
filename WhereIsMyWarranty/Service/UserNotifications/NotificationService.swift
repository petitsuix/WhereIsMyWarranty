//
//  NotificationService.swift
//  WhereIsMyWarranty
//
//  Created by Richardier on 20/06/2022.
//

import UserNotifications

final class NotificationService {
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    func cancelnotif(for notificationId: String) {
        userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [notificationId])
    }
    func cancelAllNotif() {
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    static func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, error) in
            if isGranted {
                print("Notification permission was granted by user")
            }
            if let error = error {
                print("Error requesting notification authorization: \(error)")
            }
        }
    }
    
    static func shouldRequestNotificationAuthorization(_ completion: @escaping ((Bool) -> Void)) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let isNotAuthorized = (settings.authorizationStatus == .notDetermined)
            completion(isNotAuthorized)
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func generateNotificationFor(_ name: String, _ date: Date, id: String) {
        //In order to display notif in simulator right after creation
#if DEBUG
        let notificationInterval: Double = 20
        let date = date.addingTimeInterval(notificationInterval)
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
#else
        //Assigning the notif to 9AM for real use
        var dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        dateComponents.hour = 12
        dateComponents.minute = 8
        dateComponents.second = 0
#endif
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Ta garantie \(name) arrive a expiration le \(date)"
        notificationContent.body = "Tout fonctionne ? Sinon, c'est le moment de contacter le SAV 🦦"
        notificationContent.sound = UNNotificationSound.default
        let request = UNNotificationRequest(identifier: id, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("error adding notification \(error)")
            } else {
                print("notification added success")
            }
        }
    }
}

