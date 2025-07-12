//
//  ContentView.swift
//  SubashzZuperTask
//
//  Created by Apple  on 12/07/25.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

struct ServiceListView: View {
    @StateObject private var viewModel = ServiceListViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.sortedDateKeys, id: \.self) { dateKey in
                    Section(header: Text(dateKey).font(.headline)) {
                        ForEach(viewModel.groupedServices[dateKey] ?? []) { service in
                            NavigationLink(value: service) {
                                ServiceRowView(service: service)
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Services")
            .navigationDestination(for: Service.self) { service in
                ServiceDetailView(service: service)
            }
            .searchable(text: $viewModel.searchText)
            .refreshable {
                await viewModel.fetchServices()
            }
            .onAppear {
                Task {
                    await viewModel.fetchServices()
                }
            }
        }
    }
}




#Preview {
    ServiceListView()
}
