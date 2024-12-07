//
//  TaskListInteractor.swift
//  TodoListViper
//
//  Created by Omer Cagri Sayir on 30.11.2024.
//

import Foundation

protocol TaskListInteractorInputProtocol: AnyObject {
    func fetchTaskList(completion: @escaping ([TodoTask]?, String?) -> Void)
    func fetchTask(withId id: Int, completion: @escaping (TodoTask?, String?) -> Void)
    func addTask(_ task: TodoTask, completion: @escaping (Bool, String?) -> Void)
}

class TaskListInteractor: TaskListInteractorInputProtocol {
    private var taskList = [
        TodoTask(id: "id1", title: "Task 1", description: "Description 1", isCompleted: false),
        TodoTask(id: "id2", title: "Task 2", description: "Description 2", isCompleted: true, completionDate: .now),
        TodoTask(id: "id3", title: "Task 3", description: "Description 3", isCompleted: false)
    ]
    
    func fetchTaskList(completion: @escaping ([TodoTask]?, String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self else { return }
            completion(self.taskList, nil)
        }
    }
    
    
    func addTask(_ task: TodoTask, completion: @escaping (Bool, String?) -> Void) {
        //Simulate 2 seconds load
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {[weak self] in
            //suppose there is api operation here, then
            self?.taskList.append(task)
            completion(true, nil)
            //if API fail
            //completion(false, "Error message")
        }
        
    }
    
    func fetchTask(withId id: Int, completion: @escaping (TodoTask?, String?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self else { return }
            completion(self.taskList[id], nil)
        }
    }
}
