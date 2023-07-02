//
//  TeamsModel.swift
//  Cricket101
//
//  Created by Shivam Vishwakarma on 01/07/23.
//

import Foundation

// MARK: - Welcome
class Welcome: Codable {
    let matchdetail: Matchdetail
    let nuggets: [String]
    let innings: [Inning]
    let teams: [String: Team]
    let notes: [String: [String]]

    enum CodingKeys: String, CodingKey {
        case matchdetail = "Matchdetail"
        case nuggets = "Nuggets"
        case innings = "Innings"
        case teams = "Teams"
        case notes = "Notes"
    }

    init(matchdetail: Matchdetail, nuggets: [String], innings: [Inning], teams: [String: Team], notes: [String: [String]]) {
        self.matchdetail = matchdetail
        self.nuggets = nuggets
        self.innings = innings
        self.teams = teams
        self.notes = notes
    }
}

// MARK: - Inning
class Inning: Codable {
    let number, battingteam, total, wickets: String
    let overs, runrate, byes, legbyes: String
    let wides, noballs, penalty, allottedOvers: String
    let batsmen: [InningBatsman]
    let partnershipCurrent: PartnershipCurrent
    let bowlers: [Bowler]
    let fallofWickets: [FallofWicket]
    let powerPlay: PowerPlay
    let target: String?

    enum CodingKeys: String, CodingKey {
        case number = "Number"
        case battingteam = "Battingteam"
        case total = "Total"
        case wickets = "Wickets"
        case overs = "Overs"
        case runrate = "Runrate"
        case byes = "Byes"
        case legbyes = "Legbyes"
        case wides = "Wides"
        case noballs = "Noballs"
        case penalty = "Penalty"
        case allottedOvers = "AllottedOvers"
        case batsmen = "Batsmen"
        case partnershipCurrent = "Partnership_Current"
        case bowlers = "Bowlers"
        case fallofWickets = "FallofWickets"
        case powerPlay = "PowerPlay"
        case target = "Target"
    }

    init(number: String, battingteam: String, total: String, wickets: String, overs: String, runrate: String, byes: String, legbyes: String, wides: String, noballs: String, penalty: String, allottedOvers: String, batsmen: [InningBatsman], partnershipCurrent: PartnershipCurrent, bowlers: [Bowler], fallofWickets: [FallofWicket], powerPlay: PowerPlay, target: String?) {
        self.number = number
        self.battingteam = battingteam
        self.total = total
        self.wickets = wickets
        self.overs = overs
        self.runrate = runrate
        self.byes = byes
        self.legbyes = legbyes
        self.wides = wides
        self.noballs = noballs
        self.penalty = penalty
        self.allottedOvers = allottedOvers
        self.batsmen = batsmen
        self.partnershipCurrent = partnershipCurrent
        self.bowlers = bowlers
        self.fallofWickets = fallofWickets
        self.powerPlay = powerPlay
        self.target = target
    }
}

// MARK: - InningBatsman
class InningBatsman: Codable {
    let batsman, runs, balls, fours: String
    let sixes, dots, strikerate, dismissal: String
    let howout, bowler, fielder: String
    let isonstrike: Bool?

    enum CodingKeys: String, CodingKey {
        case batsman = "Batsman"
        case runs = "Runs"
        case balls = "Balls"
        case fours = "Fours"
        case sixes = "Sixes"
        case dots = "Dots"
        case strikerate = "Strikerate"
        case dismissal = "Dismissal"
        case howout = "Howout"
        case bowler = "Bowler"
        case fielder = "Fielder"
        case isonstrike = "Isonstrike"
    }

    init(batsman: String, runs: String, balls: String, fours: String, sixes: String, dots: String, strikerate: String, dismissal: String, howout: String, bowler: String, fielder: String, isonstrike: Bool?) {
        self.batsman = batsman
        self.runs = runs
        self.balls = balls
        self.fours = fours
        self.sixes = sixes
        self.dots = dots
        self.strikerate = strikerate
        self.dismissal = dismissal
        self.howout = howout
        self.bowler = bowler
        self.fielder = fielder
        self.isonstrike = isonstrike
    }
}

// MARK: - Bowler
class Bowler: Codable {
    let bowler, overs, maidens, runs: String
    let wickets, economyrate, noballs, wides: String
    let dots: String
    let isbowlingtandem, isbowlingnow: Bool?
    let thisOver: [ThisOver]?

    enum CodingKeys: String, CodingKey {
        case bowler = "Bowler"
        case overs = "Overs"
        case maidens = "Maidens"
        case runs = "Runs"
        case wickets = "Wickets"
        case economyrate = "Economyrate"
        case noballs = "Noballs"
        case wides = "Wides"
        case dots = "Dots"
        case isbowlingtandem = "Isbowlingtandem"
        case isbowlingnow = "Isbowlingnow"
        case thisOver = "ThisOver"
    }

    init(bowler: String, overs: String, maidens: String, runs: String, wickets: String, economyrate: String, noballs: String, wides: String, dots: String, isbowlingtandem: Bool?, isbowlingnow: Bool?, thisOver: [ThisOver]?) {
        self.bowler = bowler
        self.overs = overs
        self.maidens = maidens
        self.runs = runs
        self.wickets = wickets
        self.economyrate = economyrate
        self.noballs = noballs
        self.wides = wides
        self.dots = dots
        self.isbowlingtandem = isbowlingtandem
        self.isbowlingnow = isbowlingnow
        self.thisOver = thisOver
    }
}

// MARK: - ThisOver
class ThisOver: Codable {
    let t, b: String

    enum CodingKeys: String, CodingKey {
        case t = "T"
        case b = "B"
    }

    init(t: String, b: String) {
        self.t = t
        self.b = b
    }
}

// MARK: - FallofWicket
class FallofWicket: Codable {
    let batsman, score, overs: String

    enum CodingKeys: String, CodingKey {
        case batsman = "Batsman"
        case score = "Score"
        case overs = "Overs"
    }

    init(batsman: String, score: String, overs: String) {
        self.batsman = batsman
        self.score = score
        self.overs = overs
    }
}

// MARK: - PartnershipCurrent
class PartnershipCurrent: Codable {
    let runs, balls: String
    let batsmen: [PartnershipCurrentBatsman]

    enum CodingKeys: String, CodingKey {
        case runs = "Runs"
        case balls = "Balls"
        case batsmen = "Batsmen"
    }

    init(runs: String, balls: String, batsmen: [PartnershipCurrentBatsman]) {
        self.runs = runs
        self.balls = balls
        self.batsmen = batsmen
    }
}

// MARK: - PartnershipCurrentBatsman
class PartnershipCurrentBatsman: Codable {
    let batsman, runs, balls: String

    enum CodingKeys: String, CodingKey {
        case batsman = "Batsman"
        case runs = "Runs"
        case balls = "Balls"
    }

    init(batsman: String, runs: String, balls: String) {
        self.batsman = batsman
        self.runs = runs
        self.balls = balls
    }
}

// MARK: - PowerPlay
class PowerPlay: Codable {
    let pp1, pp2: String

    enum CodingKeys: String, CodingKey {
        case pp1 = "PP1"
        case pp2 = "PP2"
    }

    init(pp1: String, pp2: String) {
        self.pp1 = pp1
        self.pp2 = pp2
    }
}

// MARK: - Matchdetail
class Matchdetail: Codable {
    let teamHome, teamAway: String
    let match: Match
    let series: Series
    let venue: Venue
    let officials: Officials
    let weather, tosswonby, status, statusID: String
    let playerMatch, result, winningteam, winmargin: String
    let equation: String

    enum CodingKeys: String, CodingKey {
        case teamHome = "Team_Home"
        case teamAway = "Team_Away"
        case match = "Match"
        case series = "Series"
        case venue = "Venue"
        case officials = "Officials"
        case weather = "Weather"
        case tosswonby = "Tosswonby"
        case status = "Status"
        case statusID = "Status_Id"
        case playerMatch = "Player_Match"
        case result = "Result"
        case winningteam = "Winningteam"
        case winmargin = "Winmargin"
        case equation = "Equation"
    }

    init(teamHome: String, teamAway: String, match: Match, series: Series, venue: Venue, officials: Officials, weather: String, tosswonby: String, status: String, statusID: String, playerMatch: String, result: String, winningteam: String, winmargin: String, equation: String) {
        self.teamHome = teamHome
        self.teamAway = teamAway
        self.match = match
        self.series = series
        self.venue = venue
        self.officials = officials
        self.weather = weather
        self.tosswonby = tosswonby
        self.status = status
        self.statusID = statusID
        self.playerMatch = playerMatch
        self.result = result
        self.winningteam = winningteam
        self.winmargin = winmargin
        self.equation = equation
    }
}

// MARK: - Match
class Match: Codable {
    let livecoverage, id, code, league: String
    let number, type, date, time: String
    let offset, daynight: String

    enum CodingKeys: String, CodingKey {
        case livecoverage = "Livecoverage"
        case id = "Id"
        case code = "Code"
        case league = "League"
        case number = "Number"
        case type = "Type"
        case date = "Date"
        case time = "Time"
        case offset = "Offset"
        case daynight = "Daynight"
    }

    init(livecoverage: String, id: String, code: String, league: String, number: String, type: String, date: String, time: String, offset: String, daynight: String) {
        self.livecoverage = livecoverage
        self.id = id
        self.code = code
        self.league = league
        self.number = number
        self.type = type
        self.date = date
        self.time = time
        self.offset = offset
        self.daynight = daynight
    }
}

// MARK: - Officials
class Officials: Codable {
    let umpires, referee: String

    enum CodingKeys: String, CodingKey {
        case umpires = "Umpires"
        case referee = "Referee"
    }

    init(umpires: String, referee: String) {
        self.umpires = umpires
        self.referee = referee
    }
}

// MARK: - Series
class Series: Codable {
    let id, name, status, tour: String
    let tourName: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
        case status = "Status"
        case tour = "Tour"
        case tourName = "Tour_Name"
    }

    init(id: String, name: String, status: String, tour: String, tourName: String) {
        self.id = id
        self.name = name
        self.status = status
        self.tour = tour
        self.tourName = tourName
    }
}

// MARK: - Venue
class Venue: Codable {
    let id, name: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case name = "Name"
    }

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Team
struct Team: Codable {
    let nameFull, nameShort: String
    let players: [String: Player]

    enum CodingKeys: String, CodingKey {
        case nameFull = "Name_Full"
        case nameShort = "Name_Short"
        case players = "Players"
    }
}

// MARK: - Player
struct Player: Codable {
    let position, nameFull: String
    let batting: Batting
    let bowling: Bowling
    let iscaptain, iskeeper: Bool?

    enum CodingKeys: String, CodingKey {
        case position = "Position"
        case nameFull = "Name_Full"
        case batting = "Batting"
        case bowling = "Bowling"
        case iscaptain = "Iscaptain"
        case iskeeper = "Iskeeper"
    }
}

// MARK: - Batting
struct Batting: Codable {
    let style: Style
    let average, strikerate, runs: String

    enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case strikerate = "Strikerate"
        case runs = "Runs"
    }
}

enum Style: String, Codable {
    case lhb = "LHB"
    case rhb = "RHB"
}

// MARK: - Bowling
struct Bowling: Codable {
    let style, average, economyrate, wickets: String

    enum CodingKeys: String, CodingKey {
        case style = "Style"
        case average = "Average"
        case economyrate = "Economyrate"
        case wickets = "Wickets"
    }
}

