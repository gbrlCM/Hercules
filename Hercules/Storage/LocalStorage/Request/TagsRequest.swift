//
//  TagsRequest.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import CoreData

extension ADExerciseTags {
    
    static var allTags: NSFetchRequest<ADExerciseTags> {
        let request: NSFetchRequest<ADExerciseTags> = ADExerciseTags.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \ADExerciseTags.name, ascending: true)]
        
        return request
    }
}
