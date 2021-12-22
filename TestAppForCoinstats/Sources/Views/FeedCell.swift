
import UIKit

class FeedCell: UITableViewCell, CellConfigurable {
    
    var viewModel: PhotoCellViewModel?

    @IBOutlet weak var feedImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var readView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? PhotoCellViewModel else { return }
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.desc
        self.feedImage.image = viewModel.image.image

        viewModel.image.startDownload()
        viewModel.image.completeDownload = { [weak self] image in
            self?.feedImage.image = image
        }

        setNeedsLayout()
    }
}
