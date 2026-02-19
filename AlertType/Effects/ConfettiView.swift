
import SwiftUI

struct ConfettiView: View {
    @State private var particles: [Particle] = []
    @State private var timer: Timer?
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .fill(particle.color)
                        .frame(width: particle.size, height: particle.size)
                        .position(particle.position)
                        .opacity(particle.opacity)
                }
            }
            .onAppear {
                startConfetti(in: geometry.size)
            }
            .onDisappear {
                stopConfetti()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func startConfetti(in size: CGSize) {
        // Initial burst
        for _ in 0..<50 {
            createParticle(in: size)
        }
        
        // Continuous flow
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            for _ in 0..<5 {
                createParticle(in: size)
            }
            updateParticles(in: size)
        }
    }
    
    func stopConfetti() {
        timer?.invalidate()
        timer = nil
    }
    
    func createParticle(in size: CGSize) {
        let particle = Particle(
            id: UUID(),
            position: CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height)),
            color: [Color.yellow, Color.orange, Color.red, Color.pink, Color.blue, Color.purple, Color.green].randomElement()!,
            size: CGFloat.random(in: 5...10),
            opacity: 1.0,
            velocity: CGPoint(x: CGFloat.random(in: -2...2), y: CGFloat.random(in: -2...2))
        )
        particles.append(particle)
    }
    
    func updateParticles(in size: CGSize) {
        for index in particles.indices {
            particles[index].position.x += particles[index].velocity.x
            particles[index].position.y += particles[index].velocity.y
            particles[index].opacity -= 0.01
            
            // Wrap around screen
            if particles[index].position.x < 0 { particles[index].position.x = size.width }
            if particles[index].position.x > size.width { particles[index].position.x = 0 }
            if particles[index].position.y < 0 { particles[index].position.y = size.height }
            if particles[index].position.y > size.height { particles[index].position.y = 0 }
        }
        
        particles.removeAll { $0.opacity <= 0 }
    }
}

struct Particle: Identifiable {
    let id: UUID
    var position: CGPoint
    var color: Color
    var size: CGFloat
    var opacity: Double
    var velocity: CGPoint
}
