//
//  FeedViewModel.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 22/07/21.
//
import Foundation
import Combine

final class FeedViewModel: ObservableObject {
    
    private var dataStorage: WorkoutsStorage
    private var healthStorage: HealthStorage
    private let dateHelper: DatesHelper
    
    private var cancellables = Set<AnyCancellable>()
    
    @Published
    var isOnForeground = true
    
    @Published
    var thisWeekCardViewModel: [ThisWeekCardViewModel] = []
    
    @Published
    private var fetchedThisWeekCardViewModel: [ThisWeekCardViewModel] = []
    
    @Published
    var sessions: [WorkoutSession] = []

    @Published
    var workoutStatCardViewModels: [StatHighlightsCardViewModel] = []
    
    @Published
    var activityRing: [ActivityRingData] = []
    
    init(dataStorage: WorkoutsStorage, healthStorage: HealthStorage, dateHelper: DatesHelper = DatesHelperImpl()) {
        self.dataStorage = dataStorage
        self.healthStorage = healthStorage
        self.dateHelper = dateHelper
        setupDataStorageBindings()
        requestHealthStoreData()
        dataStorage.emitAllWorkoutSubjects()
        bindingActivityRing()
        
    }
    
    private func setupDataStorageBindings() {
        dataStorage
            .allWorkoutSubjects
            .map(fetchAllSectionsFromWorkouts)
            .assign(to: &$sessions)
        
        dataStorage
            .allWorkoutSubjects
            .map { StatHighlightCardBuilder.build(for: $0)}
            .assign(to: &$workoutStatCardViewModels)
        
        dataStorage
            .allWorkoutSubjects
            .map(transformWorkoutDataIntoCards)
            .assign(to: &$fetchedThisWeekCardViewModel)
        
        Publishers.CombineLatest($isOnForeground, $fetchedThisWeekCardViewModel)
            .filter { (isOnForeground, fetchedThisWeekCardViewModel) in
                isOnForeground
            }
            .map { (isOnForeground, fetchedThisWeekCardViewModel) in
                return fetchedThisWeekCardViewModel
            }
            .assign(to: &$thisWeekCardViewModel)
    }
    
    private func fetchAllSectionsFromWorkouts(_ workouts: [Workout]) -> [WorkoutSession] {
        var sessions = workouts.flatMap { $0.sessions }
        sessions.sort { $0.date > $1.date }
        return sessions
    }
    
    private func transformWorkoutDataIntoCards(workouts: [Workout]) -> [ThisWeekCardViewModel] {
        let days = dateHelper.days
        let today = dateHelper.todayWeekDay
        
        var workoutGroupedByDay = workouts
            .filter { workout in workout.finalDate >= dateHelper.today }
            .flatMap { workout in
            workout
                .daysOfTheWeek
                .filter {$0 >= today }
                .map { day -> (ThisWeekCardViewModel, Int) in
                let dateString: String
                if day == today {
                    dateString = "Today"
                } else {
                    dateString = days[day-1]
                }
                
                return (ThisWeekCardViewModel(name: workout.name, dateString: dateString, workout: workout), day)
            }
        }
        workoutGroupedByDay.sort { $0.1 < $1.1 }
        return workoutGroupedByDay.map { $0.0 }
    }
    
    private func requestHealthStoreData() {
        
        healthStorage.requestAuthorization {[weak self] sucess in
            if sucess {
                self?.bindingActivityRing()
            }
        }
        
    }
    
    private func bindingActivityRing() {
        healthStorage
            .activityRingPublisher
            .assign(to: &$activityRing)
    }
    
}
