//
//  Migration.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation
import CoreData

protocol Migration: AnyObject {
    func performMigration(to context: NSManagedObjectContext)
}
