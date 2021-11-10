//
//  DeviceActivityMonitorDummy.swift
//  HerculesTests
//
//  Created by Gabriel Ferreira de Carvalho on 26/10/21.
//

import Foundation
import Combine
@testable import Hercules

struct DeviceActivityMonitorDummy: DeviceActivityMonitor {
    let deviceWillExitForegroundPublisher: AnyPublisher<Date, Never>
    let deviceDidEnterForegroundPublisher: AnyPublisher<Date, Never>
    
    let deviceWillExitForegroundSubject: PassthroughSubject<Date, Never>
    let deviceDidEnterForegroundSubject: PassthroughSubject<Date, Never>
    
    init () {
        deviceWillExitForegroundSubject = .init()
        deviceDidEnterForegroundSubject = .init()
        deviceWillExitForegroundPublisher = deviceWillExitForegroundSubject.eraseToAnyPublisher()
        deviceDidEnterForegroundPublisher = deviceDidEnterForegroundSubject.eraseToAnyPublisher()
    }
    
}
