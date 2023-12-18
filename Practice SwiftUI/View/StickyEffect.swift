//
//  StickyEffect.swift
//  HandwrittingTest
//
//  Created by Ahmed Yamany on 17/08/2023.
//

import SwiftUI

struct StickyEffect: View {
    let centerWidth = UIScreen.main.bounds.width / 2
    let centerHeight = UIScreen.main.bounds.height / 2
    
    @State private var position = CGSize(width: 0, height: 0)
    
    var body: some View {
        Canvas { context, size in
            let firstCircle = context.resolveSymbol(id: 0)!
            let secondCircle = context.resolveSymbol(id: 1)!
            
            context.addFilter(.alphaThreshold(min: 0.3))
            context.addFilter(.blur(radius: 40))
            
            
            context.drawLayer { context2 in
                context2.draw(firstCircle, at: .init(x: centerWidth, y: centerHeight))
                context2.draw(secondCircle, at: .init(x: centerWidth, y: centerHeight))
            }
            
        } symbols: {
            Circle()
                .frame(width: 100, alignment: .center)
                .tag(0)
            
            Circle()
                .frame(width: 100, alignment: .center)
                .offset(x: position.width, y: position.height)
                .tag(1)
            
        }
        .gesture(
            DragGesture()
                .onChanged{ gesure in
                    self.position = gesure.translation
                }
                .onEnded { _ in
                    self.position = .zero
                }
        )
        .animation(.spring(), value: position)

    }
}
#Preview {
    StickyEffect()
}

