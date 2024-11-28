//
//  TabViewType.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import Foundation

enum TabViewType: CaseIterable {
    case home
    case search
    case newMusic
    case chart
    
    var image: String {
        switch self {
        case .home:
            return "house.fill"
        case .search:
            return "magnifyingglass"
        case .newMusic:
            return "plus"
        case .chart:
            return "chart.bar.fill"
        }
    }
    
    var click: String {
        switch self {
        case .home:
            return "clickhome"
        case .search:
            return "clicksearch"
        case .newMusic:
            return "clicknewMusic"
        case .chart:
            return "clickchart"
        }
    }
    
    var text: String {
        switch self {
        case .home:
            return "홈"
        case .search:
            return "검색"
        case .newMusic:
            return "최신음악"
        case .chart:
            return "차트"
        }
    }
}
