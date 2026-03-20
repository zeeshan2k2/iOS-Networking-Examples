import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Endpoint
{
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}

// Define model for decoding
struct UserResponse: Decodable {
    let name: String
    let email: String
    let id: String
    let joining: String
}

// Function to fetch data using async/await
func getUsers() async {
    
    // Define URL
    guard let url = URL(string: Endpoint.getUser) else {
        print("Invalid URL")
        return
    }
    
    // Create URLRequest
    var request = URLRequest(url: url)
    
    // Set HTTP method to GET
    request.httpMethod = "GET"
    
    do {
        // Perform network request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("Response received")
        
        // Validate response
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            return
        }
        
        print("Status Code:", httpResponse.statusCode)
        
        // Check success
        guard (200...299).contains(httpResponse.statusCode) else {
            print("HTTP Error:", httpResponse.statusCode)
            return
        }
        
        // Decode JSON into model
        let users = try JSONDecoder().decode([UserResponse].self, from: data)
        
        // Print result
        for user in users {
            print("User:", user.name)
        }
        
    } catch {
        // Handle all errors (network + decoding)
        print("Error:", error.localizedDescription)
    }
}

// Call async function
Task {
    await getUsers()
}
