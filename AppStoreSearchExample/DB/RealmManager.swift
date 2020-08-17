//
//  RealmManager.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/16.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import RealmSwift

class RealmManager {

    static var instance = RealmManager()
    
    lazy var realm = self.getRealm()
    
    private init() { }
    
    private func getRealm() -> Realm {
        return try! Realm()
    }
}
