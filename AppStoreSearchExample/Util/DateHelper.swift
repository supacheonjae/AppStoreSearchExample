//
//  DateHelper.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import Foundation

class DateHelper {

    static func intervalSinceNow(from string: String) -> (_ format: String) -> (String) {
        
        let formatter = DateFormatter()
        
        return { format in
            formatter.dateFormat = format
            
            guard let date = formatter.date(from: string) else {
                return "알 수 없음"
            }
            
            let diff = abs(date.timeIntervalSinceNow)
            
            let minute = 60.0
            let hour = 60.0 * minute
            let day = 24.0 * hour
            let month = 30 * day
            let year = 365.0 * day
            
            switch diff {
            case ..<hour:
                return "\(Int(diff / minute))분 전"

            case ..<day:
                return "\(Int(diff / hour))시간 전"
                
            case ..<month:
                return "\(Int(diff / day))일 전"

            case ..<year:
                return "\(Int(diff / month))개월 전"
                
            default:
                return "\(Int(diff / year))년 전"
            }
        }
    }
}
