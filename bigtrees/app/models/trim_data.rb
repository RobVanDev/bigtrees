class TrimData
	def initialize(infoText)
		infoArray = infoText.split("|")
		
		@percentage = infoArray[0]
		@vehicle = infoArray[1]
		@break = infoArray[2]
		@wood = infoArray[3]
	end
	
	def percentage
		return @percentage
	end
	
	def vehicle_access
		if @vehicle == "yes"
			return true
		end
		return false;
	end
	
		def breakable
		if @break == "yes"
			return true
		end
		return false;
	end
	
	def keeping_wood
		if @wood == "yes"
			return true
		end
		return false;
	end
end