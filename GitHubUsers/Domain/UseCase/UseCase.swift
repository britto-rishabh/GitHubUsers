//
//  UseCase.swift
//  GitHubUsers
//
//  Created by Britto Thomas on 01/09/22.
//

import Foundation

protocol UserCase {
    associatedtype T
    associatedtype Parameter
    
    func call(parameter:Parameter, completion:@escaping (T?)->Void)
}
