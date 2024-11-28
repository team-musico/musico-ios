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
            HStack {
//                Image("logoImage")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 175)
                Text("로고")
                    .font(.system(size: 35).weight(.semibold))
                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        sideBarOn = true
                    }
                }) {
                    Image(systemName: "list.bullet")
                        .font(.system(size: 23))
                        
                }
                .foregroundColor(.black)
            }
            .padding(.horizontal,20)
            
            .padding(.bottom, 10)
        }
        .padding(.top, 17)
    }
}

#Preview {
    Header(sideBarOn: .constant(false))
}
