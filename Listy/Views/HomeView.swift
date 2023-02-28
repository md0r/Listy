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
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .today)) private var todayResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .scheduled)) private var scheduledResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .all)) private var allResults: FetchedResults<Reminder>
    @FetchRequest(fetchRequest: RemindersService.remindersByStatType(statType: .completed)) private var completedResults: FetchedResults<Reminder>
    
    @State private var isPresented: Bool = false
    @State private var search: String = ""
    @State private var searching: Bool = false
    @State private var reminderStatsValues = ReminderStatsValues()
    
    private var reminderStatsBuilder = ReminderStatsBuilder()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                ScrollView {
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: todayResults)
                        } label: {
                            ReminderStatsView(icon: "calendar", title: "Today", count: reminderStatsValues.todayCount)
                        }
                        NavigationLink {
                            ReminderListView(reminders: allResults)
                        } label: {
                            ReminderStatsView(icon: "tray.circle.fill", title: "All", count: reminderStatsValues.allCount)
                        }
                    }
                    HStack {
                        NavigationLink {
                            ReminderListView(reminders: scheduledResults)
                        } label: {
                            ReminderStatsView(icon: "calendar.circle.fill", title: "Scheduled", count: reminderStatsValues.scheduledCount)
                        }
                        NavigationLink {
                            ReminderListView(reminders: completedResults)
                        } label: {
                            ReminderStatsView(icon: "checkmark.circle.fill", title: "Completed", count: reminderStatsValues.completedCount)
                        }
                    }
                    Text("My Lists")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .font(.largeTitle)
                        .bold()
                        .padding()
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
            .onAppear {
                reminderStatsValues = reminderStatsBuilder.build(myListResults: myListResults)
            }
            .padding()
            .navigationTitle("Reminders")
        }.searchable(text: $search)
        
    }
}
