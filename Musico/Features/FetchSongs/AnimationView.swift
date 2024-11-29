import SwiftUI

struct AnimationView: View {
    @State private var scale1: CGFloat = 1.0
    @State private var scale2: CGFloat = 1.0
    @State private var scale3: CGFloat = 1.0
    @State private var scale4: CGFloat = 1.0

    var body: some View {
        VStack {
            HStack(spacing: 5) {
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 2, height: 14)
                    .scaleEffect(scale1)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true),
                        value: scale1
                    )
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 2, height: 14)
                    .scaleEffect(scale2)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.3),
                        value: scale2
                    )
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 2, height: 14)
                    .scaleEffect(scale3)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.6),
                        value: scale3
                    )
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 2, height: 14)
                    .scaleEffect(scale4)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.9),
                        value: scale4
                    )
            }
            .padding()

        }
        .onAppear {
            withAnimation {
                self.scale1 = 2.3
                self.scale2 = 2.3
                self.scale3 = 2.3
                self.scale4 = 2.3
            }
        }
    }
}

#Preview {
    AnimationView()
}
