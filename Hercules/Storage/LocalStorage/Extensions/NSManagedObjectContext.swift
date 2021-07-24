//
//  NSManagedObjectContext.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 22/07/21.
//

import CoreData

extension NSManagedObjectContext {
    
    func safeSave() {
        do {
            try self.save()
            print("saved")
        } catch(let error) {
            self.rollback()
            print("error db rollback \(error)")
        }
    }
}
