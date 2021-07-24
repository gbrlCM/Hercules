//
//  ActivityRingCard.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 23/07/21.
//

import SwiftUI

struct ActivityRingCard: View {
    
    var size = CGSize(width: 200, height: 130)
    
    @Binding
    var actityRingData: ActivityRingData
    
    var body: some View {
        Card(size: size, background: Color.cardBackgroundBasic) {
            HStack {
                Text(LocalizedStringKey(actityRingData.name.rawValue))
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.leading, 12)
                Spacer()
                VStack {
                    Text("\(Int(actityRingData.achieved))")
                        .font(.largeTitle.bold())
                        .foregroundColor(actityRingData.name.color)
                    Text("/ \(Int(actityRingData.goal))")
                        .font(.title2.bold())
                        .foregroundColor(actityRingData.name.color)
                }.padding(.horizontal, 12)
            }
        }
    }
}

struct ActivityRingCard_Previews: PreviewProvider {
    static var previews: some View {
        ActivityRingCard(actityRingData: .constant(.init(name: .calories, achieved: 450, goal: 520)))
    }
}
