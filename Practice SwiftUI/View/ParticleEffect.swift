//
//  ParticleEffect.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 19/09/2023.
//

import SwiftUI

struct ParticleEffect: View {
    @State private var isLiked: [Bool] = [false, false, false]
    var body: some View {
        VStack {
            HStack {
                CusttomButton(image: Image(systemName: "suit.heart.fill"),
                              status: isLiked[0],
                              activeTint: .pink,
                              inActiveTint: .gray) {
                    isLiked[0].toggle()
                }
                CusttomButton(image: Image(systemName: "star.fill"),
                              status: isLiked[1],
                              activeTint: .green,
                              inActiveTint: .gray) {
                    isLiked[01].toggle()
                }
                CusttomButton(image: Image(systemName: "square.and.arrow.up.fill"),
                              status: isLiked[2],
                              activeTint: .blue,
                              inActiveTint: .gray) {
                    isLiked[2].toggle()
                }
            }
        }
    }
    
    @ViewBuilder
    func CusttomButton(image: Image,
                       status: Bool,
                       activeTint: Color,
                       inActiveTint: Color,
                       onTap: @escaping () -> ()) -> some View {
        Button {
            onTap()
        } label: {
            image
                .font(.title2)
                .particleEffect(image: image,
                                font: .title2,
                                status: status,
                                activeTint: activeTint,
                                inActiveTint: inActiveTint)
                .foregroundColor(status ? activeTint : inActiveTint)
                .padding(.horizontal, 18)
                .padding(.vertical, 8)
                .background {
                    Capsule()
                        .fill(status ? activeTint.opacity(0.25) : inActiveTint.opacity(0.25))
                }
        }
    }
}

struct ParticleEffect_Previews: PreviewProvider {
    static var previews: some View {
        ParticleEffect()
    }
}
extension View {
    @ViewBuilder
    func particleEffect(
        image: Image,
        font: Font,
        status: Bool,
        activeTint: Color,
        inActiveTint: Color) -> some View {
            self
                .modifier(ParticleModifier(image: image,
                                           font: .title,
                                           status: status,
                                           activeTint: activeTint,
                                           inActiveTint: inActiveTint))
        }
}
struct Particle: Identifiable {
    let id = UUID()
    var randomX: CGFloat = 0
    var randomY: CGFloat = 0
    var scale: CGFloat = 1
    var opacity: CGFloat = 1
}
fileprivate struct ParticleModifier: ViewModifier {
    let image: Image
    let font: Font
    let status: Bool
    let activeTint: Color
    let inActiveTint: Color
    @State private var particles: [Particle] = []
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                ZStack {
                    ForEach(particles) { particle in
                        image
                            .foregroundColor(activeTint)
                            .scaleEffect(particle.scale)
                            .offset(x: particle.randomX, y: particle.randomY)
                            .opacity(particle.opacity)
                            .opacity(status ? 1 : 0)
                            .animation(.default, value: status)
                    }
                }
            }
            .onChange(of: status) { newValue in
                if newValue {
                    for _ in 1...15 {
                        let particle = Particle()
                        particles.append(particle)
                    }
                    for index in particles.indices {
                        /// Random X & Y Calculation Based on Index
                        let total: CGFloat = CGFloat(particles.count)
                        let progress: CGFloat = CGFloat(index) / total
                        
                        let maxX: CGFloat = (progress > 0.5) ? 100 : -100
                        let maxY: CGFloat = 60
                        
                        let randomX: CGFloat = ((progress >  0.5) ? (progress-0.5) : progress) * maxX
                        let randomY: CGFloat = ((progress >  0.5) ? (progress-0.5) : progress) * maxY + 35
                        let randomScale: CGFloat = .random(in: 0.35...1)
                        let randomOpacity: CGFloat = .random(in: 0.35...1)
                        let extraRandomX: CGFloat = progress > 0.5 ? .random(in: 0...10) : .random(in: -10...0)
                        let extraRandomY: CGFloat = .random(in: 0...30)
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                            particles[index].randomX = randomX + extraRandomX
                            particles[index].randomY = -randomY - extraRandomY
                        }
                        withAnimation(.easeInOut(duration: 0.3)) {
                            particles[index].scale = randomScale
                            particles[index].opacity = randomOpacity
                        }
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7).delay(0.25 + (Double(index) * 0.005))) {
                            particles[index].scale = 0.001
                            particles[index].opacity = 0.001
                        }
                    }
                } else {
                    particles.removeAll()
                }
            }
        
    }
    
    
}
