

import Foundation

class FeedListController {
    let viewModel: FeedListViewModel
    let apiService: ApiService

    init(viewModel: FeedListViewModel = FeedListViewModel(), apiService: ApiService = ApiService()) {
        self.viewModel = viewModel
        self.apiService = apiService
    }

    func start() {
        self.viewModel.isLoading.value = true
        self.viewModel.isTableViewHidden.value = true
        self.viewModel.title.value = "Loading..."
        
        apiService.getResults(from: topHeadlines()!) {
            [weak self] (feeds) in
            self?.viewModel.title.value = "Your Feeds"
            self?.viewModel.isLoading.value = false
            self?.viewModel.isTableViewHidden.value = false
            self?.buildViewModels(feeds: feeds)
        }
    }

    // MARK: - Data source
    func buildViewModels(feeds: [FeedInfoData]) {
        var sectionTable = [String: [RowViewModel]]()
        var vm: RowViewModel?
        for feed in feeds {
            let groupingKey = sectionGroupingKey(feed)
            let photoCellViewModel = PhotoCellViewModel(title: feed.title,
                                                             desc: feed.body,
                                                             image: AsyncImage(url: feed.coverPhotoURL),
                                                             category: feed.category)
                photoCellViewModel.cellPressed = {
                    print("Open a photo viewer!")
                }
        
            vm = photoCellViewModel
            
            if let vm = vm {
                if var rows = sectionTable[groupingKey] {
                    rows.append(vm)
                    sectionTable[groupingKey] = rows
                } else {
                    sectionTable[groupingKey] = [vm]
                }
            }
        }

        self.viewModel.sectionViewModels.value = converToSectionViewModel(sectionTable)
    }

    func cellIdentifier(for viewModel: RowViewModel) -> String {
        switch viewModel {
        case is PhotoCellViewModel:
            return PhotoCell.cellIdentifier()
        default:
            fatalError("Unexpected view model type: \(viewModel)")
        }
    }

    private func converToSectionViewModel(_ sectionTable: [String: [RowViewModel]]) -> [SectionViewModel] {
        let sortedGroupingKey = sectionTable.keys.sorted(by: dateStringDescComparator())

        return sortedGroupingKey.map {
            let rowViewModels = sectionTable[$0]!
            return SectionViewModel(rowViewModels: rowViewModels, headerTitle: $0)
        }
    }

    private func sectionGroupingKey(_ feed: FeedInfoData) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(feed.date)))
    }

    private func dateStringDescComparator() -> ((String, String) -> Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        return { (d1Str, d2Str) -> Bool in
            if let d1 = formatter.date(from: d1Str), let d2 = formatter.date(from: d2Str) {
                return d1 > d2
            } else {
                return false
            }
        }
    }
}
