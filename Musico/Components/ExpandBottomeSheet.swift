import SwiftUI

struct ExpandBottomeSheet: View {
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animateContent = false
    var song: Song?

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            
            ZStack {
                if let albumArt = song?.albumArt, let url = URL(string: albumArt) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                            .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            .opacity(animateContent ? 1 : 0)
                            .blur(radius: 20)
                            .edgesIgnoringSafeArea(.all)
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.8)]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            )
                            .background(Color.black)
                            .ignoresSafeArea()
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.gray)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    }
                }


                VStack(spacing: 15) {
                    Capsule()
                        .fill(.gray)
                        .frame(width: 40, height: 5)
                        .opacity(animateContent ? 1 : 0)

                    GeometryReader { geometry in
                        let size = geometry.size
                        if let song = song {
                            AsyncImage(url: URL(string: song.albumArt ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                            } placeholder: {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.gray)
                                    .frame(width: size.width, height: size.height)
                            }
                        }
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                    .frame(width: size.width - 50, height: size.width - 50)

                    PlayerView(size)
                        .offset(y: animateContent ? 0 : size.height)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.top, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        expandSheet = false
                        animateContent = false
                    }
                }
            }
            .ignoresSafeArea(.container, edges: .all)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
        }
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: .center, spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            if let song = song {
                                Text(song.title)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                Text(song.artists.map { $0.artistName }.joined())
                                    .foregroundColor(.gray)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            //
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(
                                    Circle()
                                        .fill(.secondary)
                                        .environment(\.colorScheme, .light)
                                )
                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Capsule()
                        .fill(.ultraThickMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(width: 340, height: 5)
                        .padding(.top, spacing)
                }
            }
        }
    }
}

#Preview {
    ChartView()
}
