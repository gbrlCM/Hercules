//
//  WorkoutsView.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 16/07/21.
//

import SwiftUI

struct WorkoutsView: View {
    
    @State var number: Int = 1
    @State var string: String = "" { didSet {
        number = Int(string) ?? 10
    }}
    
    var body: some View {
        VStack {
            Button(action: {}, label: {
                Text("Chest")
                    .fontWeight(.bold)
            })
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.blue.opacity(0.3))
            .cornerRadius(50)
            
            Button(action: {}, label: {
                Text("Back")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            })
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.green.opacity(0.8))
            .cornerRadius(50)
            
            
        }
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutsView()
    }
}
