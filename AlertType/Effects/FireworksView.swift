
import SwiftUI

struct FireworksView: View {
    @State private var particles: [FireworkParticle] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .fill(particle.color)
                        .frame(width: particle.size, height: particle.size)
                        .position(particle.position)
                        .scaleEffect(particle.scale)
                        .opacity(particle.opacity)
                }
            }
            .onAppear {
                animateFireworks(in: geometry.size)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func animateFireworks(in size: CGSize) {
        for _ in 0..<5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...1.5)) {
                createExplosion(in: size)
            }
        }
    }
    
    func createExplosion(in size: CGSize) {
        let origin = CGPoint(x: CGFloat.random(in: 50...size.width-50), y: CGFloat.random(in: 100...size.height/2))
        
        for _ in 0..<40 {
            let particle = FireworkParticle(
                id: UUID(),
                position: origin,
                color: [Color.red, Color.yellow, Color.blue, Color.purple, Color.white].randomElement()!,
                scale: 1.0,
                opacity: 1.0,
                velocity: CGPoint(x: CGFloat.random(in: -3...3), y: CGFloat.random(in: -3...3)),
                size: CGFloat.random(in: 4...8)
            )
            particles.append(particle)
        }
        
        // Timer for particle movement and fade out
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            for index in particles.indices {
                particles[index].position.x += particles[index].velocity.x
                particles[index].position.y += particles[index].velocity.y
                particles[index].opacity -= 0.02
                particles[index].scale -= 0.01
                particles[index].velocity.y += 0.05 // Gravity
            }
            
            particles.removeAll { $0.opacity <= 0 }
            
            if particles.isEmpty {
                timer.invalidate()
            }
        }
    }
}

struct FireworkParticle: Identifiable {
    let id: UUID
    var position: CGPoint
    var color: Color
    var scale: CGFloat
    var opacity: Double
    var velocity: CGPoint
    var size: CGFloat
}
