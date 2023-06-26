//
//  Task.swift
//  fetchMealSearch
//
//  Created by user242726 on 6/24/23.
//

import Foundation


/// extending task to have cancellable functionality
extension Task where Success == Void, Failure == Never {
    func store(in cancellables: inout Set<TaskCancellable>) {
        cancellables.insert(TaskCancellable(task: self))
    }
}

/// Added this clase to access the store(in:&cancellable)
///
/// This Class provides an easy way to cnacel the tasks which are started by the developer
final class TaskCancellable: Hashable {
    static func == (lhs: TaskCancellable, rhs: TaskCancellable) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private var id = UUID().uuidString
    private var task: Task<Void, Never>
    
    init(task: Task<Void, Never>) {
        self.task = task
    }
    
    deinit {
        task.cancel()
    }
}
