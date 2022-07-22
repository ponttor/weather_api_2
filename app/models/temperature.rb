class Temperature < ApplicationRecord

  def self.start
    AddTemperatureJob.perform_now 
  end
end
