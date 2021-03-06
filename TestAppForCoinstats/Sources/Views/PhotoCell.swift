

import UIKit
class PhotoCell: UITableViewCell, CellConfigurable {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)

        label.textColor = UIColor.darkGray
        label.font = UIFont(name: "AmericanTypewriter", size: 14)
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)

        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(label)

        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        return label
    }()

    lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageView)

        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInitialView()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupInitialView()
        setupConstraints()
    }

    var viewModel: PhotoCellViewModel?

    func setup(viewModel: RowViewModel) {
        guard let viewModel = viewModel as? PhotoCellViewModel else { return }
        self.viewModel = viewModel
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.desc
        self.coverImageView.image = viewModel.image.image
        self.categoryLabel.text = viewModel.category

        viewModel.image.startDownload()
        viewModel.image.completeDownload = { [weak self] image in
            self?.coverImageView.image = image
        }

        setNeedsLayout()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.image.completeDownload = nil
        viewModel?.cellPressed = nil
    }

    private func setupInitialView() {
        self.selectionStyle = .none
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            categoryLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),

            coverImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).withPriority(priority: .defaultLow),
            coverImageView.widthAnchor.constraint(equalToConstant: 120),
            coverImageView.heightAnchor.constraint(equalToConstant: 80),

            titleLabel.topAnchor.constraint(equalTo: coverImageView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: coverImageView.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
            ])

        titleLabel.accessibilityIdentifier = "titeLabel"
        titleLabel.numberOfLines = 0
        coverImageView.accessibilityIdentifier = "coverImageView"
        descriptionLabel.accessibilityIdentifier = "descriptionLabel"
        contentView.accessibilityIdentifier = "galleryContentView"
        categoryLabel.accessibilityIdentifier = "categoryLabel"
        
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

    }

}
