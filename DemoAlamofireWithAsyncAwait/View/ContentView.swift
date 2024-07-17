//
//  ContentView.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel: ContentViewViewModel
    
    init(viewModel: ContentViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 10) {
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
            }
            List {
                ForEach(viewModel.appliances,id: \.id) { item in
                    HStack {
                        Text("\(item.brand) - \(item.equipment)")
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
            }
            .listStyle(.inset)
            Button("Fetch New deals") {
                Task {
                    await viewModel.fetchAppliance(size:8)
                }
            }
            .padding(EdgeInsets(top: 10.0, leading: 10.0, bottom: 10.0, trailing: 10.0))
            .frame(maxWidth: .infinity)
            .border(.blue, width: 2)
            .cornerRadius(4.0)
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchAppliance(size: 8)
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ContentViewViewModel(applianceService: AppliancesAPI()))
}
