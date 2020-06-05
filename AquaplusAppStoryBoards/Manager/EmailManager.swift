//
//  EmailManager.swift
//  AquaplusAppStoryBoards
//
//  Created by David Mendes Da Silva on 03/06/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Foundation
import SendGrid

struct EmailManager {
    
    func send(form: FeedbackForm, completion: @escaping (Result<Void, Error>) -> Void) {
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//            completion(.success(()))
//        }
        guard let apikey = ProcessInfo.processInfo.environment["SG_API_KEY"] else {
            fatalError("Api key is missing, Please check.")
        }
        
        let userName = "Thomas (id: 123456)"
        let developerEmail = "david@aquaplusuk.com"
        let senderAddress = "orders@aquaplusuk.com"
        
        let session = Session()
        session.authentication = Authentication.apiKey(apikey)
        
        let personalization = Personalization(recipients: developerEmail)
        let subject = "Feedback Received from ios"
        
        let htmlContext = """
        <h4>User</h4>
        <p>\(userName)</p>
        <h4>Category</h4>
        <p>\(form.category.rawValue)</p>
        <h4>Comments</h4>
        <p>\(form.comments)</p>

        """
        let htmlText = Content(contentType: .htmlText, value: htmlContext)
        
        let from = Address(email: senderAddress)
        
        let email = Email(personalizations: [personalization], from: from, content: [htmlText], subject: subject)
        
        do {
            try session.send(request: email, completionHandler: { (result) in
                switch result {
                case .success(let response):
                    print("response: \(response.statusCode)")
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
            
        } catch(let error) {
            completion(.failure(error))
        }
    }
}
