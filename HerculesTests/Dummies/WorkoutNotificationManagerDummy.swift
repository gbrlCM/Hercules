//
//  WorkoutNotificationManagerDummy.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 11/08/21.
//

import Foundation
@testable import Hercules

class WorkoutNotificationManagerDummy: NotificationManager {
    
    var notifications: [Double] = []
    
    func send(timeInterval: TimeInterval) {
        notifications.append(timeInterval)
    }
    
    func cancel() {
        notifications = []
    }
}
