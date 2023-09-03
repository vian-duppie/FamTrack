//
//  HomeViewModel.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/09/02.
//

import SwiftUI
import MapKit

class HomeViewModel: ObservableObject {
    @Published var selectedUserLocation: CLLocationCoordinate2D? = nil
}

