//
//  LocationPermissionViewController.swift
//  RefillStation
//
//  Created by kong on 2023/02/03.
//

import UIKit
import SnapKit
import CoreLocation

final class LocationPermissionViewController: UIViewController {
    var coordinator: OnboardingCoordinator?
    private let locationManager = CLLocationManager()

    private let outerView: UIView = {
        let view = UIView()
        return view
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "위치정보 수집에 동의하시면"
        label.font = .font(style: .bodyMedium)
        label.textColor = Asset.Colors.gray5.color
        return label
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 주변에 있는 리필스테이션을\n빠르게 확인할 수 있어요!"
        label.font = .font(style: .titleLarge2)
        label.textColor = Asset.Colors.gray7.color
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Asset.Images.imageLocationInfo.image
        return imageView
    }()

    private lazy var confirmBotton: CTAButton = {
        let button = CTAButton(style: .basic)
        button.setTitle("동의하고 시작하기", for: .normal)
        button.addAction(UIAction(handler: { _ in
            self.requestAuthorization()
        }), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layout()
        locationManager.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = Asset.Colors.gray7.color
    }

    override func viewWillDisappear(_ animated: Bool) {
        AppDelegate.setUpNavigationBar()
    }

    private func layout() {
        [outerView, confirmBotton].forEach { view.addSubview($0) }
        outerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(57)
            $0.height.equalTo(367)
        }
        confirmBotton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(6)
            $0.height.equalTo(50)
        }

        [descriptionLabel, titleLabel, imageView].forEach { outerView.addSubview($0) }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            $0.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(260)
            $0.bottom.equalToSuperview()
        }
    }

    private func requestAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            self.coordinator?.agreeAndStartButtonTapped()
        case .notDetermined, .restricted:
            self.locationManager.requestWhenInUseAuthorization()
        case .denied:
            openSetting()
        default:
            break
        }
    }

    private func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}

extension LocationPermissionViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
//            self.coordinator?.agreeAndStartButtonTapped()
            break
        default: break
        }
    }
}
