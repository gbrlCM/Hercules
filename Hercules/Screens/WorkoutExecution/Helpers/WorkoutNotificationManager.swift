//
//  WorkoutNotificationManager.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 26/07/21.
//

import UserNotifications


struct WorkoutNotificationManager {
    
    private let manager = UserNotificationManager.shared
    private var notificationIds: [String] = []
    
    mutating func sendEndOfRestingNotification(timeInterval: TimeInterval) {
        if manager.isNotificationGranted {
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Your rest time is over!", arguments: nil)
            content.subtitle = NSString.localizedUserNotificationString(forKey: "Let's get back to work!", arguments: nil)
            content.sound = UNNotificationSound.default

            // show this notification five seconds from now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let id = UUID().uuidString
            notificationIds.append(id)

            manager.sendNotification(with: content, when: trigger, id: id)
        }
    }
    
    mutating func cancelRestingNotifications() {
        manager.cancelNotification(withIds: notificationIds)
        notificationIds = []
    }
}
