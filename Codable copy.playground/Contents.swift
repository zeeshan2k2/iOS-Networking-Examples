import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Endpoint
{
    static let registerUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}

// MARK: - Models (Codable)

struct UserResponse: Codable {
    let name: String
    let email: String
    let id: String
    let joining: String
}

struct RegisterUserRequest: Codable {
    let name: String
    let email: String
    let password: String
}

struct RegisterResponse: Codable {
    let errorMessage: String
    let data: UserResponse
}

// MARK: - GET (Decoding)

func getUsers() {
    
    print("\n----- GET + DECODABLE -----")
    
    guard let url = URL(string: Endpoint.getUser) else {
        print("Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        
        if let error = error {
            print("Error:", error.localizedDescription)
            return
        }
        
        guard let data = data else {
            print("No data")
            return
        }
        
        do {
            // Decode JSON into Swift models
            let users = try JSONDecoder().decode([UserResponse].self, from: data)
            
            for user in users {
                print("User:", user.name)
            }
            
        } catch {
            print("Decoding Error:", error.localizedDescription)
        }
        
    }.resume()
}

// MARK: - POST (Encoding)

func registerUser() {
    
    print("\n----- POST + ENCODABLE -----")
    
    guard let url = URL(string: Endpoint.registerUser) else {
        print("Invalid URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    // Create model
    let user = RegisterUserRequest(
        name: "Zeeshan",
        email: "zeeshan15@gmail.com",
        password: "1234"
    )
    
    do {
        // Encode model into JSON
        let data = try JSONEncoder().encode(user)
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
    } catch {
        print("Encoding Error:", error.localizedDescription)
        return
    }
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        
        if let error = error {
            print("Error:", error.localizedDescription)
            return
        }
        
        guard let data = data else {
            print("No data")
            return
        }
        
        do {
            // Decode response
            let response = try JSONDecoder().decode(RegisterResponse.self, from: data)
            
            print("Created User:", response.data.name)
            
        } catch {
            print("Decoding Error:", error.localizedDescription)
        }
        
    }.resume()
}

// Run
getUsers()
registerUser()
