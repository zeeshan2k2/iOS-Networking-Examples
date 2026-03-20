import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// Function to demonstrate HTTP Response Validation
func validateResponse() {
    
    // Define the URL
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {
        print("Invalid URL")
        return
    }
    
    // Create URLRequest
    var request = URLRequest(url: url)
    
    // Set HTTP method to GET
    request.httpMethod = "GET"
    
    // Create a data task
    URLSession.shared.dataTask(with: request) { (data, response, error) in
        
        print("Response received")
        
        // Check for network error
        if let error = error {
            print("Network Error:", error.localizedDescription)
            return
        }
        
        // Cast response to HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            return
        }
        
        // Print status code
        print("Status Code:", httpResponse.statusCode)
        
        // Validate status code range (200–299 = success)
        if (200...299).contains(httpResponse.statusCode) {
            
            print("Request Successful")
            
            // Optional: check if data exists
            if let data = data {
                let responseString = String(data: data, encoding: .utf8)
                print("Response Data:", responseString ?? "")
            }
            
        } else {
            
            print("Request Failed with status code:", httpResponse.statusCode)
        }
        
    }.resume()
}

// Execute function
validateResponse()
