//
//  ContentViewViewModel.swift
//  DemoAlamofireWithAsyncAwait
//
//  Created by Krishnappa, Harsha on 28/03/2024.
//

import Foundation

class ContentViewViewModel: ObservableObject {
    private let applianceService: ApplianceServices
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var appliances: [ApplianceModel] = []
    
    init(applianceService: ApplianceServices) {
        self.applianceService = applianceService
    }
    
    func fetchAppliance(size: Int) async {
        await MainActor.run {
            self.errorMessage = ""
        }
        let urlPath = String(format: Constants.baseUrl + Services.getAppliance, size)
        if let res = await self.applianceService.fetchAppliance(url: urlPath) {
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

protocol ApplianceServices {
    func fetchAppliance(url: String) async -> [ApplianceModel]?
}

struct AppliancesAPI: ApplianceServices {
    func fetchAppliance(url: String) async -> [ApplianceModel]? {
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
