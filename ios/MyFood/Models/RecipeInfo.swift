import Foundation

struct RecipeStepInfo: Codable {
    let pictureUrl: URL?
    let timeInSec: Int?
    let pushText: String?
    let description: String
    let voiceDescription: String
    let tips: [String]
}

struct RecipeInfo: Codable {
    let title: String
    let previewUrl: URL?
    let description: String
    let complexity: String
    let duration: String
    let ingredients: [String]
    let devices: [String]
    let steps: [RecipeStepInfo]
}
