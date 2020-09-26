//
//  GameContext.swift
//  0003_GameArchTest
//
//  Created by Kikutada on 2020/08/12.
//  Copyright © 2020 Kikutada. All rights reserved.
//

import Foundation

/// Context and settings for game
class CgContext {

    enum EnLevel: Int {
        case Level_A = 0, Level_B, Level_C, Level_D
    }

    enum EnLanguage: Int {
        case English = 0, Japanese
    }

    var language: EnLanguage = .Japanese

    var highScore = 0
    var score = 0
    var numberOfPlayers = 0
    var round = 0
    var credit = 0

    var score_extendPlayer: Int = 0
    var score_extendedPlayer: Bool = false
    
    var numberOfFeeds: Int = 0
    var playerMiss: Bool = false
    var numberOfFeedsEatedByMiss: Int = 0
    var numberOfFeedsEated: Int = 0
    var numberOfFeedsRemaingToSpurt: Int = 0
    var numberOfFeedsToAppearSpecialTarget: Int = 0
    var kindOfSpecialTarget: CgSpecialTarget.EnSpecialTarget = .None
    
    var ghostPts: CgScorePts.EnScorePts = .pts100

    var levelOfSpeed: EnLevel = .Level_A
    var levelOfAppearance: EnLevel = .Level_A
    var timeWithPower: Int = 0
    var timeNotToEat: Int = 0
    var intermission: Int = 0

    var demo: Bool = false
    var demoSequence: Int = 0
    var counterByFrame: Int = 0
    
    // ============================================================
    //  Settings
    // ============================================================

    let table_difficultySettings: [(round: Int, levelOfSpeed: EnLevel, timeWithPower: Int, numberOfFeedsRemaingToSpurt: Int, levelOfAppearance: EnLevel, kindOfSpecialTarget: CgSpecialTarget.EnSpecialTarget, timeNotToEat: Int, imtermission: Int)] = [
            //round, speedLevel, PowerTime[ms], Spurtfeeds, GhostAppear, SpecialTarget, NoEatTime[ms], Intermission
            (     1,   .Level_A,          6000,         20,    .Level_A,      .Cherry,           4000,            0 ),
            (     2,   .Level_B,          5000,         30,    .Level_B,  .Strawberry,           4000,            1 ),
            (     3,   .Level_B,          4000,         40,    .Level_C,      .Orange,           3000,            0 ),
            (     4,   .Level_B,          3000,         40,    .Level_C,      .Orange,           3000,            0 ),
            (     5,   .Level_C,          2000,         40,    .Level_C,       .Apple,           3000,            2 ),
            (     6,   .Level_C,          5000,         50,    .Level_C,       .Apple,           3000,            0 ),
            (     7,   .Level_C,          2000,         50,    .Level_C,       .Melon,           3000,            0 ),
            (     8,   .Level_C,          2000,         50,    .Level_C,       .Melon,           3000,            0 ),
            (     9,   .Level_C,          1000,         60,    .Level_C,    .Galaxian,           3000,            3 ),
            (    10,   .Level_C,          5000,         60,    .Level_C,    .Galaxian,           3000,            0 ),
            (    11,   .Level_C,          2000,         60,    .Level_C,        .Bell,           3000,            0 ),
            (    12,   .Level_C,          1000,         80,    .Level_C,        .Bell,           3000,            0 ),
            (    13,   .Level_C,          1000,         80,    .Level_C,         .Key,           3000,            3 ),
            (    14,   .Level_C,          3000,         80,    .Level_C,         .Key,           3000,            0 ),
            (    15,   .Level_C,          1000,        100,    .Level_C,         .Key,           3000,            0 ),
            (    16,   .Level_C,          1000,        100,    .Level_C,         .Key,           3000,            0 ),
            (    17,   .Level_C,             0,        100,    .Level_C,         .Key,           3000,            3 ),
            (    18,   .Level_C,          1000,        100,    .Level_C,         .Key,           3000,            0 ),
            (    19,   .Level_C,             0,        100,    .Level_C,         .Key,           3000,            0 ),
            (    20,   .Level_C,             0,        100,    .Level_C,         .Key,           3000,            0 ),
            (    21,   .Level_C,             0,        100,    .Level_C,         .Key,           3000,            0 ),
            (    22,   .Level_D,             0,        100,    .Level_C,         .Key,           3000,            0 )
        ]

    let table_speedSettings: [ (eatNone: Int, eatFeed: Int, eatPow: Int, eatNoneInPow: Int, eatFeedInPow: Int, eatPowInPow: Int,
         ghost: Int, ghostInSpurt: Int, ghostInPow: Int, ghostInWarp: Int) ]
        = [
            // Level A
            ( eatNone: 16, eatFeed: 15, eatPow: 13, eatNoneInPow: 18, eatFeedInPow: 17, eatPowInPow: 15,
              ghost: 15, ghostInSpurt: 16, ghostInPow: 10, ghostInWarp: 8 ),
            // Level B
            ( eatNone: 18, eatFeed: 17, eatPow: 15, eatNoneInPow: 19, eatFeedInPow: 18, eatPowInPow: 16,
              ghost: 17, ghostInSpurt: 18, ghostInPow: 11, ghostInWarp: 9 ),
            // Level C
            ( eatNone: 20, eatFeed: 19, eatPow: 17, eatNoneInPow: 20, eatFeedInPow: 19, eatPowInPow: 17,
              ghost: 19, ghostInSpurt: 20, ghostInPow: 12, ghostInWarp: 10 ),
            // Level D
            ( eatNone: 18, eatFeed: 17, eatPow: 15, eatNoneInPow: 18, eatFeedInPow: 17, eatPowInPow: 15,
              ghost: 19, ghostInSpurt: 20, ghostInPow: 10, ghostInWarp: 9 )
        ]

    let table_operationInDemo: [ (frameCount: Int, direction: EnDirection) ] = [
        (3, .Left), (33, .Down), (56, .Right), (76, .Down), (101, .Right), (211, .Up), (247, .Left),
        (259, .Up), (284, .Right), (305, .Up), (327, .Left), (379, .Up), (462, .Left),
        (515, .Left), (558, .Down), (578, .Left), (598, .Up), (702, .Left), (732, .Down),
        (811, .Right), (893, .Up), (934, .Left), (1004, .Down), (1034, .Right),
        (1168, .Down), (1249, .Right), (1341, .Down), (1392, .Left), (1439, .Down),
        (1468, .Right), (1486, .Down), (1507, .Right), (1570, .Up), (1630, .Up),
        (1665, .Right), (1826, .Up), (1903, .Left), (1974, .Down), (2002, .Left),
        (2028, .Down), (2054, .Left), (2070, .Up), (2098, .Left), (2123, .Up)
        /*
        (1, .Right), (60, .Down), (80, .Right), (110, .Down), (150, .Left), (310, .Up), (380, .Right), (410, .Up),
        (500, .Right), (530, .Up), (550, .Up), (570, .Right), (590, .Up), (610, .Left), (630, .Up), (660, .Left),
        (740, .Down), (820, .Up), (840, .Right), (880, .Down), (960, .Left), (1083, .Up), (1120, .Down), (1172, .Right),
        (1236, .Down), (1278, .Up), (1357, .Left), (1547, .Right), (1576, .Up), (1620, .Right), (1709, .Up),
        (1770, .Right), (1808, .Down), (1883, .Left), (1919, .Down) */
    ]

    // ============================================================
    //  General methods in this class
    // ============================================================

    func resetGame() {
        score = 0
        numberOfPlayers = 3
        round = 1
        score_extendPlayer = (language == .English) ? 20000 : 10000
        score_extendedPlayer = false
    }
        
    func resetRound() {
        playerMiss = false
        numberOfFeedsEatedByMiss = 0
        numberOfFeedsEated = 0
        numberOfFeedsToAppearSpecialTarget = 70
        resetGhostPts()
        setDifficulty()
    }
    
    func resetGhostPts() {
        ghostPts = .pts200
    }
    
    /// Set the flag of player miss
    func setPlayerMiss() {
        numberOfFeedsEatedByMiss = 0
        playerMiss = true
    }

    /// Update high score
    /// - Returns: If true, the high score has been updated.
    func updateHighScore()->Bool {
        let highScoreUpdated: Bool = score > highScore
        if highScoreUpdated { highScore = score }
        return highScoreUpdated
    }
    
    /// Update timing to appear special target
    func updateSpecialTargetAppeared() {
        numberOfFeedsToAppearSpecialTarget += 100
    }
    
    /// Set difficulty of the round
    func setDifficulty() {
        let index = demo ? 0 : round-1
        let count = table_difficultySettings.count
        let table = (index < count) ? table_difficultySettings[index] : table_difficultySettings[count-1]
        
        levelOfSpeed = table.levelOfSpeed
        timeWithPower = table.timeWithPower
        numberOfFeedsRemaingToSpurt = table.numberOfFeedsRemaingToSpurt
        levelOfAppearance = table.levelOfAppearance
        kindOfSpecialTarget = table.kindOfSpecialTarget
        timeNotToEat = table.timeNotToEat
        intermission = table.imtermission
    }
    
    /// Get player speed
    /// - Parameters:
    ///   - action: Action of player
    ///   - power: True is with power
    /// - Returns: Speed
    func getPlayerSpeed(action: CgPlayer.EnPlayerAction, with power: Bool ) -> Int {
        let index = levelOfSpeed.rawValue
        let count = table_speedSettings.count
        let table = (index < count) ? table_speedSettings[index] : table_speedSettings[count-1]

        switch action {
            case .Walking where !power : return table.eatNone
            case .Walking where  power : return table.eatNoneInPow
            case .EatingFeed where !power : return table.eatFeed
            case .EatingFeed where  power : return table.eatFeedInPow
            case .EatingPower where !power : return table.eatPow
            case .EatingPower where  power : return table.eatPowInPow
            case .EatingFruit where !power : return table.eatNone
            case .EatingFruit where  power : return table.eatNoneInPow
            default: return 16
        }
    }

    /// Get ghost speed
    /// - Parameter action: Action of ghost
    /// - Returns: Speed
    func getGhostSpeed(action: CgGhost.EnGhostAction) -> Int {
        let index = levelOfSpeed.rawValue
        let count = table_speedSettings.count
        let table = (index < count) ? table_speedSettings[index] : table_speedSettings[count-1]

        switch action {
            case .Walking: return table.ghost
            case .Spurting: return table.ghostInSpurt
            case .Frightened: return table.ghostInPow
            case .Warping: return table.ghostInWarp
            case .GoingOut: fallthrough
            case .Standby: return 8
            case .Escaping: return 32
            default: return 16
        }
    }

    /// Appearance timing level
    /// - Returns: Number of ghosts to go out
    func getNumberOfGhostsForAppearace() -> Int {
        let numberOfGhosts: Int
        // Miss Bypass Sequence
        if playerMiss {
            if numberOfFeedsEatedByMiss < 7 {
                numberOfGhosts = 1
            } else if numberOfFeedsEatedByMiss < 17 {
                numberOfGhosts = 2
            } else if numberOfFeedsEatedByMiss < 32 {
                numberOfGhosts = 3
            } else {
                playerMiss = false
                numberOfGhosts = getNumberOfGhostsForAppearace()
            }
        } else {
            switch levelOfAppearance {
                case .Level_A:
                    if numberOfFeedsEated < 30 {
                        numberOfGhosts = 2
                    } else if numberOfFeedsEated < 90 {
                        numberOfGhosts = 3
                    } else {
                        numberOfGhosts = 4
                    }
                case .Level_B:
                    if numberOfFeedsEated < 50 {
                        numberOfGhosts = 3
                    } else {
                        numberOfGhosts = 4
                    }
                case .Level_C: fallthrough
                default:
                    numberOfGhosts = 4
            }
        }
        return numberOfGhosts
    }
    
    /// Judgement of Wavy Attack of Ghosts
    /// - Parameter time: elapsed time from the start
    /// - Returns: True is to become chase mode
    func judgeGhostsWavyChase(time: Int) -> Bool {
        var chaseMode: Bool = false
        switch levelOfSpeed {
            case .Level_A:
                chaseMode = (time >= 7000 && time < 27000) || (time >= 34000 && time < 54000)
                         || (time >= 59000 && time < 79000) || (time >= 84000)
            case .Level_B:
                chaseMode = (time >= 7000 && time < 27000) || (time >= 34000 && time < 54000)
                         || (time >= 59000)
            case .Level_C: fallthrough
            case .Level_D:
                chaseMode = (time >= 5000 && time < 25000) || (time >= 30000 && time < 50000)
                         || (time >= 55000)
        }
        return chaseMode
    }
    
    /// Judgement of Blinky's Spurt
    /// - Returns: True is to spurt.
    func judgeBlinkySpurt() -> Bool {
        let feedsRemain: Int = numberOfFeeds - numberOfFeedsEated
        return (feedsRemain <= numberOfFeedsRemaingToSpurt)
    }
    
    /// Get player operation for demonstration
    /// - Returns: Direction
    func getOperationForDemo() -> EnDirection {
        guard(demoSequence < table_operationInDemo.count) else { return .None }
        let table = table_operationInDemo[demoSequence]
        var direction: EnDirection = .None
        if counterByFrame >= table.frameCount {
            direction = table.direction
            demoSequence += 1
        }
        return direction
    }

}
