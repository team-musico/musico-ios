//
//  CustomTabView.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import SwiftUI
import YouTubePlayerKit

struct CustomTabView: View {
    @State private var selectedTab: TabViewType = .home
    @EnvironmentObject var musicPlayer: MusicManager 

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // 모든 탭 뷰를 한 번에 로드하고 필요에 따라 보여줌
                SearchView()
                    .opacity(selectedTab == .search ? 1 : 0)
                ChartView()
                    .opacity(selectedTab == .chart ? 1 : 0)
                NewSongView()
                    .opacity(selectedTab == .newMusic ? 1 : 0)
            }
            
            HStack {
                ForEach(TabViewType.allCases, id: \.self) { tab in
                    Button(action: {
                        selectedTab = tab
                    }) {
                        VStack {
                            Spacer()
                            TabViewCell(type: tab, isSelected: selectedTab == tab)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .frame(height: 88)
            .background()

            if let player = musicPlayer.youTubePlayer {
                YouTubePlayerView(player)
                    .frame(height: 70)
            }
        }
        .padding(.bottom, 4)
    }
}


#Preview {
    CustomTabView()
        .environmentObject(MusicManager())
}
