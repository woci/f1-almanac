//
//  ScheduleService.swift
//  F1 Almanac
//
//  Created by Peter Varadi3 on 2022. 06. 02..
//

import Foundation

protocol ScheduleService {
    func currentSeasonSchedule() async throws -> Schedule
    func schedule(ofYear year: Int) async throws -> Schedule
}

struct RESTSchedulService: ScheduleService {
    func schedule(ofYear year: Int) async throws -> Schedule {
        let request = ScheduleRequestBuilder.season(ofYear: year)

        let result: ResponseResult = await URLSession.shared.send(request: request)
        switch result {
        case .success(let responseData, _):
            return try (JSONDecoder.decode(data: responseData) as ScheduleResponse).data
        case .error(let error):
            throw error
        }
    }

    func currentSeasonSchedule() async throws -> Schedule {
        let components = Calendar.current.dateComponents([.year], from: Date())
        return try await self.schedule(ofYear: components.year!)
    }
}

//private struct ScheduleServiceKey: InjectionKey {
//    static var currentValue: ScheduleService = RESTSchedulService()
//}
//
//extension InjectedValues {
//    var scheduleService: ScheduleService {
//        get { Self[ScheduleServiceKey.self] }
//        set { Self[ScheduleServiceKey.self] = newValue }
//    }
//}
