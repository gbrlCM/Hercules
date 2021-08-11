//
//  WorkoutNotificationManager.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 26/07/21.
//

import UserNotifications


class WorkoutNotificationManager: NotificationManager {
    
    private var notificationIds: [String] = []
    
    func send(timeInterval: TimeInterval) {
        if isNotificationGranted {
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Your rest time is over!", arguments: nil)
            content.subtitle = NSString.localizedUserNotificationString(forKey: "Let's get back to work!", arguments: nil)
            content.sound = UNNotificationSound.default

            // show this notification five seconds from now
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            let id = UUID().uuidString
            notificationIds.append(id)

            sendNotification(with: content, when: trigger, id: id)
        }
    }
    
    func cancel() {
        cancelNotification(withIds: notificationIds)
        notificationIds = []

    }
}
