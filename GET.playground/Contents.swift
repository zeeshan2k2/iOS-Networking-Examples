import UIKit
import PlaygroundSupport


PlaygroundPage.current.needsIndefiniteExecution = true


// Function to fetch data from a given URL using GET request
func getData() {
    
    // Create a URLSession shared instance
    let session = URLSession.shared
    
    // Define the URL to fetch data from
    guard let serviceUrl = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {
        print("Invalid URL")
        return
    }
    
    // Create a URLRequest (explicit GET request)
    var request = URLRequest(url: serviceUrl)
    
    // Set HTTP method to GET
    request.httpMethod = "GET"
    
    // Create a data task to fetch data from the URL
    let task = session.dataTask(with: request) { (serviceData, serviceResponse, error) in
        
        print("Response received")
        
        // Check if there was any network error
        if let error = error {
            print("Network Error:", error.localizedDescription)
            return
        }
        
        // Safely cast the response to HTTPURLResponse
        guard let httpResponse = serviceResponse as? HTTPURLResponse else {
            print("Invalid response")
            return
        }
        
        // Print status code
        print("Status Code:", httpResponse.statusCode)
        
        // Check if the status code indicates success (200 OK)
        if httpResponse.statusCode == 200 {
            
            // Ensure data is not nil
            guard let data = serviceData else {
                print("No data received")
                return
            }
            
            // Attempt to parse the JSON data
            do {
                // Convert the data into a JSON object
                let jsonData = try JSONSerialization.jsonObject(with: data, options: [])
                
                // Cast the JSON object to a Dictionary
                if let result = jsonData as? [String: Any] {
                    
                    // Print the value associated with the "id" key
                    print("id =", result["id"] ?? "")
                    print("title =", result["title"] ?? "")
                    print("userId =", result["userId"] ?? "")
                    print("completed =", result["completed"] ?? "")
                }
                
            } catch {
                // Handle JSON parsing error
                print("Error parsing JSON:", error.localizedDescription)
            }
            
        } else {
            // Handle HTTP response status code error
            print("HTTP Error: Status code \(httpResponse.statusCode)")
        }
    }
    
    // Start the data task
    task.resume()
}

// Call the function to execute the network request
getData()
