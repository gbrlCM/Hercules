//
//  CombineUtils.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 05/05/22.
//

import Foundation
import Combine

extension Publisher where Output: Sequence {
    typealias Sorter = (Output.Element, Output.Element) -> Bool

    func sort(
        by sorter: @escaping Sorter
    ) -> Publishers.Map<Self, [Output.Element]> {
        map { sequence in
            sequence.sorted(by: sorter)
        }
    }
}

