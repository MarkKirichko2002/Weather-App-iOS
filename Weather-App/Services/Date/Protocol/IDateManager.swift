//
//  IDateManager.swift
//  Weather-App
//
//  Created by Марк Киричко on 10.02.2024.
//

import Foundation

protocol IDateManager {
    func getCurrentDate()-> String
    func getTime(from date: Date)-> String 
    func getCurrentDayOfWeek(day: Int)-> String
}
