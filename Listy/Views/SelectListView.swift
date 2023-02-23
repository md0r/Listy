//
//  SelectListView.swift
//  Listy
//
//  Created by Mihai Dorhan on 23.02.2023.
//

import SwiftUI

struct SelectListView: View {
    
    @FetchRequest(sortDescriptors: []) private var myLists: FetchedResults<MyList>
    @Binding var selectedList: MyList?
    
    var body: some View {
        List(myLists) { list in
            HStack {
                HStack {
                    Image(systemName: "line.3.horizontal.circle.fill")
                        .foregroundColor(Color(list.color))
                    Text(list.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.selectedList = list
                }
                Spacer()
                if selectedList == list {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
