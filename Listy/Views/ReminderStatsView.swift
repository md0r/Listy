//
//  ReminderStatsView.swift
//  Listy
//
//  Created by Mihai Dorhan on 28.02.2023.
//

import SwiftUI

struct ReminderStatsView: View {
    
    let icon: String
    let title: String
    var count: Int?
    var iconColor: Color = .blue
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Image(systemName: icon)
                        .foregroundColor(iconColor)
                        .font(.title)
                    Text(title)
                        .opacity(0.8)
                }
                Spacer()
                if let count {
                    Text("\(count)")
                        .font(.largeTitle)
                }
            }.padding()
                .frame(maxWidth: .infinity)
                .background(.gray)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
        }
    }
}
