//
//  WorkoutsViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation

class WorkoutsViewModel: ObservableObject {
    
    let storage: WorkoutsStorage
    
    init() {
        storage = WorkoutsStorage()
    }
}
