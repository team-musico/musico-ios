//
//  VideoIdView.swift
//  Musico
//
//  Created by dgsw07 on 11/28/24.
//

import SwiftUI

struct VideoIdView: View {
    @StateObject var cm = ChartViewModel()
    var body: some View {
        TextField("",text: $cm.search2)
            .border(.secondary)
        Button {
            cm.videoId(search2: cm.search2)
        } label: {
            Text("dd")
        }

    }
}

#Preview {
    VideoIdView()
}
