//
//  TabViewCell.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import Foundation
import SwiftUI

struct TabViewCell: View {
    
    let type: TabViewType
    let isSelected: Bool
    
    init(type: TabViewType, isSelected: Bool) {
        self.type = type
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            ZStack {
                if isSelected {
                    Rectangle()
                        .fill(isSelected ? Color.indigo : .clear)
                        .frame(width: 52,height: 42)
                        .cornerRadius(4)
                }
                Image(systemName: type.image)
                    .font(.system(size: 20))
                    .padding(.bottom,isSelected ? 0 : 12)
                    .foregroundColor(isSelected ? .white : .indigo)
            }
            Text(type.text)
                .font(.system(size: 14).weight(.regular))
                .foregroundStyle(.black)
        }
    }
}
