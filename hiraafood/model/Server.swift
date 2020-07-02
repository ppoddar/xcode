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
    case BadPayload
    case ConnectionError

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
             completion:@escaping (Result<Data,Error>) -> Void) {
        let url = Server.newURL(url)
        let task = session.dataTask(with: url){data,response, error in
            if (error != nil) {
                NSLog("error = \(String(describing: error))")
                completion(.failure(error!))
                return
            }
            guard let jsonData = data else {
                completion(.failure(ApplicationError.ResponseNotJSON(body:data)))
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
        NSLog("fetching image \(path) over network")
        
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
              payload:Data?,
              completion:@escaping (Result<Data,Error>) -> Void) {
        let requestURL = Server.newURL(url)
        var request:URLRequest = URLRequest(url:requestURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        NSLog("----------- Server POST request \(requestURL)")
        NSLog(String(describing: payload))
        do {
            //request.httpBody = encodeDictionary(payload).data(using:.utf8)
            request.httpBody = payload
            NSLog("sending POST \(requestURL) with \(String(describing: request.httpBody))")
            let task = session.dataTask(with: request,
               completionHandler:{data, response, error in
               guard let jsonData = data else {
                    completion(.failure(ApplicationError.ResponseNotJSON(body:data)))
                    return
                }
                completion(.success(jsonData))
            })
            task.resume()
        } 
    }
    
    static let OPEN:String = "{"
    static let CLOSE:String = "}"
    static let QUOTE:String = "\""
    static let COLON:String = ":"

    func encodeDictionary<T:Encodable>(_ dict:Dictionary<String,T>) -> String {
        NSLog("converting dictionary to JSON String")
        let N = dict.count
        var keys:[String] = [String](repeating: "", count: N)
        var values:[String] = [String](repeating: "", count: N)
        var i:Int = 0
        for (key,value) in dict {
            keys[i] = key
            values[i] = toJSONString(value)
            NSLog("key \(key)")
            NSLog(values[i])
            i += 1
        }
        var json:String = Server.OPEN
        for i in 0..<N {
            json += Server.QUOTE + keys[i] + Server.QUOTE + Server.COLON + values[i]
            if (i < (N-1)) {json += ","}
        }
        json += Server.CLOSE
        NSLog("final JSON")
        NSLog(json)
        return json
    }
    
    func toJSONString<T:Encodable>(_ obj:T) -> String {
        NSLog("converting object \(obj) to JSON String")
        let encoder = JSONEncoder()
        //encoder.outputFormatting = .prettyPrinted
        do {
            let data = try  encoder.encode(obj)
            let json = String(data: data, encoding: .utf8)!
            return json
        } catch {
            NSLog(String(describing: error))
        }
        return ""
    }
}

