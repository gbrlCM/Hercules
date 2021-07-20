//
//  Note.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 19/07/21.
//

import Foundation

struct Note: Codable {
    var value: String
    var links: [URL]
    
    init(entity: ADNote) {
        
        guard
            let value = entity.value,
            let linkEntity = entity.links?.allObjects as? [ADLinks]
        else {
            preconditionFailure("Database misconfigured or error during registration")
        }
        
        let linkString = linkEntity.compactMap(\.value)
        let urls = linkString.compactMap { link in URL(string: link)}
        
        self.value = value
        self.links = urls
    }
    
    init(value: String, links: [URL]) {
        self.value = value
        self.links = links
    }
    
    init() {
        self.value = "Swing the barbell upward and bring it back safely"
        self.links = [URL(string: "https://www.youtube.com/watch?v=eO4PoRjPATY")!]
    }
}
