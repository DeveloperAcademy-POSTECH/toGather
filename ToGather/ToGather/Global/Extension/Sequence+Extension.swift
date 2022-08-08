//
//  Sequence+Extension.swift
//  ToGather
//
//  Created by yudonlee on 2022/08/07.
//

import Foundation

extension Sequence {
    
    func asyncMap<T>(
        _ transform: (Element) async throws -> T
    ) async rethrows -> [T] {
        var values = [T]()

        for element in self {
            try await values.append(transform(element))
        }

        return values
    }
    
    func asyncForEach(
        _ operation: (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try await operation(element)
        }
    }
    
    func concurrentMap<T>(
        _ transform: @escaping (Element) async throws -> T
    ) async throws -> [T] {
        let tasks = map { element in
            Task {
    try await transform(element)
}
        }

        return try await tasks.asyncMap { task in
            try await task.value
        }
    }
    
}
