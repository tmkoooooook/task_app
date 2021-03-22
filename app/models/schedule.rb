class Schedule < ApplicationRecord
    validates :title, presence: true
    validates :start_day, presence: true
    validates :end_day, presence: true
    validate :start_over_end
    def start_over_end
        if start_day >=end_day
            errors.add(:end_day, "を開始日以降にしてください")
        end
    end
    
    def self.sort(selection)
        case selection
            when "update"
                return all.order(updated_at: :DESC)
            when "start"
                return all.order(start_day: :ASC)
            when "end"
                return all.order(end_day: :ASC)
            end
    end
end
