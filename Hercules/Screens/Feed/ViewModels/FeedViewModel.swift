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
    
    init(dataStorage: WorkoutsStorage, healthStorage: HealthStorage) {
        self.dataStorage = dataStorage
        self.healthStorage = healthStorage
        setupDataStorageBindings()
        requestHealthStoreData()
        dataStorage.emitAllWorkoutSubjects()
        bindingActivityRing()
        
    }
    
    private func setupDataStorageBindings() {
        dataStorage
            .allWorkoutSubjects
            .map { workouts in
                workouts.flatMap { $0.sessions }
            }
            .assign(to: &$sessions)
        
        dataStorage
            .allWorkoutSubjects
            .map { StatHighlightCardBuilder.build(for: $0)}
            .assign(to: &$workoutStatCardViewModels)
        
        dataStorage
            .allWorkoutSubjects
            .map {workouts -> [ThisWeekCardViewModel] in
                var calendar = Calendar.current
                calendar.locale = Locale.autoupdatingCurrent
                let days = calendar.weekdaySymbols
                let today = calendar.component(.weekday, from: Date())
                
                var workoutGroupedByDay = workouts
                    .filter { workout in workout.finalDate >= Date() }
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
                print(workoutGroupedByDay)
                return workoutGroupedByDay.map { $0.0 }
            }
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
    
    private func requestHealthStoreData() {
        
        healthStorage.requestAuthorization {[weak self] sucess in
            if sucess {
                print("oi")
                self?.bindingActivityRing()
            }
        }
        
    }
    
    private func bindingActivityRing() {
        print("to aqui")
        healthStorage
            .activityRingPublisher
            .assign(to: &$activityRing)
    }
    
}
