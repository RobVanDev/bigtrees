class Address	
	attr_accessor :address_line_1, :address_line_2, :city, :postal_code
	def initialize(infoText)
		infoArray = infoText.split("|")
		
		@address_line_1 = infoArray[0]
		@address_line_2 = infoArray[1]
		@city = infoArray[2]
		@postal_code = infoArray[3]
	end
end