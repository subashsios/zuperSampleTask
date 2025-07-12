//
//  ServiceDetailView.swift
//  SubashzZuperTask
//
//  Created by Apple  on 12/07/25.
//

import SwiftUI
import MapKit


struct ServiceDetailView: View {
    let service: Service
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    @State private var pinCoordinate: CLLocationCoordinate2D? = nil

    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading, spacing: 16) {
                Map(coordinateRegion: $region, annotationItems: pinCoordinate.map { [MapPin(coordinate: $0)] } ?? []) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 44, height: 44)
//                                .overlay(
//                                    Circle().stroke(Color.gray, lineWidth: 1)
//                                )

                            Image("location")
                                .renderingMode(.template)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                        }
                    }
                }
                .frame(height: 200)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                )
                .cornerRadius(10)
                .padding()
            

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(service.title)
                            .font(.title2.bold())
                        Spacer()
                        
                        HStack {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(service.priority.color.opacity(0.1))
                                .frame(width: 15,height: 15)
                            Text(service.status.rawValue)
                                .font(.caption)
                        }
                        .padding(10)
                        .background(Capsule().fill(service.priority.color.opacity(0.2)))
                    }
                    CustomerRowView(
                        imageName: "profile", // Add "profileImage" to Assets
                        title: "Customer",
                        customerName: service.customerName
                    )
                    CustomerRowView(imageName: "Files", title: "Description", customerName: service.description)
                    CustomerRowView(imageName: "shedule", title: "Scheduled Time", customerName: service.formattedDate)
                    CustomerRowView(imageName: "location", title: "Location", customerName: service.location)
                    
                    CustomerRowView(imageName: "message", title: "Service Notes", customerName: service.serviceNotes)

                   
                }
                .padding()
            }
        }
        .navigationTitle("Service Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            Task {
                if let coord = await coordinate(for: service.location) {
                    region = MKCoordinateRegion(
                        center: coord,
                        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    )
                    pinCoordinate = coord
                }
            }
        }
    }

    func coordinate(for address: String) async -> CLLocationCoordinate2D? {
        await withCheckedContinuation { continuation in
            CLGeocoder().geocodeAddressString(address) { placemarks, error in
                if let loc = placemarks?.first?.location {
                    continuation.resume(returning: loc.coordinate)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}


//
//#Preview {
//    ServiceDetailView()
//}
