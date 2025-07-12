//
//  ServiceRowView.swift
//  SubashzZuperTask
//
//  Created by Apple  on 12/07/25.
//

import SwiftUI
struct ServiceRowView: View {
    let service: Service

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(service.title)
                    .font(.headline)
                Spacer()
                Circle()
                    .fill(service.priority.color)
                    .frame(width: 8, height: 8)
            }
            HStack {
                ZStack {
                    Image("profile")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                }
                
                Text(service.customerName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            HStack {
                ZStack {
                    Image("Files")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                }
                Text(service.description)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            HStack {
                
                HStack {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(service.priority.color.opacity(0.1))
                        .frame(width: 15,height: 15)
                    Text(service.status.rawValue)
                        .font(.caption)
                }
                .padding(10)
                .background(Capsule().fill(service.priority.color.opacity(0.2)))
                Spacer()
                Text(service.formattedDate)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

