//
//  DetailPhotoReviewViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/17.
//

import UIKit

final class DetailPhotoReviewViewController: UIViewController {

    private let viewModel: DetailPhotoReviewViewModel

    private lazy var orthogonalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        return scrollView
    }()

    private let photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = Asset.Colors.gray0.color
        return stackView
    }()

    private lazy var moveLeftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.backgroundColor = Asset.Colors.gray3.color.withAlphaComponent(0.5)
        button.tintColor = .white
        button.isHidden = true
        button.imageView?.contentMode = .scaleAspectFit
        button.addAction(UIAction { _ in
            if self.viewModel.page > 0 {
                self.viewModel.page -= 1
                self.scrollToCurrentPage()
            }
        }, for: .touchUpInside)
        return button
    }()

    private lazy var moveRightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.backgroundColor = Asset.Colors.gray3.color.withAlphaComponent(0.5)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.addAction(UIAction { _ in
            if self.viewModel.page < self.viewModel.photos.count - 1 {
                self.viewModel.page += 1
                self.scrollToCurrentPage()
            }
        }, for: .touchUpInside)
        return button
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addAction(UIAction { _ in
            self.navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)
        return button
    }()

    private lazy var pageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "1 / "
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    private lazy var maxPageCountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.photos.count)"
        label.textColor = Asset.Colors.gray4.color
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()

    init(viewModel: DetailPhotoReviewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = DetailPhotoReviewViewModel(photoURLs: [])
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        bind()
        layout()
        addPhotosToStackView()
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = false
    }

    private func bind() {
        viewModel.setUpPageLabel = {
            self.pageCountLabel.text = "\(self.viewModel.page + 1) / "
        }
    }

    private func layout() {
        [orthogonalScrollView, moveLeftButton, moveRightButton, backButton, maxPageCountLabel, pageCountLabel].forEach {
            view.addSubview($0)
        }

        orthogonalScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        moveLeftButton.snp.makeConstraints {
            $0.leading.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.height.width.equalTo(44)
        }

        moveRightButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.height.width.equalTo(44)
        }

        backButton.snp.makeConstraints {
            $0.leading.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.width.equalTo(24)
        }

        maxPageCountLabel.snp.makeConstraints {
            $0.trailing.top.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        pageCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.trailing.equalTo(maxPageCountLabel.snp.leading)
        }

        orthogonalScrollView.addSubview(photoStackView)

        photoStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.66)
        }
    }

    private func addPhotosToStackView() {
        viewModel.photos.forEach {
            let imageView = UIImageView(image: $0)
            imageView.contentMode = .scaleAspectFit
            photoStackView.addArrangedSubview(imageView)
            imageView.snp.makeConstraints {
                $0.width.equalTo(view)
                $0.top.bottom.equalToSuperview()
            }
        }
    }

    private func scrollToCurrentPage() {
        self.orthogonalScrollView.setContentOffset(
            CGPoint(x: self.orthogonalScrollView.frame.width * CGFloat(self.viewModel.page),
                    y: self.orthogonalScrollView.contentOffset.y),
            animated: true)
    }
}

extension DetailPhotoReviewViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if orthogonalScrollView.frame.width == 0 { return }
        let page = orthogonalScrollView.contentOffset.x / orthogonalScrollView.frame.width
        let flooredPage = floor(page)
        if flooredPage != page { return }

        if viewModel.page != Int(page)
            && (0...viewModel.photos.count - 1) ~= Int(page) { viewModel.page = Int(page) }
        if viewModel.page == 0 {
            moveLeftButton.isHidden = true
            moveRightButton.isHidden = false
        } else if viewModel.page == viewModel.photos.count - 1 {
            moveLeftButton.isHidden = false
            moveRightButton.isHidden = true
        } else {
            moveLeftButton.isHidden = false
            moveRightButton.isHidden = false
        }
    }
}
