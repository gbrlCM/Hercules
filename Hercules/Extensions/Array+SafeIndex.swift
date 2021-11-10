//
//  Array+SafeIndex.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 27/10/21.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
