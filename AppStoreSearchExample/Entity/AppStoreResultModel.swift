//
//  AppStoreResultModel.swift
//  AppStoreSearchExample
//
//  Created by Yun Ha on 2020/08/16.
//  Copyright © 2020 Yun Ha. All rights reserved.
//

import Foundation

struct AppStoreResultModel: Codable {
    let resultCount: Int
    let results: [AppStoreModel]
    
    private enum CodingKeys: String, CodingKey {
        case resultCount, results
    }
}

struct AppStoreModel: Codable {
    let supportedDevices: [String]
    // ["iPadMini-iPadMini", "iPadAirCellular-iPadAirCellular", "iPhone6s-iPhone6s", "iPhone4S-iPhone4S", "iPadThirdGen4G-iPadThirdGen4G", "iPadAir2Cellular-iPadAir2Cellular", "iPadMini5-iPadMini5", "iPadMini4Cellular-iPadMini4Cellular", "iPhoneXR-iPhoneXR", "iPadThirdGen-iPadThirdGen", "iPhone5s-iPhone5s", "iPad834-iPad834", "iPhone7-iPhone7", "iPad74-iPad74", "iPadPro97Cellular-iPadPro97Cellular", "iPadProSecondGen-iPadProSecondGen", "iPodTouchFifthGen-iPodTouchFifthGen", "iPad612-iPad612", "iPhone11Pro-iPhone11Pro", "iPhone6sPlus-iPhone6sPlus", "iPadMini3Cellular-iPadMini3Cellular", "iPadAir2-iPadAir2", "iPhoneXS-iPhoneXS", "iPhoneXSMax-iPhoneXSMax", "iPhoneSESecondGen-iPhoneSESecondGen", "iPadMini5Cellular-iPadMini5Cellular", "iPadFourthGen-iPadFourthGen", "iPhone8Plus-iPhone8Plus", "iPadFourthGen4G-iPadFourthGen4G", "iPhone8-iPhone8", "iPadMini4G-iPadMini4G", "iPad878-iPad878", "iPadProCellular-iPadProCellular", "iPad856-iPad856", "iPhone6-iPhone6", "iPadPro97-iPadPro97", "iPad72-iPad72", "iPodTouchSeventhGen-iPodTouchSeventhGen", "iPadAir3-iPadAir3", "iPadSeventhGen-iPadSeventhGen", "iPhone5-iPhone5", "iPad73-iPad73", "iPad75-iPad75", "iPad812-iPad812", "iPodTouchSixthGen-iPodTouchSixthGen", "iPad23G-iPad23G", "iPhoneSE-iPhoneSE", "iPadAir3Cellular-iPadAir3Cellular", "iPhone11-iPhone11", "iPadMiniRetinaCellular-iPadMiniRetinaCellular", "iPadSeventhGenCellular-iPadSeventhGenCellular", "iPadMini4-iPadMini4", "iPadProSecondGenCellular-iPadProSecondGenCellular", "iPadAir-iPadAir", "iPadPro-iPadPro", "iPadProFourthGenCellular-iPadProFourthGenCellular", "iPadProFourthGen-iPadProFourthGen", "iPhone11ProMax-iPhone11ProMax", "iPhone6Plus-iPhone6Plus", "iPad71-iPad71", "iPhone5c-iPhone5c", "iPhone7Plus-iPhone7Plus", "iPad611-iPad611", "iPadMiniRetina-iPadMiniRetina", "iPad76-iPad76", "iPad2Wifi-iPad2Wifi", "iPadMini3-iPadMini3", "iPhoneX-iPhoneX"],
    let advisories: [String] // [],
    let isGameCenterEnabled: Bool // false,
    let artworkUrl60: String? // "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/e3/26/ee/e326ee89-ada0-933e-1264-c11c656cf9b5/source/60x60bb.jpg",
    let artworkUrl512: String? // "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/e3/26/ee/e326ee89-ada0-933e-1264-c11c656cf9b5/source/512x512bb.jpg",
    let artworkUrl100: String? // "https://is1-ssl.mzstatic.com/image/thumb/Purple124/v4/e3/26/ee/e326ee89-ada0-933e-1264-c11c656cf9b5/source/100x100bb.jpg",
    let artistViewUrl: String? // "https://apps.apple.com/us/developer/kakaobank-corp/id1258016943?uo=4",
    let screenshotUrls: [String] // ["https://is3-ssl.mzstatic.com/image/thumb/Purple113/v4/95/cc/de/95ccde69-2040-598f-7c09-a79ddb982cb4/pr_source.png/392x696bb.png", "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/cd/38/96/cd389653-3c51-b1b8-a2cb-d1321f6e4019/pr_source.png/392x696bb.png", "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/df/b6/06/dfb6065b-eec7-a31c-b3f7-f3a036712692/pr_source.png/392x696bb.png", "https://is3-ssl.mzstatic.com/image/thumb/Purple113/v4/cb/ce/64/cbce64b5-03a6-0191-0dcf-7af3ee4f24d9/pr_source.png/392x696bb.png", "https://is2-ssl.mzstatic.com/image/thumb/Purple123/v4/17/6f/b3/176fb344-bdff-64af-23a0-c551a6ef33ee/pr_source.png/392x696bb.png", "https://is1-ssl.mzstatic.com/image/thumb/Purple123/v4/50/e0/be/50e0be1e-5848-75da-72ba-1421e5580775/pr_source.png/392x696bb.png", "https://is5-ssl.mzstatic.com/image/thumb/Purple113/v4/14/09/34/1409341e-c186-7b93-1532-d980216800b3/pr_source.png/392x696bb.png"],
    let ipadScreenshotUrls: [String] // [],
    let appletvScreenshotUrls: [String] // [],
    let kind: String // "software",
    let features: [String] // [],
    let trackId: Int // 1258016944,
    let trackName: String // "카카오뱅크 - 같지만 다른 은행",
    let primaryGenreId: Int // 6015,
    let primaryGenreName: String // "Finance",
    let formattedPrice: String // "Free",
    let currentVersionReleaseDate: String // "2020-08-10T01:30:35Z",
    let genreIds: [String] // ["6015"],
    let isVppDeviceBasedLicensingEnabled: Bool // true,
    let releaseNotes: String? // "2.1.3\n● 안정성 개선 및 버그 수정\n\n2.1.0\n● 내 모든 은행 계좌 카카오뱅크 하나로!\n- '내 계좌' 메뉴에서 다른은행 계좌도 간편하게 조회\n- 쉽고 빠르게 카카오뱅크로 잔액 ‘가져오기’ 기능 지원\n\n● 모임통장 회비관리 기능 강화\n- 회비 입금현황 조회 시 기간별, 멤버별 보기 가능\n- 회비 자동 분류 정교화\n- 모임주가 회비를 편집할 수 있는 기능 추가\n\n● 신분증 촬영 모듈 성능 개선",
    let releaseDate: String // "2017-07-26T15:24:27Z",
    let sellerName: String // "KakaoBank Corp.",
    let minimumOsVersion: String // "9.0",
    let trackViewUrl: String // "https://apps.apple.com/us/app/%EC%B9%B4%EC%B9%B4%EC%98%A4%EB%B1%85%ED%81%AC-%EA%B0%99%EC%A7%80%EB%A7%8C-%EB%8B%A4%EB%A5%B8-%EC%9D%80%ED%96%89/id1258016944?uo=4",
    let trackCensoredName: String // "카카오뱅크 - 같지만 다른 은행",
    let languageCodesISO2A: [String] // ["KO"],
    let fileSizeBytes: String // "420410368",
    let sellerUrl: String? // "https://www.kakaobank.com/",
    let contentAdvisoryRating: String // "4+",
    let averageUserRatingForCurrentVersion: Double // 3.5866699999999998027533365529961884021759033203125,
    let userRatingCountForCurrentVersion: Int // 75,
    let averageUserRating: Double // 3.5866699999999998027533365529961884021759033203125,
    let trackContentRating: String // "4+",
    let version: String // "2.1.3",
    let wrapperType: String // "software",
    let artistId: Int // 1258016943,
    let artistName: String // "KakaoBank Corp.",
    let genres: [String] // ["Finance"],
    let price: Float // 0.00,
    let description: String // "일상에서 더 쉽게, 더 자주 만나는 금융혁신\n제1금융권 은행 카카오뱅크\n\n■ 새롭게 디자인된 은행\n• 365일 언제나 지점 방문 없이 모든 은행 업무를 모바일에서\n• 7분만에 끝나는 쉬운 계좌개설\n\n■ 쉬운 사용성\n• 공인인증서, 보안카드 없는 계좌이체\n• 계좌번호를 몰라도 카톡 친구에게 간편 송금 (상대방이 카카오뱅크 고객이 아니어도 송금 가능)\n\n■ 내 취향대로 선택\n• 카카오프렌즈 캐릭터 디자인부터 고급스러운 블랙 컬러까지, 세련된 디자인의 체크카드\n• 내 마음대로 설정하는 계좌 이름과 색상\n\n■ 눈에 보이는 혜택\n• 복잡한 가입 조건이나 우대 조건 없이, 누구에게나 경쟁력있는 금리와 혜택 제공\n• 늘어나는 이자를 실시간으로 확인할 수 있는 정기예금\n• 만 19세 이상 대한민국 국민의 90%가 신청 가능한 비상금대출(소액 마이너스대출)\n\n■ 카카오프렌즈와 함께하는 26주적금\n• 천원부터 차곡차곡 26주동안 매주 쌓는 적금\n• 카카오프렌즈 응원과 함께하면 어느덧 만기 달성이 눈앞에!\n\n■ 알아서 차곡차곡 모아주는 저금통\n• 원하는 모으기 규칙 선택으로 부담없이 저축하기\n• 평소에는 귀여운 아이템으로, 매월 5일은 엿보기 기능으로 잔액 확인\n\n■ 함께쓰고 같이보는 모임통장\n• 손쉽게 카카오톡 친구들을 멤버로 초대 \n• 잔액과 입출금 현황을 멤버들과 함께 보기 \n• 위트있는 메시지카드로 회비 요청\n\n■ 소중한 ‘내 신용정보’ 관리\n• 제1금융권에서 안전하게 무료로 내 신용정보 확인\n• 신용 변동내역 발생 시 알림 서비스 및 신용정보 관리 꿀팁 제공\n\n■ 파격적인 수수료로 해외송금\n• 365일 언제 어디서든 이용가능한 해외송금 (보내기 및 받기)\n• 해외계좌 및 웨스턴유니온(WU)을 통해 전세계 200여 개국으로 해외송금 가능\n• 거래외국환은행 지정, 연장 업무도 지점방문없이 모바일에서 신청 가능 \n\n■ 카카오뱅크에서 만나는 제휴서비스\n• 증권사 주식계좌도 간편하게 개설 가능\n• 프렌즈 캐릭터가 함께하는 제휴 신용카드 신청 가능\n\n■ 이체수수료 및 입출금 수수료 면제\n• 타행 이체 및 자동이체 수수료 면제\n• 국내 모든 ATM(은행, 제휴 VAN사 기기) 입금/출금/이체 수수료 면제\n\n* ATM/CD기 입금/출금/이체 수수료는 향후 정책에 따라 변경될 수 있습니다. 정책이 변경되는 경우 시행 1개월 전에 카카오뱅크 앱 및 홈페이지를 통해 미리 알려드립니다.\n\n■ 고객센터 운영 시간 안내\n• 예/적금, 대출, 카드 문의 : 1599-3333 (09:00 ~ 22:00 365일)\n• 전월세 보증금 대출, 외환 문의 : 1599-3333 (09:00 ~ 18:00 평일)\n• 사고 신고 : 1599-8888 (24시간 365일)\n\n■ 챗봇 운영 시간 안내\n• 카카오톡 플러스친구 \"카카오뱅크 고객센터\" (24시간 365일)\n\n■ 카카오뱅크 앱 이용을 위한 권한 및 목적 안내\n• 카메라(선택) : 신분증 촬영 및 서류 제출, 영상통화, 프로필 사진 등록\n• 사진(선택) : 이체⁄송금⁄출금 확인증, 카드매출전표 저장\n• 위치(선택) : 부정가입방지 및 부정거래탐지\n\n * 선택 접근권한은 동의하지 않아도 서비스를 이용하실 수 있습니다.",
    let bundleId: String // "com.kakaobank.channel",
    let currency: String // "USD",
    let userRatingCount: Int // 75

    private enum CodingKeys: String, CodingKey {
        case supportedDevices
        case advisories
        case isGameCenterEnabled
        case artworkUrl60
        case artworkUrl512
        case artworkUrl100
        case artistViewUrl
        case screenshotUrls
        case ipadScreenshotUrls
        case appletvScreenshotUrls
        case kind
        case features
        case trackId
        case trackName
        case primaryGenreId
        case primaryGenreName
        case formattedPrice
        case currentVersionReleaseDate
        case genreIds
        case isVppDeviceBasedLicensingEnabled
        case releaseNotes
        case releaseDate
        case sellerName
        case minimumOsVersion
        case trackViewUrl
        case trackCensoredName
        case languageCodesISO2A
        case fileSizeBytes
        case sellerUrl
        case contentAdvisoryRating
        case averageUserRatingForCurrentVersion
        case userRatingCountForCurrentVersion
        case averageUserRating
        case trackContentRating
        case version
        case wrapperType
        case artistId
        case artistName
        case genres
        case price
        case description
        case bundleId
        case currency
        case userRatingCount
    }
}
