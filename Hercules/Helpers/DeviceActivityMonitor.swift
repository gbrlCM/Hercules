//
//  DeviceActivityMonitor.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 26/10/21.
//

import Foundation
import Combine
import UIKit

protocol DeviceActivityMonitor {
    var deviceWillExitForegroundPublisher: AnyPublisher<Date, Never> { get }
    var deviceDidEnterForegroundPublisher: AnyPublisher<Date, Never> { get }
}

struct DeviceActivityMonitorImpl: DeviceActivityMonitor {
    let notificationCenter: NotificationCenter
    let deviceWillExitForegroundPublisher: AnyPublisher<Date, Never>
    let deviceDidEnterForegroundPublisher: AnyPublisher<Date, Never>
    
    init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
        
        self.deviceDidEnterForegroundPublisher =
        notificationCenter.publisher(for: UIApplication.didBecomeActiveNotification)
            .map { _ in Date() }
            .eraseToAnyPublisher()
        
        self.deviceWillExitForegroundPublisher =
        notificationCenter.publisher(for: UIApplication.willResignActiveNotification)
            .map { _ in Date() }
            .eraseToAnyPublisher()
    }
}
