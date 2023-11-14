//
//  ProfileView.swift
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var user: User
    var locationStore = LocationStore()
    
    var body: some View {
        ZipCodeInputView(user: user)
            .environmentObject(locationStore)
    }
}
