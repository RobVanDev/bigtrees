module ApplicationHelper

	def is_number string
		true if Float(string) rescue false
	end
	
	def parse_work_action string, info_array
		if string == "Removal"
			return "Tree Removal"
		elsif string == "Broken Limbs"
			return "Broken Limb Removal (" + info_array[0] + ")"
		elsif string == "Trim"
			return "Tree Trimming (" + info_array[0] + ")"
		end
	end
end
