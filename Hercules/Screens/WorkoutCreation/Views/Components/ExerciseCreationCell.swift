//
//  ExerciseCreationCell.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import SwiftUI

struct ExerciseCreationCell: View {
    
    var viewModel: ExerciseCreationCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.name)
                    .font(.title3)
                    .foregroundColor(.primary)
                Spacer()
            }
            HStack {
                if viewModel.intesityType == .bodyWeight {
                    Text("\(viewModel.series, specifier: "%d") x \(viewModel.repetitons, specifier: "%d") at body weight - \(viewModel.restTimeFormatted) of rest")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } else {
                    Text("\(viewModel.series, specifier: "%d") x \(viewModel.repetitons, specifier: "%d") at \(viewModel.intesityFormatted) - \(viewModel.restTimeFormatted) of rest")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
    }
}

struct ExerciseCreationCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExerciseCreationCell(viewModel: ExerciseCreationCellViewModel())
                .environment(\.locale, .init(identifier: "pt_BR"))
            ExerciseCreationCell(viewModel: ExerciseCreationCellViewModel())
        }
    }
}
