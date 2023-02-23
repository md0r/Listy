//
//  ContentView.swift
//  Listy
//
//  Created by Mihai Dorhan on 22.02.2023.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: []) private var myListResults: FetchedResults<MyList>
    @State private var isPresented: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                MyListsView(myLists: myListResults)
                
                Spacer()
                
                Button {
                    isPresented = true
                } label: {
                    Text("Add List")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.headline)
                }.padding()
                
            }
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    AddNewListView { name, color in
                        
                        do {
                            try RemindersService.saveMyList(name, color)
                        } catch {
                            print(error)
                        }
                        
                    }
                }
            }
            
        }.padding()
        
    }
}
