class AdminController < ApplicationController
	include UserHelper
	require 'spreadsheet'
	Spreadsheet.client_encoding = 'UTF-8'
	
	before_action :signed_in_user, except: [:log_in]
	
	def log_in
		if !params[:commit].nil? and params[:commit].eql?"Log In"
			user = User.where("username LIKE ?", params[:username]).first
				if !user.nil? && params[:password] == user.password
					logger.debug "Sign In"
					sign_in(user)
					logger.debug current_user
					redirect_to url_for(:controller => 'admin', :action => 'admin_panel')	
				else
					flash.now[:warning] = "Invalid Username/Password"
				end
		end
	end

def admin_panel
	@estimates = Estimate.where(status: "COMPLETE").where("response != ?", "COMPLETE").order("id DESC").limit(20)
	@current_start_date = SiteConfig.where(attribute_name: "start_date").first.attribute_value
	
	set_stats()
end

def view_all_appointments_and_estimates
	@appointments = Appointment.where(status: "COMPLETE").order("id DESC")
	@estimates = Estimate.where(status: "COMPLETE").order("id DESC")
end

def view_appointment_by_id
	@appointment = Appointment.find_by_id(params[:appointment_id])
	
	image_ids = TreeImage.where(appointment_id: @appointment.id)
	@images_attached = true
	if image_ids.length == 0
		@images_attached = false
	end
	
	if @images_attached
		@tree_image_array = Array.new
		for i in 1 .. @appointment.tree_quantity.to_i
			current_tree_array = Array.new
			image_ids.each do |img|
				if img.tree_number == i
					current_tree_array.push(img.filename)
				end
			end
			@tree_image_array.push(current_tree_array)
		end
	end
	if !@appointment.estimate_id.nil?
		@estimate = Estimate.find_by_id(@appointment.estimate_id)
		@estimate_work = WorkAction.where("estimate_id = ? AND status = ?", @appointment.estimate_id, "COMPLETE").order(tree_index: :asc)
	end
end

def view_estimate_by_id
	@estimate = Estimate.find_by_id(params[:estimate_id])
	@estimate_work = WorkAction.where("estimate_id = ?", params[:estimate_id]).order(tree_index: :asc)
	
	image_ids = TreeImage.where(estimate_id: @estimate.id)
	@images_attached = true
	if image_ids.length == 0
		@images_attached = false
	end
	
	if @images_attached
		@tree_image_array = Array.new
		for i in 1 .. @estimate.tree_quantity.to_i
			current_tree_array = Array.new
			image_ids.each do |img|
				if img.tree_number == i
					current_tree_array.push(img.filename)
				end
			end
			@tree_image_array.push(current_tree_array)
		end
	end
end

def get_appointment_image
  @image_data = TreeImage.find_by_id(params[:id])
  @image = @image_data.binary_data
  send_data @image, :type     => @image_data.content_type, :filename => @image_data.filename, :disposition => 'inline'
end

def update_start_date
	@date_field = SiteConfig.where(attribute_name: "start_date").first
	if !params[:start_date].nil?
		@date_field.attribute_value = params[:start_date]
		@date_field.save
		@change_status = "Successfully Changed"
	else
		@change_status = "Could Not Change"
	end
	@current_start_date = SiteConfig.where(attribute_name: "start_date").first.attribute_value
	
	redirect_to controller: 'admin', action: 'admin_panel'
end

def get_estimate_spreadsheet
	@estimates= Estimate.where("status = ?", "COMPLETE")
	
	book = Spreadsheet::Workbook.new
	sheet1 = book.create_worksheet
	sheet1.name = "Estimate Tracker"
	
	row = sheet1.row(0)
	
	row.push 'ID'					#COLUMN 1
	row.push 'Date'					#COLUMN 2
	row.push 'Name'					#COLUMN 3
	row.push 'Street Address'		#COLUMN 4
	row.push 'City'					#COLUMN 5
	row.push 'Tree #'				#COLUMN 6
	row.push 'Contact Method'		#COLUMN 7
	row.push 'Contact Info'			#COLUMN 8
	
	#Set Column Widths
	format = Spreadsheet::Format.new :weight => :bold
	sheet1.row(0).default_format = format
	sheet1.column(0).width = 10		#COLUMN 1
	sheet1.column(1).width = 15		#COLUMN 2
	sheet1.column(2).width = 20		#COLUMN 3
	sheet1.column(3).width = 25		#COLUMN 4
	sheet1.column(4).width = 20		#COLUMN 5
	sheet1.column(5).width = 5		#COLUMN 6
	sheet1.column(6).width = 10		#COLUMN 7
	sheet1.column(6).width = 10		#COLUMN 8
	
	
	index = 1
	@estimates.each do |est|
		#Custom date format
		date_arr = est.date_submitted.to_s.split('-')
		date = date_arr[2] + '/' + date_arr[1] + '/' + date_arr[0]
		row = sheet1.row(index)
		
		row.push est.id.to_s
		row.push date
		row.push est.name.to_s
		
		
		row.push est.address.to_s
		row.push est.city.to_s
		row.push est.tree_quantity.to_s
		row.push est.contact_type
		row.push est.contact_method
		
		index = index + 1
	end
	
	
	path = File.join(Rails.root, 'public', 'BigTreeData.xls')
	
	book.write path

	send_file path
	
end

def change_response
	estimate = Estimate.find_by_id(params[:estimate_id])
	
	estimate.response = params[:response_type]
	dt = Date.today
	today = dt.year.to_s + "-" + dt.month.to_s + "-" + dt.day.to_s
	estimate.last_change = today
	
	estimate.save
	
	redirect_to action: 'view_estimate_by_id', estimate_id: estimate.id
	
end

private
	def set_stats
		statMonths = SiteStat.all
		
		@statsArray = Array.new
		statMonths.each do |entry|
			queryString = entry.year + "-" + entry.month + "-"
			
			estInProgress = Estimate.where("status = ? AND date_submitted REGEXP ?", "IN PROGRESS", "#{queryString}[0-9]+").length
			estImages = Estimate.where("status = ? AND date_submitted REGEXP ?", "AWAITING IMAGES", "#{queryString}[0-9]+").length
			estCompleted = Estimate.where("status = ? AND date_submitted REGEXP ?", "COMPLETE", "#{queryString}[0-9]+").length
			estPercentage = ((estCompleted.to_f / (estCompleted + estInProgress + estImages).to_f) * 100.0).round(2)
			
			
			
			statsHash = {date: entry.year + "-" + entry.month, est_requested: entry.estimates_started, est_in_progress: estInProgress, est_images: estImages, est_complete: estCompleted, est_percentage: estPercentage}
			@statsArray.push(statsHash)
			logger.debug "IN PROGRESS: " + (estInProgress.to_s)
		end
	
	end
	
	def signed_in_user
		logger.debug "SIGNED IN USER"
		if !signed_in?
			redirect_to controller: 'admin', action: 'log_in'
		end
	end

end
