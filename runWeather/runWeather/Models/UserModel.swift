//
//  UserModel.swif
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//
import Foundation

@MainActor
class User: ObservableObject {
    @Published var zipCode: String
    @Published var locationKey: String
    @Published var localizedName: String

    init(zipCode: String = "", locationKey: String = "", localizedName: String = "") {
        self.zipCode = zipCode
        self.locationKey = locationKey
        self.localizedName = localizedName
    }
}
