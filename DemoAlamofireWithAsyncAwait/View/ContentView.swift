//
//  ContentView.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewViewModel()
    @State private var searchText = ""
    
    var body: some View {
        VStack(spacing: 10) {
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                
            }
            NavigationStack {
                List {
                    ForEach(viewModel.appliances,id: \.id) { item in
                        Text("\(item.brand) - \(item.equipment)")
                    }
                }
                .listStyle(.inset)
            }
//            FIX here 
            
//            .searchable(text: $searchText) {
//                print($searchText)
//                if $searchText.count > 3 {
//                    await viewModel.fetchGoogleResult(searchText: searchText)
//                }
//                
//            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
