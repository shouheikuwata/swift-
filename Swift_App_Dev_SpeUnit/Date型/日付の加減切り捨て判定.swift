//
//  日付の加減.swift
//  Swift_App_Dev_SpeUnit
//
//  Created by 桑田翔平 on 2022/07/02.
//

import Foundation


func date_calclate(){
    //これで現在時刻の取得
    let nowDate = Date()
    
    
    let plus_1_Date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    //MARK: -
}

//MARK: - 日付の切り捨て
func date_kirisute(){
    //分以下の切り捨て
    let calendar = Calendar(identifier: .gregorian)
    let date = Date()
    let compornent = calendar.dateComponents([.year, .month, .day, .hour], from: date)
    let new = calendar.date(from: compornent)
    
    //秒以下の切り捨て
    let calendar1 = Calendar(identifier: .gregorian)
    let date1 = Date()
    let compornent = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
    let new = calendar.date(from: compornent)
}

//MARK: - 日付の判定 Boolで返す
func hizuke_hantei(){
    let calendar = Calendar(identifier: .gregorian)
    let date = Date()
    let yesterday = date.addingTimeInterval(-60 * 60 * 24)
    let tommorow = date.addingTimeInterval(60 * 60 * 24)
    
    print(calendar.isDateInToday(date)) // 今日かどうか
    print(calendar.isDateInYesterday(yesterday)) // 昨日かどうか
    print(calendar.isDateInTomorrow(tommorow)) // 明日かどうか
    print(calendar.isDateInWeekend(date)) // 週末かどうか
}
