//
//  ChatBalloon.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 10/11/21.
//

import SwiftUI

struct ChatBalloonShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: -2.5, y: 0))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX + triangleSize(in: rect), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: balloonHeight(rect.maxY)))
        path.addLine(to: CGPoint(x: rect.midX - triangleSize(in: rect), y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: .zero)
        
        
        return path
    }
    
    private func balloonHeight(_ max: CGFloat) -> CGFloat {
        let offset = max * 0.15 > 32 ? 32 : max * 0.15
        let height = max + offset
        return height
    }
    
    private func triangleSize(in rect: CGRect) -> CGFloat {
        rect.size.width * 0.10
    }
}

struct ChatBalloon<Child: View>: View {
    private let gradient = LinearGradient(colors: [.redGradientStart, .redGradientFinish], startPoint: .bottomTrailing, endPoint: .topLeading)
    
    @ViewBuilder var child: () -> Child
    var body: some View {
        child()
            .padding()
            .background(ChatBalloonShape().stroke(gradient, lineWidth: 5))
    }
}

struct ChatBalloon_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            ChatBalloon {
                Text("Lorem ipsum")
            }
        }
        
        
    }
}
