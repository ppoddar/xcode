import Foundation
import UIKit

enum ApplicationError: Error {
    
    case ResponseError(body:Any?)
    case ResponseEmpty
    case StatusError(status:Int,body:Any?)
    case invalidURL
    case NoData
    case ResponseNotJSON(body:Any?)
    case ArrayIndexOfBounds
    case unexpeceted

}

// This is a client-side mechanics to communicate
// with a remote server
// Each method accepts a URL, a success callback
// and a failure callback
// The method calls remote server with given URL,
// upon receiving the response, calls either
// of the callbacks depending on the response.
//
// It is a sengleton.
 
class Server {
    //let baseURL:String = "https://hiraafood.com"
    //let baseURL:String = "http://localhost:9000"
    //let dummy:Bool = true
    let session:URLSession = URLSession.shared
    static var singleton:Server = Server()
    
    /*
     *
     */
    static func newURL(_ path:String) -> URL {
        let baseURL = Constants.SERVER_URL
        let url = URL(string:baseURL + path)
        return url!
    }
    //funcName({ (ParameterTypes) -> ReturnType in statements })

    /*
     * @param url
     * @param completion
     *
     */
    func get(url:String,
             completion:@escaping (Result<Data,ApplicationError>) -> Void) {
        let url = Server.newURL(url)
        let task = session.dataTask(with: url){data,response, error in
            guard let jsonData = data else {
                completion(.failure(.ResponseNotJSON(body:data)))
                return
            }
            completion(.success(jsonData))
        }
        task.resume()
    }
    
    
//    func getMenu(completion:@escaping(Result<[Item],ApplicationError>)->Void) {
//        get<[Item]>(url:"/item/catalog", completion:completion)
//    }
    
    func fetchImage(name:String) -> Result<Data, ApplicationError> {
        let path:URL = Server.newURL(name)
        print("fetching image \(path) over network")
        
        var result: Result<Data, ApplicationError>!
        let task = URLSession.shared.dataTask(with: path){(data, _, _) in
            if let data = data {
                result = .success(data)
            } else {
                result = .failure(.unexpeceted)
            }
        }
        task.resume()
        return result
    }
    
    /*
     *
     */
    func post(url:String,
              payload:Any,
              completion:@escaping (Result<Data,ApplicationError>) -> Void) {
        let requestURL = Server.newURL(url)
        var request:URLRequest = URLRequest(url:requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: payload, options: [])
        } catch {
            print("can not seralize given payload \(payload)") 
            print(error)
        }
            
        print("sending POST \(requestURL) with \(String(describing: request.httpBody)) ")
        let task = session.dataTask(with: request,
            completionHandler:{data, response, error in
               guard let jsonData = data else {
                    completion(.failure(.ResponseNotJSON(body:data)))
                    return
                }
                completion(.success(jsonData))
        })
        task.resume()
    }
    
    func errorMessage(_ data:Data) -> String {
//        let decoder:JSONDecoder  = JSONDecoder()
//        let generic = Dictionary<String,String>()
//        do {
//            let dict = try decoder.decode(type(of:generic), from:data)
//            if (dict.contains("error")) {
//                return dict["error"]
//            } else {
//                return  "no error message available"
//            }
//        } catch {
//            return "no error message available"
//        }
        return String(data:data, encoding: String.Encoding.utf8) ?? "no error message available"
    }
    
    
    
}

