//
//  NotificationManager.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import UserNotifications

protocol NotificationManager {
    
    func send(timeInterval: TimeInterval) -> Void
    func cancel() -> Void
    
}

extension NotificationManager {
    
    private var isNotificationGrantedKey: String {
        "com.gbrlcm.arnold.notificationManeger.isNotificationGranted"
    }
    
    var isNotificationGranted: Bool {
        UserDefaults.standard.bool(forKey: isNotificationGrantedKey)
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (success, error) in
            if let error = error {
                print(error)
            }
            UserDefaults.standard.set(success, forKey: self.isNotificationGrantedKey)
        }
    }
    
    func sendNotification(with content: UNNotificationContent, when trigger: UNNotificationTrigger, id: String) {
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification(withIds ids: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }
    
}
