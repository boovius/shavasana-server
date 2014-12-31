module Helpers
  class Weekly
    def self.days_past
      now = Time.now
      today = now.strftime("%A")
      switch today
      case "Monday"
        0
      case "Tuesday"
        1
      case "Wednesday"
        2
      case "Thursday"
        3
      case "Friday"
        4
      case "Saturday"
        5
      case "Sunday"
        6
      end
    end
  end
end
