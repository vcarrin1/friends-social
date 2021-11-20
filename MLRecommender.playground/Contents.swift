import Cocoa
import CreateML

let trainingData = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/valentinacarrington/Documents/mobile-apps/place-ratings.json"))
let model = try MLRecommender(trainingData: trainingData, userColumn: "user_id", itemColumn: "place_id", ratingColumn: "rating")
let metrics = model.evaluation(on: trainingData, userColumn: "user_id", itemColumn: "place_id")
let recs = try model.recommendations(fromUsers: ["D"])
print(recs)
let metadata = MLModelMetadata(author: "Valentina Carrington", shortDescription: "A model trained to handle recommendations", version: "1.0")
try model.write(to: URL(fileURLWithPath: "/Users/valentinacarrington/Documents/mobile-apps/PlaceRecommender.mlmodel"), metadata: metadata)
