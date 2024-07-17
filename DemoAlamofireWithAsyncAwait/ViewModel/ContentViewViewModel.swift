//
//  ContentViewViewModel.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import Foundation

class ContentViewViewModel: ObservableObject {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var appliances: [ApplianceModel] = []
    
    func fetchGoogleResult(searchText: String) async {
        await MainActor.run {
            self.errorMessage = ""
        }
        let urlPath = String(format: Constants.baseUrl + Services.getAppliance, 4)
        if let res = await AppliancesAPI.getAppliances(url: urlPath) {
            await MainActor.run {
                self.appliances = res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "fetching data failed"
            }
        }
    }
}

struct AppliancesAPI {
    static func getAppliances(url: String) async -> [ApplianceModel]? {
        do {
            let data = try await NetworkManager.shared.get(url: url, parameters: nil)
            let result = try JSONDecoder().decode([ApplianceModel].self, from: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}
