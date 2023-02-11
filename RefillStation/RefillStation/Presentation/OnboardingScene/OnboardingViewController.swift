//
//  OnboardingViewController.swift
//  RefillStation
//
//  Created by 천수현 on 2023/01/16.
//

import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {

    var coordinator: OnboardingCoordinator?
    private let viewModel: OnboardingViewModel

    private lazy var onboardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OnboardingCollectionViewCell.self,
                                forCellWithReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = viewModel.onboardingCardImages.count
        pageControl.pageIndicatorTintColor = Asset.Colors.gray2.color
        pageControl.currentPageIndicatorTintColor = Asset.Colors.primary10.color
        pageControl.addAction(UIAction { _ in
            self.onboardingCollectionView.setContentOffset(CGPoint(
                x: CGFloat(pageControl.currentPage) *  CGFloat(self.onboardingCollectionView.frame.width),
                y: self.onboardingCollectionView.contentOffset.y
            ), animated: true)
        }, for: .valueChanged)
        return pageControl
    }()

    private lazy var startButton: CTAButton = {
        let button = CTAButton(style: .basic)
        button.setTitle("시작하기", for: .normal)
        button.addAction(UIAction { _ in
            self.coordinator?.showLogin()
        }, for: .touchUpInside)
        return button
    }()

    init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }

    private func layout() {
        [onboardingCollectionView, pageControl, startButton].forEach {
            view.addSubview($0)
        }

        onboardingCollectionView.snp.makeConstraints {
            $0.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(340)
        }

        pageControl.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(onboardingCollectionView.snp.top).offset(-48)
        }

        startButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(18)
            $0.height.equalTo(50)
        }
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.onboardingCardImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OnboardingCollectionViewCell.reuseIdentifier, for: indexPath
        ) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.setUpContents(title: viewModel.onboardingCardTitles[indexPath.row],
                           image: viewModel.onboardingCardImages[indexPath.row])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if onboardingCollectionView.frame.width == 0 { return }
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width/2)
        let newPage = Int(x/width)
        if pageControl.currentPage != newPage {
            pageControl.currentPage = newPage
        }
    }
}
