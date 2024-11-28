import SwiftUI

struct SideBarView: View {
    @Binding var sideBarOn: Bool
    var userInfo = "강연"
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(width: 270)
                .foregroundColor(.white)
                .ignoresSafeArea()
                .shadow(color:.secondary.opacity(0.7),radius: 23)
                .overlay {
                    VStack(alignment:.leading) {
                            HStack {
                                Button {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        sideBarOn = false
                                    }
                                } label: {
                                    Image(systemName: "xmark")
                                    
                                        .font(.system(size: 24).weight(.semibold))
                                        .foregroundColor(.black)
                                    
                                }
                                .padding(.bottom, 20)
                            }
                        NavigationLink {
                            ProfileView()
                        } label: {
                            HStack {
                                Image(systemName: "person.crop.circle.fill")
                                    .foregroundColor(.blue.opacity(0.7))
                                    .font(.system(size: 35))
                                Spacer().frame(width: 10)
                                Text("\(userInfo)")
                                    .font(.system(size: 20).weight(.medium))
                                    .foregroundColor(.black)
                            }
                        }

                        
                        Rectangle()
                            .frame(maxWidth: .infinity,maxHeight: 0.5)
                            .foregroundColor(.secondary.opacity(0.6))
                            .padding(.vertical,20)
                        NavigationLink {
                            MyPlaylistView()
                        } label: {
                            HStack {
                                Image(systemName: "folder.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.blue.opacity(0.7))
                                Text("내 재생목록")
                            }
                        }

                        
                        Spacer()
                    }
                    .padding()
                }
                .background(.white)

        }
    }
}

#Preview {
    StateWrapper()
}

struct StateWrapper: View {
    @State private var sideBarOn = true
    
    var body: some View {
        SideBarView(sideBarOn: $sideBarOn)
    }
}
