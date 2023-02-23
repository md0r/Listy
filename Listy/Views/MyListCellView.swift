//
//  MyListCellView.swift
//  Listy
//
//  Created by Mihai Dorhan on 22.02.2023.
//

import SwiftUI

struct MyListCellView: View {
    
    let myList: MyList
    
    var body: some View {
        HStack {
            
            Image(systemName: "line.3.horizontal.circle.fill")
                .foregroundColor(Color(myList.color))
            Text(myList.name)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .opacity(0.4)
                .padding([.trailing], 10)
            
        }
    }
    
}
