//
//  AllDetailsHelper.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import Foundation

class AllDetailsHelper: NSObject{
    // MARK: - Main project master downloading Api call
    func getAllData(Url: String, completion: @escaping (_ success : Welcome) -> Void, failure: @escaping (_ errorMsg : String) -> Void) {
        let apiUrl = Url
        let fileURL = URL(string: apiUrl)!
        let fileRequest:NSMutableURLRequest = NSMutableURLRequest(url: fileURL)
        fileRequest.httpMethod = "GET"
        //fileRequest.timeoutInterval = 15
        //DispatchQueue.main.async {
            let session = URLSession(configuration: .default)
            let fileTask: URLSessionDataTask = session.dataTask(with: fileRequest as URLRequest, completionHandler: { data, response, error in
                if error == nil {
                    if let value = data {
                        do {
                            print(value)
                            let decoder = JSONDecoder()
                            let model = try decoder.decode(Welcome.self, from: value)
                            completion(model)
                            print(model.innings[0].batsmen.count)
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                        }
                    }
                } else {
                    
                }
            })
            fileTask.resume()
        //}
    }
}



