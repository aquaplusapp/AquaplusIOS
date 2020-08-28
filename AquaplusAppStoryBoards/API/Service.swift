//
//  Service.swift
//  AquaplusApp
//
//  Created by David Mendes Da Silva on 16/04/2020.
//  Copyright © 2020 David Mendes Da Silva. All rights reserved.
//

import Alamofire

class Service: NSObject {
    
    static let shared = Service()
    
    //let baseUrl = "http://localhost:1337"
     let baseUrl = "https://aquaapp.herokuapp.com"
    func searchForUsers(completion: @escaping (Result<[User], Error>) -> ()) {
        let url = "\(baseUrl)/search"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResponse) in
                if let err = dataResponse.error {
                    completion(.failure(err))
                    return
                }
                
                do {
                    let data = dataResponse.data ?? Data()
                    let users = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(users))
                    
                } catch {
                    completion(.failure(error))
                }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Data, Error>) -> ()) {
        print("Performing login")
        let params = ["emailAddress": email, "password": password]
        let url = "\(baseUrl)/api/v1/entrance/login"
        AF.request(url, method: .put, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                } else {
                    completion(.success(dataResp.data ?? Data()))
                }
        }
    }
    func fetchCoolers(completion: @escaping (Result<[Cooler], Error>) -> ()) {
        let url = "\(baseUrl)/cooler"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                
                guard let data = dataResp.data else { return }
                do {
                    let coolers = try JSONDecoder().decode([Cooler].self, from: data)
                    completion(.success(coolers))
                } catch {
                    completion(.failure(error))
                }
        }
    }
    func fetchOrders(completion: @escaping (Result<[Order], Error>) -> ()) {
        let url = "\(baseUrl)/notcompletedorder"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                
                guard let data = dataResp.data else { return }
                do {
                    let orders = try JSONDecoder().decode([Order].self, from: data)
                    completion(.success(orders))
                } catch {
                    completion(.failure(error))
                }
        }
    }
    func fetchCompletedOrders(completion: @escaping (Result<[Order], Error>) -> ()) {
        let url = "\(baseUrl)/completedorder"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                
                guard let data = dataResp.data else { return }
                do {
                    let orders = try JSONDecoder().decode([Order].self, from: data)
                    completion(.success(orders))
                } catch {
                    completion(.failure(error))
                }
        }
    }
    
    func fetchContacts(completion: @escaping (Result<[Customers], Error>) -> ()) {
        let url = "\(baseUrl)/customer"
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                
                guard let data = dataResp.data else { return }
                do {
                    let customers = try JSONDecoder().decode([Customers].self, from: data)
                    completion(.success(customers))
                } catch {
                    completion(.failure(error))
                }
        }
    }
    
    func signUp(fullName: String, emailAddress: String, password: String, completion: @escaping (Result<Data, Error>) -> ()) {
        let params = ["fullName": fullName, "emailAddress": emailAddress, "password": password]
        let url = "\(baseUrl)/api/v1/entrance/signup"
        AF.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseData { (dataResp) in
                if let err = dataResp.error {
                    completion(.failure(err))
                    return
                }
                completion(.success(dataResp.data ?? Data()))
        }
    }
    
    
}

