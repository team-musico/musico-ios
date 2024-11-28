//
//  CustomTabView.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import SwiftUI

struct CustomTabView: View {
    @State private var selectedTab: TabViewType = .home
    @State private var sideBarOn: Bool = false
    
    var body: some View {
            VStack(spacing: 0) {
                ZStack {
                    switch selectedTab {
                    case .search:
                        SearchView()
                    case .chart:
                        ChartView()
                    case .home:
                        ChartView()
                    case .newMusic:
                        NewSongView()
                    }
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
                
                if sideBarOn {
                    SideBarView(sideBarOn: $sideBarOn)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .zIndex(1)
                }
                }
        .padding(.bottom, 4)
    }
}

#Preview {
    CustomTabView()
}
