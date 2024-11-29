import SwiftUI

struct AnimationView: View {
    @State private var scale1: CGFloat = 1.0
    @State private var scale2: CGFloat = 1.0
    @State private var scale3: CGFloat = 1.0
    @State private var scale4: CGFloat = 1.0
    @State private var scale5: CGFloat = 1.0
    @State private var scale6: CGFloat = 1.0
    @State private var scale7: CGFloat = 1.0
    @State private var scale8: CGFloat = 1.0

    var body: some View {
        VStack {
            HStack(spacing: 3) {
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale1)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true),
                        value: scale1
                    )
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale2)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.3),
                        value: scale2
                    )
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale3)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.6),
                        value: scale3
                    )
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale4)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(0.9),
                        value: scale4
                    )
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale5)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(1.2),
                        value: scale5
                    )
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale6)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(1.5),
                        value: scale6
                    )
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale7)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(1.8),
                        value: scale7
                    )
                Capsule()
                    .fill(Color.green)
                    .frame(width: 1, height: 10)
                    .scaleEffect(scale8)
                    .animation(
                        SwiftUI.Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(2.1),
                        value: scale8
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
                self.scale5 = 2.3
                self.scale6 = 2.3
                self.scale7 = 2.3
                self.scale8 = 2.3
            }
        }
    }
}
struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
