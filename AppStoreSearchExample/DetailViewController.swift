//
//  DetailViewController.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/17.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import UIKit
import Cosmos
import RxSwift
import RxCocoa
import RxSwiftExt

class DetailViewController: UIViewController {
    
    private enum MoreState {
        case more, ellipsis
        
        var image: UIImage? {
            switch self {
            case .more:
                return UIImage(systemName: "chevron.down")
            
            case .ellipsis:
                return UIImage(systemName: "chevron.up")
            }
        }
    }
    
    private let rx_appInfo = BehaviorRelay<AppStoreModel?>(value: nil)
    private var appInfo: Observable<AppStoreModel> {
        return rx_appInfo.unwrap()
    }
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // 헤더
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    
    // Rating 정보
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var ratingsStarView: CosmosView!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var contentRatingLabel: UILabel!
    
    // 업데이트 내용
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var currentVersionReleaseDateIntervalLabel: UILabel!
    @IBOutlet weak var updateDescLabel: UILabel!
    @IBOutlet weak var moreUpdateDescBtn: UIButton!
    
    // 프리뷰
    @IBOutlet weak var collectionView: UICollectionView!
    
    // 앱 설명
    @IBOutlet weak var appDescLabel: UILabel!
    @IBOutlet weak var moreAppDescBtn: UIButton!
    
    // 판매자 앱들 링크 버튼
    @IBOutlet weak var artistBtn: UIButton!
    @IBOutlet var artistBtns: [UIButton]!
    
    // 앱 정보들
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    @IBOutlet weak var appCategoryLabel: UILabel!
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var languageMoreBtn: UIButton!
    @IBOutlet weak var languageMoreView: UIView!
    @IBOutlet weak var allLanguagesLabel: UILabel!
    @IBOutlet weak var contentRatingLabel2: UILabel!
    
    // 판매자 웹사이트 링크 버튼
    @IBOutlet var sellerWebsiteLinkBtns: [UIButton]!
    
    
    // MARK: - Initialization
    
    class func detailViewControllerForAppInfo(_ appInfo: AppStoreModel) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let viewController =
            storyboard.instantiateViewController(withIdentifier: "DetailViewController")
        
        if let detailViewController = viewController as? DetailViewController {
            Observable.just(appInfo)
                .bind(to: detailViewController.rx_appInfo)
                .disposed(by: detailViewController.disposeBag)
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)

        setupRxHeader()
        setupRxRatingsInfo()
        setupRxUpdateInfo()
        setupRxPreview()
        setupRxAppDesc()
        setupRxAppInfo()
        setupRxLinkButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupRxHeader() {
        appInfo
            .map { $0.artworkUrl512 }
            .unwrap()
            .subscribe(onNext: { [weak self] iconUrl in
                self?.iconImageView.setImage(from: iconUrl)
            })
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.trackName }
            .bind(to: appNameLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.sellerName }
            .bind(to: sellerNameLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupRxRatingsInfo() {
        appInfo
            .map { $0.averageUserRating }
            .map { String(format: "%.1f", $0) }
            .bind(to: ratingsLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.averageUserRating }
            .subscribe(onNext: { [weak self] rating in
                self?.ratingsStarView.rating = rating
            })
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.userRatingCount }
            .map { userRatingCount in
                switch userRatingCount {
                case ..<1000:
                    return "\(userRatingCount)"
                    
                case ..<10000:
                    let temp = Double(userRatingCount) / 1000.0
                    return String(format: "%.2f천", temp)
                    
                case ..<100000:
                    let temp = Double(userRatingCount) / 10000.0
                    return String(format: "%.1f만", temp)
                    
                default:
                    return "\(userRatingCount / 10000)만"
                }
            }
            .map { String(format: "%@개의 평가", $0) }
            .bind(to: ratingsCountLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.trackContentRating }
            .bind(to: contentRatingLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupRxUpdateInfo() {
        appInfo
            .map { $0.version }
            .map { String(format: "버전 %@", $0) }
            .bind(to: versionLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.currentVersionReleaseDate }
            .map { DateHelper.intervalSinceNow(from: $0)("yyyy-MM-dd'T'HH:mm:ss'Z'")
            }
            .bind(to: currentVersionReleaseDateIntervalLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.releaseNotes }
            .bind(to: updateDescLabel.rx.text)
            .disposed(by: disposeBag)
        
        moreUpdateDescBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                
                if self?.updateDescLabel.numberOfLines == 3 {
                    // 펼치기
                    self?.updateDescLabel.alpha = 0
                    UIView.animate(withDuration: 0.2) {
                        self?.updateDescLabel.alpha = 1
                        self?.updateDescLabel.numberOfLines = 0
                        self?.moreUpdateDescBtn.setTitle("접기", for: .normal)
                        self?.scrollView.layoutIfNeeded()
                    }
                } else {
                    // 접기
                    self?.updateDescLabel.alpha = 0
                    UIView.animate(withDuration: 0.2) {
                        self?.updateDescLabel.alpha = 1
                        self?.updateDescLabel.numberOfLines = 3
                        self?.moreUpdateDescBtn.setTitle("더 보기", for: .normal)
                        self?.scrollView.layoutIfNeeded()
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupRxPreview() {
        appInfo
            .map { $0.screenshotUrls }
            .bind(to: collectionView.rx.items(cellIdentifier: "PreviewCollectionViewCell", cellType: PreviewCollectionViewCell.self))
            { (row, imageUrl, cell) in

                cell.previewImageView.setImage(from: imageUrl) { [weak self] image in
                    
                    cell.previewImageView.image = image
                    self?.collectionView.collectionViewLayout.invalidateLayout()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setupRxAppDesc() {
        appInfo
            .map { $0.description }
            .bind(to: appDescLabel.rx.text)
            .disposed(by: disposeBag)
        
        moreAppDescBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                
                if self?.appDescLabel.numberOfLines == 3 {
                    // 펼치기
                    self?.appDescLabel.alpha = 0
                    UIView.animate(withDuration: 0.2) {
                        self?.appDescLabel.alpha = 1
                        self?.appDescLabel.numberOfLines = 0
                        self?.moreAppDescBtn.setTitle("접기", for: .normal)
                        self?.scrollView.layoutIfNeeded()
                    }
                } else {
                    // 접기
                    self?.appDescLabel.alpha = 0
                    UIView.animate(withDuration: 0.2) {
                        self?.appDescLabel.alpha = 1
                        self?.appDescLabel.numberOfLines = 3
                        self?.moreAppDescBtn.setTitle("더 보기", for: .normal)
                        self?.scrollView.layoutIfNeeded()
                    }
                }
            })
            .disposed(by: disposeBag)
            
        appInfo
            .map { $0.artistName }
            .bind(to: artistBtn.rx.title())
            .disposed(by: disposeBag)
    }
    
    private func setupRxAppInfo() {
        
        func covertToFileString(with size: String) -> String {
            
            guard let size = Int(size) else { return "0 bytes" }
            
            var convertedValue: Double = Double(size)
            var multiplyFactor = 0
            let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
            while convertedValue > 1024 {
                convertedValue /= 1024
                multiplyFactor += 1
            }
            return String(format: "%.1f %@", convertedValue, tokens[multiplyFactor])
        }
        
        appInfo
            .map { $0.artistName }
            .bind(to: providerLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.fileSizeBytes }
            .map { covertToFileString(with: $0) }
            .bind(to: fileSizeLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.primaryGenreName }
            .bind(to: appCategoryLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.languageCodesISO2A }
            .filter { $0.count > 0 }
            .map { languageCodes -> String in
                guard let firstLang = languageCodes.first,
                    let langFullName = Locale.current.localizedString(forLanguageCode: firstLang)
                    else { return "Unknown" }
                
                var text = langFullName
                
                if languageCodes.count > 1 {
                    text.append(" and \(languageCodes.count - 1) More")
                }
                
                return text
            }
            .bind(to: languagesLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.languageCodesISO2A }
            .filter { $0.count > 0 }
            .map { languageCodes -> String in
                guard let firstLang = languageCodes.first,
                    let langFullName = Locale.current.localizedString(forLanguageCode: firstLang)
                    else { return "Unknown" }
                
                var text = langFullName
                
                if languageCodes.count > 1 {
                    text.append("and \(languageCodes.count - 1) More")
                }
                
                return text
            }
            .bind(to: languagesLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.languageCodesISO2A }
            .filter { $0.count > 1 }
            .map { languageCodes in
                return languageCodes.reduce("") { result, lang -> String in
                    guard let langFullName = Locale.current.localizedString(forLanguageCode: lang) else {
                        return result
                    }
                    
                    return result.isEmpty ? "\(langFullName)" : "\(result), \(langFullName)"
                }
            }
            .bind(to: allLanguagesLabel.rx.text)
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.languageCodesISO2A }
            .map { $0.count < 2 }
            .bind(to: languageMoreBtn.rx.isHidden)
            .disposed(by: disposeBag)
        
        languageMoreBtn.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let isHidden = self?.languageMoreView.isHidden else { return }
                
                if isHidden {
                    UIView.animate(withDuration: 0.2) {
                        self?.languageMoreView.isHidden = false
                        self?.languageMoreBtn.setImage(MoreState.ellipsis.image, for: .normal)
                        self?.languageMoreView.alpha = 1
                        self?.scrollView.layoutIfNeeded()
                    }
                } else {
                    UIView.animate(withDuration: 0.2) {
                        self?.languageMoreView.isHidden = true
                        self?.languageMoreBtn.setImage(MoreState.more.image, for: .normal)
                        self?.languageMoreView.alpha = 0
                        self?.scrollView.layoutIfNeeded()
                    }
                }
            })
            .disposed(by: disposeBag)
        
        appInfo
            .map { $0.trackContentRating }
            .bind(to: contentRatingLabel2.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func setupRxLinkButtons() {
        
        func openLinkUrl(string url: String) {
            guard let url = URL(string: url),
                UIApplication.shared.canOpenURL(url)
                else { return }
                
            UIApplication.shared.open(url)
            
        }
        
        artistBtns.forEach { btn in
            btn.rx.tap
                .withLatestFrom(appInfo)
                .map { $0.artistViewUrl }
                .unwrap()
                .subscribe(onNext: { artistViewUrl in
                    openLinkUrl(string: artistViewUrl)
                })
                .disposed(by: disposeBag)
        }
        
        sellerWebsiteLinkBtns.forEach { btn in
            btn.rx.tap
                .withLatestFrom(appInfo)
                .map { $0.sellerUrl }
                .unwrap()
                .subscribe(onNext: { sellerUrl in
                    openLinkUrl(string: sellerUrl)
                })
                .disposed(by: disposeBag)
        }
    }
}


extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? PreviewCollectionViewCell else {
            let scale: CGFloat = 9.0 / 16.0
            return CGSize(width: collectionView.frame.size.height * scale, height: collectionView.frame.size.height)
        }
        
        if let image = cell.previewImageView.image {
            let scale = image.size.width / image.size.height
            
            return CGSize(width: collectionView.frame.size.height * scale, height: collectionView.frame.size.height)
        }
        
        return CGSize(width: cell.frame.size.width, height: cell.frame.size.height)
    }
}
