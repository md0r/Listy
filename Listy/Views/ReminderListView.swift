//
//  ReminderListView.swift
//  Listy
//
//  Created by Mihai Dorhan on 23.02.2023.
//

import SwiftUI

struct ReminderListView: View {
    
    let reminders: FetchedResults<Reminder>
    
    private func reminderCheckedChanged(reminder: Reminder, isCompleted: Bool) {
        var editConfig = ReminderEditConfig(reminder: reminder)
        editConfig.isCompleted = isCompleted
        
        do {
            _ =  try RemindersService.updateReminder(reminder: reminder, editConfig: editConfig)
        } catch {
            print(error)
        }
        
    }
    
    var body: some View {
        List(reminders) { reminder in
            ReminderCellView(reminder: reminder, onEvent: { event in
                switch event {
                    
                case .onSelect(let reminder):
                    print(reminder)
                case .onInfo:
                    print("onInfo")
                case .onCheckedChange(let reminder, let isCompleted):
                    reminderCheckedChanged(reminder: reminder, isCompleted: isCompleted)
                    
                }
            })
        }
    }
}
