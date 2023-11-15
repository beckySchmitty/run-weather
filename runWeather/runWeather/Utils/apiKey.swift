//
//  apiKey.swif
//  runWeather
//
//  Created by Becky Schmitthenner on 11/14/23.
//

import Foundation

var apiKey: String {
  guard let filePath = Bundle.main.path(forResource: "ACCUWEATHER-info", ofType: "plist") else {
    fatalError("Couldn't find file 'ACCUWEATHER-info.plist'.")
  }
  let plist = NSDictionary(contentsOfFile: filePath)
  guard let value = plist?.object(forKey: "ACCUWEATHER_API_KEY") as? String else {
    fatalError("Couldn't find key 'ACCUWEATHER_API_KEY' in 'ACCUWEATHER-info.plist'.")
  }
  return value
}
