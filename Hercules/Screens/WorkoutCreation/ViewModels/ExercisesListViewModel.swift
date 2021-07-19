//
//  ExercisesListViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 18/07/21.
//

import Foundation
import Combine
import CoreData

class ExercisesListViewModel: NSObject, ObservableObject {
    
    @Published
    var tags: [ExerciseTags] = []
    
    @Published
    var exercises: [Exercise] = []
    
    @Published
    private var fetchedExercises: [Exercise] = []
    
    @Published
    var shouldNavigateToNextSecion: Bool = true
    
    @Published
    var selectedTags: [NSManagedObjectID] = []
    
    var cancellables = Set<AnyCancellable>()
    
    private var storage = DataStorage.shared
    private var tagsController: NSFetchedResultsController<ExerciseTags>
    private var exercisesController: NSFetchedResultsController<Exercise>
    
    override init() {
        tagsController = NSFetchedResultsController(fetchRequest: ExerciseTags.allTags,
                                                    managedObjectContext: storage.persistentContainer.viewContext,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        exercisesController = NSFetchedResultsController(fetchRequest: Exercise.allExercises,
                                                         managedObjectContext: storage.persistentContainer.viewContext,
                                                         sectionNameKeyPath: nil,
                                                         cacheName: nil)
        super.init()
        
        tagsController.delegate = self
        exercisesController.delegate = self
    
        do {
            try tagsController.performFetch()
            tags = tagsController.fetchedObjects ?? []
            try exercisesController.performFetch()
            fetchedExercises = exercisesController.fetchedObjects ?? []
            updateExercisesWithTags()
        } catch {
            print("failed to fetch items!")
        }
        
    }
    
    func toggleTag(of tag: ExerciseTags) {
        let index = selectedTags.firstIndex(of: tag.objectID)
        if index == nil {
            selectedTags.append(tag.objectID)
        } else {
            selectedTags.remove(at: index!)
        }
        updateExercisesWithTags()
    }
    
    func updateExercisesWithTags() {
        if selectedTags == [] {
            exercises = fetchedExercises
        } else {
            exercises = fetchedExercises.filter { exercise in
                guard let tags = exercise.tags?.allObjects as? [ExerciseTags] else {
                    return false
                }
                
                let exerciseSet = Set(tags.map(\.objectID))
                
                return exerciseSet.isSuperset(of: selectedTags)
            }
        }
    }
    
}

extension ExercisesListViewModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let exercises = controller.fetchedObjects as? [Exercise] {
            self.fetchedExercises = exercises
            updateExercisesWithTags()
            
        } else if let tags = controller.fetchedObjects as? [ExerciseTags] {
            self.tags = tags
        }
    }
}

/*
 class TodoItemStorage: NSObject, ObservableObject {
 @Published var dueSoon: [TodoItem] = []
 private let dueSoonController: NSFetchedResultsController<TodoItem>
 
 init(managedObjectContext: NSManagedObjectContext) {
 dueSoonController = NSFetchedResultsController(fetchRequest: TodoItem.dueSoonFetchRequest,
 managedObjectContext: managedObjectContext,
 sectionNameKeyPath: nil, cacheName: nil)
 
 super.init()
 
 dueSoonController.delegate = self
 
 do {
 try dueSoonController.performFetch()
 dueSoon = dueSoonController.fetchedObjects ?? []
 } catch {
 print("failed to fetch items!")
 }
 }
 }
 
 extension TodoItemStorage: NSFetchedResultsControllerDelegate {
 func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
 guard let todoItems = controller.fetchedObjects as? [TodoItem]
 else { return }
 
 dueSoon = todoItems
 }
 }
 */
