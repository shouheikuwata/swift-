//
//  CompareDateDate.swift
//  Swift_App_Dev_SpeUnit
//
//  Created by 桑田翔平 on 2022/06/29.
//

import Foundation

//MARK: - 年月日時分秒の比較
func CompareDate_YYYMMDD_HHMMSS(date1:Date,date2:Date) -> Bool{
    let dateComp1 = Calendar.current.dateComponents([ .year, .month, .day, .hour, .minute, .second], from: date1)
    
    let dataComp2 = Calendar.current.dateComponents([ .year, .month, .day, .hour, .minute, .second], from: date2)
    
    let compareFlag = dataComp2.year == dateComp1.year && dataComp2.month == dateComp1.month && dataComp2.day == dateComp1.day && dataComp2.hour == dateComp1.hour && dataComp2.minute == dateComp1.minute && dataComp2.second == dateComp1.second
    
    if compareFlag{
        return true
    }else{
        return false
    }
}
//MARK: - 年月日時分の比較
func CompareDate_YYYMMDD_HHMM(date1:Date,date2:Date) -> Bool{
    let dateComp1 = Calendar.current.dateComponents([ .year, .month, .day, .hour, .minute], from: date1)
    
    let dataComp2 = Calendar.current.dateComponents([ .year, .month, .day, .hour, .minute], from: date2)
    
    let compareFlag = dataComp2.year == dateComp1.year && dataComp2.month == dateComp1.month && dataComp2.day == dateComp1.day && dataComp2.hour == dateComp1.hour && dataComp2.minute == dateComp1.minute
    
    if compareFlag{
        return true
    }else{
        return false
    }
}
//MARK: - 年月日時の比較
func CompareDate_YYYMMDD_HH(date1:Date,date2:Date) -> Bool{
    let dateComp1 = Calendar.current.dateComponents([ .year, .month, .day, .hour], from: date1)
    
    let dataComp2 = Calendar.current.dateComponents([ .year, .month, .day, .hour], from: date2)
    
    let compareFlag = dataComp2.year == dateComp1.year && dataComp2.month == dateComp1.month && dataComp2.day == dateComp1.day && dataComp2.hour == dateComp1.hour
    
    if compareFlag{
        return true
    }else{
        return false
    }
}
//MARK: - 年月日の比較
func CompareDate_YYYMMDD(date1:Date,date2:Date) -> Bool{
    let dateComp1 = Calendar.current.dateComponents([ .year, .month, .day], from: date1)
    
    let dataComp2 = Calendar.current.dateComponents([ .year, .month, .day], from: date2)
    
    let compareFlag = dataComp2.year == dateComp1.year && dataComp2.month == dateComp1.month && dataComp2.day == dateComp1.day
    
    if compareFlag{
        return true
    }else{
        return false
    }
}
//MARK: - 年月の比較
func CompareDate_YYYYMM(date1:Date,date2:Date) -> Bool{
    let dateComp1 = Calendar.current.dateComponents([ .year, .month], from: date1)
    
    let dataComp2 = Calendar.current.dateComponents([ .year, .month], from: date2)
    
    let compareFlag = dataComp2.year == dateComp1.year && dataComp2.month == dateComp1.month
    
    if compareFlag{
        return true
    }else{
        return false
    }
}
//MARK: - 年の比較
func CompareDate_YYYY(date1:Date,date2:Date) -> Bool{
    let dateComp1 = Calendar.current.dateComponents([ .year], from: date1)
    
    let dataComp2 = Calendar.current.dateComponents([ .year], from: date2)
    
    let compareFlag = dataComp2.year == dateComp1.year
    
    if compareFlag{
        return true
    }else{
        return false
    }
}

