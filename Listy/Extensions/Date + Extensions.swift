//
//  Date + Extensions.swift
//  Listy
//
//  Created by Mihai Dorhan on 23.02.2023.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    
    var isTomorrow: Bool {
        let calendar = Calendar.current
        return calendar.isDateInTomorrow(self)
    }
    
    var dateComponents: DateComponents {
        Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
    }
    
}
