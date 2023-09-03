//
//  MapAnnotation.swift
//  FamTrack
//
//  Created by Vian du Plessis on 2023/08/31.
//


import SwiftUI
import MapKit

struct UserMapAnnotation: Identifiable {
    var id: String
    var coordinate: CLLocationCoordinate2D
    var user: User
}
