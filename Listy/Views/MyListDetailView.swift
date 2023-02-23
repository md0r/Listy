//
//  MyListDetailView.swift
//  Listy
//
//  Created by Mihai Dorhan on 23.02.2023.
//

import SwiftUI

struct MyListDetailView: View {
    
    let myList: MyList
    @State private var openAddReminder: Bool = false
    @State private var title: String = ""
    private var isFormValid: Bool {
        return !title.isEmptyOrWhiteSpace
    }
    
    @FetchRequest(sortDescriptors: []) private var reminderResults: FetchedResults<Reminder>
    
    init(myList: MyList) {
        self.myList = myList
        _reminderResults = FetchRequest(fetchRequest: RemindersService.getRemindersByList(myList: myList))
    }
    
    var body: some View {
        VStack {
            
            ReminderListView(reminders: reminderResults)
            
            HStack {
                Image(systemName: "plus.circle.fill")
                Button("New Reminder") {
                    openAddReminder = true
                }
            }.foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
        }.alert("New Reminder", isPresented: $openAddReminder) {
            TextField("", text: $title)
            Button("Cancel", role: .cancel) { }
            Button("Done") {
                if isFormValid {
                    
                    do {
                        try RemindersService.saveReminderToMyList(myList: myList, reminderTitle: title)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }.scrollContentBackground(.hidden)
        
    }
}
