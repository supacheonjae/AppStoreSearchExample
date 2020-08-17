//
//  ResultsTableController.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/15.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ResultsTableController: UITableViewController {
    
    weak var mainTableVCDelegate: MainTableViewControllerDelegate?
    
    let rx_searchInAppStore = PublishSubject<String>()
    let rx_searchInHistory = PublishRelay<String>()
    private var searchViewModel: SearchViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = nil
        tableView.dataSource = nil
        
        setupViewModel()
        setupRxTableViewDataSource()
        setupRxTableViewDelegate()
    }
    
    private func setupViewModel() {
        searchViewModel = SearchViewModel(
            rx_searchInHistory: rx_searchInHistory.asObservable(),
            rx_searchInAppStore: rx_searchInAppStore
        )
    }
    
    private func setupRxTableViewDataSource() {
        
        func convertUserRating(count: Int) -> String? {
            switch count {
            case ..<1000:
                return "\(count)"
                
            case ..<10000:
                let temp = Double(count) / 1000.0
                return String(format: "%.2f천", temp)
                
            case ..<100000:
                let temp = Double(count) / 10000.0
                return String(format: "%.1f만", temp)
                
            default:
                return "\(count / 10000)만"
            }
        }
        
        searchViewModel
            .rx_results
            .bind(to: tableView.rx.items)
            { (tv, idx, result) in
                
                switch result {
                case .history(let keyword):
                    let cell = tv.dequeueReusableCell(withIdentifier: "HistoryResultCell") as! HistoryResultCell
                    cell.keywordLabel.text = keyword
                    
                    return cell
                    
                case .appStore(let appInfo):
                    let cell = tv.dequeueReusableCell(withIdentifier: "AppStoreResultCell") as! AppStoreResultCell
                    cell.ratingStarView.rating = appInfo.averageUserRatingForCurrentVersion
                    cell.titleLabel.text = appInfo.trackName

                    let descArr = appInfo.description.split(separator: "\n")
                    cell.subtitleLabel.text = descArr.count > 0 ? String(descArr[0]) : appInfo.primaryGenreName
                    cell.ratingCountLabel.text = convertUserRating(count: appInfo.userRatingCount)
                    
                    // Icon Image
                    if let iconUrl = appInfo.artworkUrl100 {
                        cell.iconImageView.setImage(from: iconUrl)
                    }
                    
                    // Preview Images
                    for (i, imageUrl) in appInfo.screenshotUrls.enumerated() {
                        guard i < 3 else { break }
                        cell.previewImageViews[i].setImage(from: imageUrl)
                    }
                    
                    return cell
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setupRxTableViewDelegate() {
        Observable.zip(tableView.rx.itemSelected,
                       tableView.rx.modelSelected(SearchViewModel.SearchResult.self))
            .subscribe(onNext: { [weak self] indexPath, result in
                
                switch result {
                case .history(let keyword):
                    self?.rx_searchInAppStore.onNext(keyword)
                    self?.mainTableVCDelegate?.updateSearchBar(keyword: keyword)
                    
                case .appStore(let appInfo):
                    let detailViewController = DetailViewController.detailViewControllerForAppInfo(appInfo)
                    
                    self?.mainTableVCDelegate?.pushVC(detailViewController, animated: true)
                    
                    self?.tableView.deselectRow(at: indexPath, animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
}
