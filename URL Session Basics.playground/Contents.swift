import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - URLSession Basics Example

func fetchData() {
    
    print("\n----- URLSESSION BASICS -----")
    
    // MARK: URL
    
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {
        print("Invalid URL")
        return
    }
    
    print("URL created")
    
    // MARK: URLSession
    
    let session = URLSession.shared
    
    print("Session created")
    
    // MARK: Data Task
    
    let task = session.dataTask(with: url) { data, response, error in
        // data     → the actual response body (what the server sent back)
        // response → metadata like status code, headers
        // error    → any network level error that occurred
        
        print("Response received")
        
        // MARK: Error Check
        
        if let error = error {
            print("Error:", error.localizedDescription)
            return
        }
        
        // MARK: Response Check
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            return
        }
        
        print("Status Code:", httpResponse.statusCode)
        
        // MARK: Data Check
        
        guard let data = data else {
            print("No data received")
            return
        }
        
        // MARK: Raw Output
        
        let responseString = String(data: data, encoding: .utf8)
        print("Raw JSON:", responseString ?? "")
    }
    
    print("Task created")
    
    // MARK: Start Task
    
    task.resume()
    
    print("Task started")
}

// Run
fetchData()
