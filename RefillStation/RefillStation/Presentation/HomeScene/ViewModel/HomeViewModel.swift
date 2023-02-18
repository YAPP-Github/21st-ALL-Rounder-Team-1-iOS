//
//  HomeViewModel.swift
//  RefillStation
//
//  Created by kong on 2022/11/30.
//

import UIKit
import CoreLocation

final class HomeViewModel {
    private let fetchStoresUseCase: FetchStoresUseCaseInterface
    private var storesLoadTask: Cancellable?

    private let locationManager = CLLocationManager()
    private var latitude: Double = 0
    private var longitude: Double = 0

    var stores = [Store]()
    var currentAddress = ""
    var currentAdministrativeArea = ""
    var shouldShowRequestRegion: Bool {
        return currentAdministrativeArea == "서울특별시" || UserDefaults.standard.bool(forKey: "didRequestRegion")
    }
    var setUpContents: (() -> Void)?
    var presentLocationPopUp: (() -> Void)?
    var dismissLocationPopUp: (() -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?

    init(fetchStoresUseCase: FetchStoresUseCaseInterface = FetchStoresUseCase()) {
        self.fetchStoresUseCase = fetchStoresUseCase
    }

    private func fetchStores() {
        setUpCurrentLocation()
        storesLoadTask = Task {
            do {
                stores = try await fetchStoresUseCase.execute(
                    requestValue: .init(latitude: latitude, longitude: longitude)
                )
                let address = await convertAddress(latitude: latitude, longitude: longitude)
                currentAddress = address.0
                currentAdministrativeArea = address.1
                setUpContents?()
            } catch NetworkError.exception(errorMessage: let message) {
                showErrorAlert?(message, nil)
            } catch {
                print(error)
            }
        }
    }
}

extension HomeViewModel {
    func viewWillAppear() {
        if locationManager.authorizationStatus == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            checkLocationPermission()
        }
    }
    func checkLocationPermission() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            didAuthorized()
        default:
            presentLocationPopUp?()
        }
    }
    func didAuthorized() {
        dismissLocationPopUp?()
        fetchStores()
    }
    func viewWillDisappear() {
        storesLoadTask?.cancel()
    }
}

extension HomeViewModel {
    private func setUpCurrentLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        guard let space = locationManager.location?.coordinate else { return }
        latitude = space.latitude
        longitude = space.longitude
    }

    private func convertAddress(latitude: Double, longitude: Double) async -> (String, String) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let locale = Locale(identifier: "Ko-kr")
        return await withCheckedContinuation { continuation in
            CLGeocoder().reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, _ in
                guard let placemarks = placemarks, let address = placemarks.last else { return }
                let currentAddress = (address.administrativeArea ?? "") + " " + (address.name ?? "")
                let currentAdministrativeArea = address.administrativeArea ?? ""
                let result = (currentAddress, currentAdministrativeArea)
                continuation.resume(returning: result)
            }
        }
    }
}
