//
//  HorizontalSectionViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import Foundation

protocol HorizontalSectionViewModel {
    var elementCount: Int {get set}
    var sectionTitle: String{get set}
    var emptySectionMessage: String {get set}
}
