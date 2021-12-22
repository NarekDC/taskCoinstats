
import Foundation
import UIKit

class FeedListViewModel {
    let title = Observable<String>(value: "Loading")
    let isLoading = Observable<Bool>(value: false)
    let isTableViewHidden = Observable<Bool>(value: false)
    let sectionViewModels = Observable<[SectionViewModel]>(value: [])
    
    var selectedFeed: FeedInfoData?
}
