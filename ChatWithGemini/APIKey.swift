import Foundation

enum APIKey {
    static var `default`: String {
        // Check if running in a preview environment
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return "PREVIEW_API_KEY" // Use a dummy key for preview
        }
        #endif

        // Normal logic to load the API key from the plist
        guard let filePath = Bundle.main.path(forResource: "GenerativeAi-info", ofType: "plist") else {
            fatalError("Couldn't find file 'GenerativeAi-info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
        }
        return value
    }
}
