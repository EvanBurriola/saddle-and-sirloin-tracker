class Event < ApplicationRecord
    validates :name, presence: true
    validates :date, presence: true
    validates :event_type, presence: true
    validates :description, presence: true
    validates :start_time, presence: false
    validates :end_time, presence: false

    TYPE = {
        "Service" => 1,
        "Meetings" => 2,
        "Social" => 3
    }

    def formatted_type
        TYPE.invert[event_type]
    end
    
    def self.search(search, category)
        if category == ""
            if search
                named_event = Event.where("name ilike ?",  "%#{search}%")
                #if event with  name exists show the events with that name 
                if named_event
                    # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                    @events = Event.where("name ilike ?",  "%#{search}%")
                #if no events with that name exist print all events
                else 
                    @events = Event.all
                end
            else 
                @events = Event.all
            end
        else 
            if search
                named_event = Event.where("name ilike ? AND event_type = ?", "%#{search}%", TYPE[category])
                #if event with  name exists show the events with that name 
                if named_event
                    # here we use .where method since we need @events to be an array. .find_by only returns 1 obj
                    @events = Event.where("name ilike ? AND event_type = ?", "%#{search}%", TYPE[category])
                #if no events with that name exist print all events
                else 
                    @events = Event.all
                end
            else 
                @events = Event.all
            end
        end
    end
end