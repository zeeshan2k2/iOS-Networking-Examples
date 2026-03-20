import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

struct Endpoint
{
    static let registerUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser"
    static let getUser = "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser"
}

struct User
{
    // Function to register a new user
    func registerUser()
    {
        // Setting the URLRequest with the register user endpoint
        guard let url = URL(string: Endpoint.registerUser) else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        // Setting the HTTP method to POST
        urlRequest.httpMethod = "POST"
        
        // Data dictionary containing user details
        let dataDictionary = ["name":"zeeshan", "email":"zeeshan15@gmail.com","password":"1234"]
        
        do {
            // Convert dictionary to JSON data
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: [])
            
            // Set HTTP body
            urlRequest.httpBody = requestBody
            
            // Add header
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        } catch {
            print("JSON Error:", error.localizedDescription)
            return
        }

        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            // Handle network error
            if let error = error {
                print("Network Error:", error.localizedDescription)
                return
            }
            
            // Validate response
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Status Code:", httpResponse.statusCode)
            
            // Check success
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Server Error:", httpResponse.statusCode)
                return
            }
            
            // Handle data
            guard let data = data else {
                print("No data received")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            
            print()
            print("This is the post data")
            print(responseString ?? "")
            
        }.resume()
    }


    // Function to get user data from the server
    func GetUserFromServer()
    {
        // Setting the URLRequest with the get user endpoint
        var urlRequest = URLRequest(url: URL(string: Endpoint.getUser)!)
        // Setting the HTTP method to GET as we are retrieving data from the server
        urlRequest.httpMethod = "get"

        // Creating a data task to perform the network request
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            if(data != nil && data?.count != 0)
            {
                // Parsing the JSON response received from the server
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


