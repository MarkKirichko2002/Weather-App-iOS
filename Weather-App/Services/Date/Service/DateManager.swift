//
//  DateManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 08.02.2024.
//

import Foundation

class DateManager: IDateManager {
    
    private let formatter = DateFormatter()
    private var daysOfWeek = ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
    
    func getCurrentDate()-> String {
        let date = Date()
        formatter.dateFormat = "dd.MM.yyyy"
        let currentData = formatter.string(from: date)
        return currentData
    }
    
    func getTime(from date: Date)-> String {
        formatter.dateFormat = "hh:mm"
        let time = formatter.string(from: date)
        return time
    }
    
    func getCurrentDayOfWeek(day: Int)-> String {
        return daysOfWeek[day]
    }
}
