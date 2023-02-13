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
    var isServiceRegion: Bool {
        return currentAdministrativeArea == "서울특별시"
    }
    var setUpContents: (() -> Void)?
    var presentToLocationPopUp: (() -> Void)?
    var dismissLocationPopUp: (() -> Void)?
    var requestWhenInUseAuthorization: (() -> Void)?
    var showErrorAlert: ((String?, String?) -> Void)?

    init(fetchStoresUseCase: FetchStoresUseCaseInterface = FetchStoresUseCase()) {
        self.fetchStoresUseCase = fetchStoresUseCase
    }

    private func fetchStores() {
        setUpCurrentLocation()
        storesLoadTask = Task {
            do {
                let stores = try await fetchStoresUseCase.execute(
                    requestValue: .init(latitude: latitude, longitude: longitude)
                )
                self.stores = stores
                self.convertAddress(latitude: self.latitude, longitude: self.longitude) {
                    self.currentAddress = $0
                    self.currentAdministrativeArea = $1
                    self.setUpContents?()
                }
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
            presentToLocationPopUp?()
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
    private func convertAddress(latitude: Double,
                                longitude: Double,
                                completion: @escaping (String, String) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let locale = Locale(identifier: "Ko-kr")
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: locale) { placemarks, _ in
            guard let placemarks = placemarks, let address = placemarks.last else { return }
            completion((address.administrativeArea ?? "") + " " + (address.name ?? ""),
                       address.administrativeArea ?? "")
        }
    }
}
