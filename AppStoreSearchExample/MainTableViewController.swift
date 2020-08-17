//
//  MainTableViewController.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/15.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRealm

protocol MainTableViewControllerDelegate: class {
    func pushVC(_ viewController: UIViewController, animated: Bool)
    func popVC(animated: Bool)
    func updateSearchBar(keyword: String)
}

class MainTableViewController: UITableViewController {
    
    var searchController: UISearchController!
    private var resultsTableController: ResultsTableController!
    
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = nil
        tableView.delegate = nil
        
        resultsTableController = storyboard?.instantiateViewController(withIdentifier: "ResultsTableController") as? ResultsTableController
        resultsTableController.mainTableVCDelegate = self
        
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupRxSearchBar()
        setupRxTableViewDataSource()
        setupRxTableViewDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupRxSearchBar() {
        searchController.searchBar.rx.text
            .orEmpty
            .bind(to: resultsTableController.rx_searchInHistory)
            .disposed(by: disposeBag)
        searchController.searchBar.rx.searchButtonClicked
            .withLatestFrom(searchController.searchBar.rx.text.orEmpty)
            .bind(to: resultsTableController.rx_searchInAppStore)
            .disposed(by: disposeBag)
    }

    private func setupRxTableViewDataSource() {
        let history = RealmManager.instance.getHistory()
        
        Observable.collection(from: history)
            .bind(to: tableView.rx.items)
            { (tv, row, item) in
                let cell = tv.dequeueReusableCell(withIdentifier: "RecentsCell", for: IndexPath(row: row, section: 0)) as! RecentsCell
                
                cell.keywordLabel.text = item.keyword
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    private func setupRxTableViewDelegate() {
        Observable.zip(tableView.rx.itemSelected,
                       tableView.rx.modelSelected(SearchHistory.self))
            .subscribe(onNext: { [weak self] indexPath, historyItem in
                self?.searchController.isActive = true
                self?.updateSearchBar(keyword: historyItem.keyword)
                
                self?.tableView.deselectRow(at: indexPath, animated: true)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self?.resultsTableController.rx_searchInAppStore.onNext(historyItem.keyword)
                }
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - MainTableViewControllerDelegate

extension MainTableViewController: MainTableViewControllerDelegate {
    func pushVC(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popVC(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func updateSearchBar(keyword: String) {
        searchController.searchBar.text = keyword
        searchController.searchBar.resignFirstResponder()
    }
}
