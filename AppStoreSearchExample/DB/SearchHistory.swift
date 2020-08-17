//
//  SearchHistory.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/16.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import RealmSwift

class SearchHistory: Object {
    
    @objc dynamic var keyword = ""
    @objc dynamic var searchDate = Date()
    
    override class func primaryKey() -> String? {
        return "keyword"
    }
}

extension RealmManager {
    
    func addKeyword(keyword: String) {
        
        guard getHistory().filter("keyword == %@", keyword).first == nil else { return }
        
        let searchHistory = SearchHistory()
        searchHistory.keyword = keyword
        
        try! realm.write {
            realm.add(searchHistory, update: .all)
        }
    }
    
    func getHistory() -> Results<SearchHistory> {
        return realm.objects(SearchHistory.self)
            .sorted(byKeyPath: "searchDate", ascending: false)
    }
    
    func findHistory(by keyword: String) -> Results<SearchHistory> {
        return getHistory().filter("keyword BEGINSWITH %@", keyword)
    }
}
