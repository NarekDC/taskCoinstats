
import Foundation
import UIKit

class PhotoCellViewModel: RowViewModel, ViewModelPressible {

    let title: String
    let desc: String
    let category: String
    var image: AsyncImage

    var cellPressed: (() -> Void)?

    init(title: String, desc: String, image: AsyncImage, category: String) {
        self.title = title.decoded
        self.desc = desc.decoded
        self.image = image
        self.category = category.decoded
    }
}
