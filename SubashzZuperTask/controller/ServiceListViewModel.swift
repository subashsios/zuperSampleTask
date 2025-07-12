//
//  Untitled.swift
//  SubashzZuperTask
//
//  Created by Apple  on 12/07/25.
//
import SwiftUI
import Combine

@MainActor
class ServiceListViewModel: ObservableObject {
    @Published var allServices: [Service] = []
    @Published var searchText: String = ""
    private var cancellables = Set<AnyCancellable>()

    var filteredServices: [Service] {
        if searchText.isEmpty { return allServices }
        return allServices.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.customerName.localizedCaseInsensitiveContains(searchText) ||
            $0.description.localizedCaseInsensitiveContains(searchText)
        }
    }

    var groupedServices: [String: [Service]] {
        Dictionary(grouping: filteredServices) { $0.formattedDay }
    }

    var sortedDateKeys: [String] {
        let order = ["Tomorrow", "Today", "Yesterday"]

        let special = groupedServices.keys.filter { order.contains($0) }.sorted {
            order.firstIndex(of: $0)! < order.firstIndex(of: $1)!
        }

        let others = groupedServices.keys.filter { !order.contains($0) }.sorted { lhs, rhs in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            let lhsDate = formatter.date(from: lhs) ?? .distantFuture
            let rhsDate = formatter.date(from: rhs) ?? .distantFuture
            return lhsDate < rhsDate
        }

        return special + others
    }

    func fetchServices() async {
        try? await Task.sleep(nanoseconds: 2_000_000_000) // Simulate delay
        allServices = SampleData.generateServices()
    }
}


import SwiftUI

struct CustomerRowView: View {
    let imageName: String        // Local image name from Assets
    let title: String            // Like "Customer"
    let customerName: String     // Dynamic name

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 8) {
                Image(imageName) // Local image
                    .resizable()
                    .frame(width: 24, height: 24)
                    .clipShape(Circle()) // Optional: make it circular
                Text(title)
                    .font(.subheadline.weight(.bold))
                    .foregroundColor(.primary)

                Spacer()
            }

            Text(customerName)
                .font(.subheadline.weight(.light))
                .padding(.leading, 32)
        }
        
    }
}
