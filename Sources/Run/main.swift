//
//  File.swift
//  
//
//  Created by Daniel Lopes da Silva on 29/08/24.
//

import Foundation
import App
import Vapor

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }

try await configure(app)
try app.run()
