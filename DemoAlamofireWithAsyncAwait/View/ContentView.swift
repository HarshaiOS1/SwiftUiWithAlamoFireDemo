//
//  ContentView.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewViewModel()
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
            }
            Button("Fetch") {
                Task {
                    await viewModel.fetchAppliance(size:4)
                }
            }
            .frame(width: 80, height: 40)
            .border(.blue, width: 1)
            .cornerRadius(3.0)
            .padding()
            List {
                ForEach(viewModel.appliances,id: \.id) { item in
                    Text("\(item.brand) - \(item.equipment)")
                }
            }
            .listStyle(.inset)
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchAppliance(size: 4)
            }
        }
    }
}

#Preview {
    ContentView()
}
