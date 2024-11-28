//
//  ProfileView.swift
//  Musico
//
//  Created by dgsw07 on 11/22/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 23))
                }
                Spacer().frame(width: 300)
            }
            Image(systemName: "person.crop.circle")
                .font(.system(size: 90))
            
        }
    }
}

#Preview {
    ProfileView()
}
