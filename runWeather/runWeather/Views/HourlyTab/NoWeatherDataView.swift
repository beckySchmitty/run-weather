//
//  NoWeatherDataView.swif
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import SwiftUI

struct NoWeatherDataView: View {
    var body: some View {
        VStack {
            Image(systemName: "cloud.sun.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Update your profile to see the weather forecast")
                .font(.title)
        }    }
}

#Preview {
    NoWeatherDataView()
}
