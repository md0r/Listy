//
//  ReminderStatsBuilder.swift
//  Listy
//
//  Created by Mihai Dorhan on 28.02.2023.
//

import Foundation
import SwiftUI

struct ReminderStatsValues {
    var todayCount: Int = 0
    var scheduledCount: Int = 0
    var allCount: Int = 0
    var completedCount: Int = 0
}

enum ReminderStatType {
    case today
    case all
    case scheduled
    case completed
}

struct ReminderStatsBuilder {
    
    func build(myListResults: FetchedResults<MyList>) -> ReminderStatsValues {
        let remindersArray = myListResults
            .map {  $0.remindersArray }
            .reduce([], +)
        let allCount = calculateAllCount(reminders: remindersArray)
        let allCompleted = calculateCompletedCount(reminders: remindersArray)
        let todaysCount = calculateTodaysCount(reminders: remindersArray)
        let scheduledCount = calculateScheduledCount(reminders: remindersArray)
        return ReminderStatsValues(todayCount: todaysCount, scheduledCount: scheduledCount, allCount: allCount, completedCount: allCompleted)
    }
    
    private func calculateAllCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return !reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateCompletedCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return reminder.isCompleted ? result + 1 : result
        }
    }
    
    private func calculateTodaysCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            let isToday = reminder.reminderDate?.isToday ?? false
            return isToday ? result + 1 : result
        }
    }
    
    private func calculateScheduledCount(reminders: [Reminder]) -> Int {
        return reminders.reduce(0) { result, reminder in
            return ((reminder.reminderDate != nil || reminder.reminderTime != nil) && !reminder.isCompleted) ? result + 1 : result
        }
    }
    
}
