//
//  ContentView.swift
//  Listy
//
//  Created by Mihai Dorhan on 22.02.2023.
//

import SwiftUI

struct HomeView: View {
    
    @FetchRequest(sortDescriptors: []) private var myListResults: FetchedResults<MyList>
    @FetchRequest(sortDescriptors: []) private var searchResults: FetchedResults<Reminder>
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ScrollView {
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
            .listStyle(.plain)
            .onChange(of: search, perform: { searchTerm in
                searching =  !searchTerm.isEmpty ? true : false
                searchResults.nsPredicate = RemindersService.getRemindersBySearchTerm(search).predicate
            })
            .overlay(alignment: .center, content: {
                ReminderListView(reminders: searchResults).opacity(searching ? 1.0 : 0.0)
            })
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
        
    }
}
