import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

struct Endpoint
{
    static let registerUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}

// MARK: - Encodable Model

struct RegisterUserRequest: Encodable {
    let name: String
    let email: String
    let password: String
}

struct User
{
    // Function to register a new user
    func registerUser()
    {
        // Setting the URLRequest with the register user endpoint
        var urlRequest = URLRequest(url: URL(string: Endpoint.registerUser)!)
        
        // Setting the HTTP method to POST as we are sending data to the server
        urlRequest.httpMethod = "POST"
        
        // Creating Encodable model
        let requestModel = RegisterUserRequest(
            name: "zeeshan",
            email: "zeeshan15@gmail.com",
            password: "1234"
        )
        
        // Encoding model into JSON
        do {
            let requestBody = try JSONEncoder().encode(requestModel)
            
            // Setting the HTTP body
            urlRequest.httpBody = requestBody
            
            // Adding header
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            
        } catch let error {
            debugPrint("Encoding error:", error.localizedDescription)
        }

        // Creating a data task to perform the network request
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                let response = String(data: data!, encoding: .utf8)
                print()
                print("This is the post data")
                debugPrint(response!)
            }
        }.resume()
    }


    // Function to get user data from the server
    func GetUserFromServer()
    {
        var urlRequest = URLRequest(url: URL(string: Endpoint.getUser)!)
        urlRequest.httpMethod = "get"

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                let response = String(data: data!, encoding: .utf8)
                print()
                print("This is the get data")
                debugPrint(response!)
            }
        }.resume()
    }
}

let objUser = User()
objUser.registerUser()
objUser.GetUserFromServer()
