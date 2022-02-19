//
//  Date+Extensions.swift
//  CommonSystem
//
//  Created by denny on 2021/10/01.
//  Copyright © 2021 Minning. All rights reserved.
//

import Foundation

public extension Date {
    func dateTypeToString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.string(from: self)
    }
    
    func dateTypeToKoreanString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "MM월 dd일"
        
        return formatter.string(from: self)
    }
    
    func dateTypeToKoreanDate() -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return formatter.date(from: self.dateTypeToString())
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    static func createDate(year: Int, month: Int, day: Int,
                           hour: Int = 0, minute: Int = 0, seconds: Int = 0) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: "\(year)-\(month)-\(day)")
    }
    
    func weeklySEDateList() -> [(Date, Date)]? {
        var result: [(Date, Date)] = []
        var startOfWeekDay: Int = 0
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month], from: self)

        if let startOfMonth = calendar.date(from: components)?.dateTypeToKoreanDate(),
           let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth),
           let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth)?.dateTypeToKoreanDate() {
            let comp1 = calendar.dateComponents([.day, .weekday], from: startOfMonth)
            let comp2 = calendar.dateComponents([.day, .weekday], from: endOfMonth)
            
            let yearValue = calendar.dateComponents([.year, .month], from: startOfMonth).year
            let monthValue = calendar.dateComponents([.year, .month], from: startOfMonth).month
            
            startOfWeekDay = comp1.weekday ?? 0
            var tempList: [Date] = []
            
            for day in comp1.day!...comp2.day! {
                let dayDate = Date.createDate(year: yearValue ?? 0, month: monthValue ?? 0, day: day)?.dateTypeToKoreanDate() ?? Date()
                let dayWeekDay = dayDate.get(.weekday)
                if dayWeekDay == startOfWeekDay || day == comp2.day ?? 0 {
                    if day == comp2.day ?? 0 {
                        tempList.append(dayDate)
                    }
                    
                    if !tempList.isEmpty, let first = tempList.first, let last = tempList.last {
                        result.append((first, last))
                        tempList.removeAll()
                        tempList.append(dayDate)
                    } else {
                        tempList.append(dayDate)
                    }
                } else {
                    tempList.append(dayDate)
                }
            }
        }
        
        return result
    }
    
    func convertToCustomString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToSmallString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToSmallDotString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToKoreanString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func convertToSmallKoreanString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM월 dd일"
        
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
