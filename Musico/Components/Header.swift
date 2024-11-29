//
//  ContentView.swift
//  Musico
//
//  Created by dgsw07 on 11/21/24.
//

import SwiftUI

struct Header: View {
    @Binding var sideBarOn: Bool

    var body: some View {
        VStack {
            HStack(alignment:.bottom) {
                Image("subLogoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 72,height: 72)
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        sideBarOn = true
                    }
                }) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 23))
                        
                }
                .padding(.bottom,17)
                .foregroundColor(.black)
            }
            .padding(.horizontal,30)
            
            .padding(.bottom, 10)
        }
        .padding(.top, 17)
    }
}

#Preview {
    Header(sideBarOn: .constant(false))
}
