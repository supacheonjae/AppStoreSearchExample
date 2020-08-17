//
//  SearchViewModel.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/16.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class SearchViewModel {
    
    enum SearchResult {
        case history(result: String)
        case appStore(result: AppStoreModel)
    }
    
    private let apiClient = APIClient()

    private let rx_searchInHistory: Observable<String>
    private let rx_searchInAppStore: Observable<String>
    
    lazy var rx_results = searchResult()
    
    private let disposeBag = DisposeBag()
    
    init(rx_searchInHistory: Observable<String>,
         rx_searchInAppStore: Observable<String>) {
        
        self.rx_searchInHistory = rx_searchInHistory
        self.rx_searchInAppStore = rx_searchInAppStore
        
        setupRxForDB()
    }
    
    private func setupRxForDB() {
        rx_searchInAppStore
            .subscribe(onNext: { keyword in
                RealmManager.instance.addKeyword(keyword: keyword)
            })
            .disposed(by: disposeBag)
    }
    
    private func searchResult() -> Observable<[SearchResult]> {
        let rx_resultsHistory = rx_searchInHistory
            .map { term -> Results<SearchHistory> in
                return RealmManager.instance.findHistory(by: term)
            }
            .map { results -> [SearchResult] in
                return results.map { .history(result: $0.keyword) }
            }
        
        let rx_resultsAppStore = rx_searchInAppStore
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { AppStoreRequest(term: $0) }
            .flatMapLatest { [weak self] request -> Observable<AppStoreResultModel> in
                return self?.apiClient.send(apiRequest: request) ?? .empty()
            }
            .map { $0.results }
            .map { results -> [SearchResult] in
                return results.map { .appStore(result: $0) }
            }
            .observeOn(MainScheduler.instance)
        
        return Observable.merge(rx_resultsHistory, rx_resultsAppStore)
    }
}
