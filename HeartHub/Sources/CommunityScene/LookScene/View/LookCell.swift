//
//  LookCell.swift
//  HeartHub
//
//  Created by 이태영 on 2023/07/20.
//

import UIKit

final class LookCell: UICollectionViewCell, CommunityCellable {
    weak var transitionDelegate: CommunityCellTransitionDelegate?
    var communityCellDataSource: CommunityCellDataSource? {
        didSet {
            bind(to: communityCellDataSource)
            let task = communityCellDataSource?.fetchCellContents()
            tasks = task ?? []
        }
    }
    
    var tasks: [Cancellable?] = []
    private let headerView = CommunityCellHeaderView()
    private let pagingImageView = CommunityCellPagingImageView()
    private let bottomButtonView = CommunityCellBottomButtonView()
    
    private let postLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubview()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(to dataSource: CommunityCellDataSource?) {
        dataSource?.commentCountPublisher = { [weak self] count in
            self?.bottomButtonView.commentCountLabel.text = count.description
        }
        
        dataSource?.authorProfileInformationPublisher = { [weak self] username, imageData in
            var authorProfile: (String, UIImage) = (username, UIImage())
            
            if let imageData = imageData,
               let image = UIImage(data: imageData)
            {
                authorProfile.1 = image
            } else {
                authorProfile.1 = UIImage(named: "basicProfileImage")!
            }
            
            self?.headerView.configureContents(authorProfile)
        }
        
        dataSource?.heartStatusPublisher = { [weak self] isHeart in
            self?.bottomButtonView.heartButton.isSelected = isHeart
        }
        
        dataSource?.goodInformationPublisher = { [weak self] isGood, count in
            self?.bottomButtonView.thumbButton.isSelected = isGood
            self?.bottomButtonView.thumbCountLabel.text = count.description
        }
        
        dataSource?.imagesPublisher = { [weak self] imageData in
            let images = imageData.map { UIImage(data: $0) }
            self?.pagingImageView.configureContents(images)
        }
        
        dataSource?.contentPublisher = { [weak self] content in
            self?.postLabel.text = content
        }
    }
    
    // MARK: - override
    override func prepareForReuse() {
        tasks.forEach {
            $0?.cancel()
        }
    }
}

// MARK: Public Interface
extension LookCell {
    func fetchAdjustedHeight() -> CGFloat {
        return pagingImageView.bounds.height
    }
}

// MARK: Configure UI
extension LookCell {
    private func configureSubview() {
        [headerView, pagingImageView, bottomButtonView, postLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.addSubview(pagingImageView)
        pagingImageView.addSubview(headerView)
        pagingImageView.addSubview(bottomButtonView)
        pagingImageView.addSubview(postLabel)
        
        headerView.delegate = self
        bottomButtonView.delegate = self
    }
    
    private func configureLayout() {
        let contentViewSafeArea = contentView.safeAreaLayoutGuide
        let pagingImageViewSafeArea = pagingImageView.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            // MARK: profileView Constraint
            headerView.topAnchor.constraint(
                equalTo: pagingImageViewSafeArea.topAnchor
            ),
            headerView.leadingAnchor.constraint(
                equalTo: pagingImageViewSafeArea.leadingAnchor,
                constant: 12
            ),
            headerView.trailingAnchor.constraint(
                equalTo: pagingImageViewSafeArea.trailingAnchor,
                constant: -12
            ),
            headerView.heightAnchor.constraint(
                equalTo: headerView.widthAnchor,
                multiplier: 0.15
            ),
            
            // MARK: pagingImageView Constarint
            pagingImageView.topAnchor.constraint(
                equalTo: contentViewSafeArea.topAnchor
            ),
            pagingImageView.leadingAnchor.constraint(
                equalTo: contentViewSafeArea.leadingAnchor
            ),
            pagingImageView.trailingAnchor.constraint(
                equalTo: contentViewSafeArea.trailingAnchor
            ),
            pagingImageView.bottomAnchor.constraint(
                equalTo: contentViewSafeArea.bottomAnchor
            ),

            
            // MARK: bottomButtonView Constraint
            bottomButtonView.bottomAnchor.constraint(
                equalTo: pagingImageView.bottomAnchor
            ),
            bottomButtonView.leadingAnchor.constraint(
                equalTo: pagingImageViewSafeArea.leadingAnchor,
                constant: 3
            ),
            bottomButtonView.trailingAnchor.constraint(
                equalTo: pagingImageViewSafeArea.trailingAnchor,
                constant: -3
            ),
            bottomButtonView.heightAnchor.constraint(
                equalTo: headerView.heightAnchor
            ),
            
            // MARK: postLabel Constraints
            postLabel.leadingAnchor.constraint(
                equalTo: pagingImageViewSafeArea.leadingAnchor,
                constant: 18
            ),
            postLabel.trailingAnchor.constraint(
                equalTo: pagingImageViewSafeArea.trailingAnchor,
                constant: -18
            ),
            postLabel.bottomAnchor.constraint(
                equalTo: bottomButtonView.topAnchor
            ),
        ])
        
    }
}
