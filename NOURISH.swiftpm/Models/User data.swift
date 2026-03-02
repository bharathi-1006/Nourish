import Foundation

struct FavoriteRecipe: Codable, Identifiable {
    let id: String
    let recipeId: String
    let savedDate: Date
}

struct ShoppingListItem: Codable, Identifiable {
    let id: String
    let ingredient: String
    let quantity: String
    let unit: String
    let isChecked: Bool
    let category: String?
}

struct MealPlanItem: Codable, Identifiable {
    let id: String
    let date: Date
    let meal: String      // breakfast, lunch, dinner, snack
    let recipeId: String
    var source: String    // "regular" | "fixed" | "smart"  (default: "regular" for legacy items)

    // Custom init to supply default so existing saved data (no source field) decodes cleanly
    init(id: String, date: Date, meal: String, recipeId: String, source: String = "regular") {
        self.id       = id
        self.date     = date
        self.meal     = meal
        self.recipeId = recipeId
        self.source   = source
    }

    // Decode with fallback so old UserDefaults data (missing source) still loads
    init(from decoder: Decoder) throws {
        let c       = try decoder.container(keyedBy: CodingKeys.self)
        id          = try c.decode(String.self,  forKey: .id)
        date        = try c.decode(Date.self,    forKey: .date)
        meal        = try c.decode(String.self,  forKey: .meal)
        recipeId    = try c.decode(String.self,  forKey: .recipeId)
        source      = (try? c.decode(String.self, forKey: .source)) ?? "regular"
    }
}

struct CookingProgress: Codable {
    let recipeId: String
    var completedSteps: [String] = []
}

// MARK: - Fixed Plan Models

/// A single meal slot in the weekly fixed plan template.
/// weekday follows ISO 8601: 1 = Monday … 7 = Sunday (matching Calendar.current).
struct FixedPlanEntry: Codable, Identifiable {
    let id: String
    let weekday: Int     // 2=Mon, 3=Tue, 4=Wed, 5=Thu, 6=Fri, 7=Sat, 1=Sun (Calendar.weekday)
    let meal: String     // breakfast | lunch | dinner | snack | beverage
    let recipeId: String
    var mode: String     // health mode rawValue — "normal" | "diabetic" | "heartCare" etc.

    init(id: String, weekday: Int, meal: String, recipeId: String, mode: String = "normal") {
        self.id       = id
        self.weekday  = weekday
        self.meal     = meal
        self.recipeId = recipeId
        self.mode     = mode
    }

    init(from decoder: Decoder) throws {
        let c     = try decoder.container(keyedBy: CodingKeys.self)
        id        = try c.decode(String.self, forKey: .id)
        weekday   = try c.decode(Int.self,    forKey: .weekday)
        meal      = try c.decode(String.self, forKey: .meal)
        recipeId  = try c.decode(String.self, forKey: .recipeId)
        mode      = (try? c.decode(String.self, forKey: .mode)) ?? "normal"
    }
}

/// Human-readable weekday names ordered Mon→Sun for UI display.
enum FixedPlanWeekday: Int, CaseIterable, Identifiable {
    case monday    = 2
    case tuesday   = 3
    case wednesday = 4
    case thursday  = 5
    case friday    = 6
    case saturday  = 7
    case sunday    = 1

    var id: Int { rawValue }

    var displayName: String {
        switch self {
        case .monday:    return "Monday"
        case .tuesday:   return "Tuesday"
        case .wednesday: return "Wednesday"
        case .thursday:  return "Thursday"
        case .friday:    return "Friday"
        case .saturday:  return "Saturday"
        case .sunday:    return "Sunday"
        }
    }

    var shortName: String { String(displayName.prefix(3)) }

    var icon: String {
        switch self {
        case .monday:    return "1.circle.fill"
        case .tuesday:   return "2.circle.fill"
        case .wednesday: return "3.circle.fill"
        case .thursday:  return "4.circle.fill"
        case .friday:    return "5.circle.fill"
        case .saturday:  return "6.circle.fill"
        case .sunday:    return "7.circle.fill"
        }
    }
}

/// All supported meal slots in the Fixed Plan (superset of the main planner).
enum FixedPlanMealSlot: String, CaseIterable, Identifiable {
    case breakfast = "breakfast"
    case lunch     = "lunch"
    case dinner    = "dinner"
    case snack     = "snack"
    case beverage  = "beverage"

    var id: String { rawValue }

    var displayName: String { rawValue.capitalized }

    var icon: String {
        switch self {
        case .breakfast: return "☀️"
        case .lunch:     return "🥗"
        case .dinner:    return "🍽️"
        case .snack:     return "🥜"
        case .beverage:  return "🥤"
        }
    }

    var systemIcon: String {
        switch self {
        case .breakfast: return "sunrise.fill"
        case .lunch:     return "sun.max.fill"
        case .dinner:    return "moon.stars.fill"
        case .snack:     return "leaf.fill"
        case .beverage:  return "cup.and.saucer.fill"
        }
    }
}
