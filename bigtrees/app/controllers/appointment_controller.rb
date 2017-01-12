class AppointmentController < ApplicationController
$image_names = [:tree_image_1, :tree_image_2, :tree_image_3]
$months = ["NULL", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

	def new
		SiteStat.increment_appointments()
		@current_action = "Info"
		
		if !params[:estimate_id].nil?
			current_estimate = Estimate.find_by_id(params[:estimate_id])
			@name = current_estimate.name
			@address_line_1 = current_estimate.address
			@city = current_estimate.city
			@num_trees = current_estimate.tree_quantity
			@estimate_id = params[:estimate_id]
		elsif params[:from_estimate_form].eql?'true'
			@name = params[:name]
			@address_line_1 = params[:address]
			@city = params[:city]
			@num_trees = "4+"
		else
			@name = ""
			@address_line_1 = ""
			@address_line_2 = ""
			@city = ""
			@num_trees = 1
		end
	end
	
	def submit_new_appointment
		if params[:submitted_action] == "Info"
			new_appt = Appointment.new
			new_appt.name = params[:name]
			new_appt.address = params[:address_line_1]
			new_appt.city = params[:city]
			new_appt.tree_quantity = params[:num_trees]
			new_appt.status = "IN PROGRESS"
			if !params[:estimate_id].nil?
				new_appt.estimate_id = params[:estimate_id]
			end
			
			dt = Date.today
			today = dt.year.to_s + "-" + dt.month.to_s + "-" + dt.day.to_s
			new_appt.date_submitted = today
			
			new_appt.contact_type = params[:contact_method]
			if params[:contact_method].eql?'Phone'
				new_appt.contact_method = params[:phone_number]
			elsif params[:contact_method].eql?'Email'
				new_appt.contact_method = params[:email_address]
			else
				new_appt.contact_method = params[:cell_number]
			end
			
			new_appt.save
			
			@current_action = "Image"
			@num_trees = params[:num_trees]
			@appt_id = new_appt.id
			
			if !is_number(new_appt.tree_quantity)
				#Skip Image Upload
				new_appt.status = "COMPLETE"
				new_appt.save
				@current_action = "Complete"
				redirect_to :action => 'appointment_complete', :format => 'html'
			end
		elsif params[:submitted_action] == "Image"
			if params[:commit] != "Skip"
				@num_trees = params[:num_trees].to_i
				for i in 1..@num_trees
					for j in 1..3
						tree_string = "tree_" + i.to_s + "_image_" + j.to_s
						user_image = params[tree_string]
						if !user_image.nil?
							fileName = "Appt" + params[:appointment_id] + "_" + tree_string + File.extname(user_image.original_filename).to_s
							path = File.join(Rails.root, 'public', 'TreeImages', fileName)
							File.open(path, 'wb') do |file|
								file.write(user_image.read)
							end		
							
							new_image = TreeImage.new
							new_image.appointment_id = params[:appointment_id]
							new_image.filename = fileName
							new_image.tree_number = i
							new_image.save
							

						end
					end

				end
			end
			new_appt = Appointment.find_by_id(params[:appointment_id])
			new_appt.status = "COMPLETE"
			new_appt.save
			
			EstimateMailer.appointment_alert(params[:appointment_id]).deliver_later
			
			@current_action = "Complete"
			redirect_to :action => 'appointment_complete'
			
		
		end
		
		respond_to do |format|
			format.html{}
			format.js {}
		end
	end
	
	def appointment_complete
		respond_to do |format|
			format.html{}
			format.js {}
		end
	end
	
	
	private
	
		def is_number(string)
			true if Float(string) rescue false
		end
end
