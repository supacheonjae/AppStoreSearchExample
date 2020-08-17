//
//  SearchRequest.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/16.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import Foundation

class AppStoreRequest: APIRequest {
    var method = RequestType.GET
    var path = "search"
    var parameters = [String: String]()

    init(term: String) {
        parameters["media"] = "software"
        parameters["term"] = term
    }
}
