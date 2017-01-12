class SiteStat < ActiveRecord::Base
	attr_accessible *column_names
	
	$record_stats = true

	class << self # Class methods
		def increment_estimates
			if $record_stats == true
				verify_month_exists()
				
				current_record = self.where(month: Date.today.month.to_s).first
				current_record.estimates_started = current_record.estimates_started + 1
				current_record.save
			end
		end
		
		def increment_appointments
			if $record_stats == true
				verify_month_exists()
				
				current_record = self.where(month: Date.today.month.to_s).first
				current_record.appointments_started = current_record.appointments_started + 1
				current_record.save
			end
		end
		
		def verify_month_exists()
			if self.where(month: Date.today.month.to_s).length == 0
				new_record = self.new(month: Date.today.month, year: Date.today.year)
				new_record.save
			end
		end
	end
end
