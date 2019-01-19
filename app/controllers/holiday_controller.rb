	class HolidayController < ApplicationController
			# '/saveHoliday'
			def create
					holiday = Holiday.new(holiday_params)
				#  byebug
					if holiday.save
						render json: {status: 'SUCCESS',message: 'Request saved',data: holiday},status: :ok
					else
						render json: {status: 'ERROR',message: 'Request dismissed',data: holiday.errors},status: :unprocessable_entity
					end
			end
			# get '/getAllHolidays'
			def getAllHolidays
				p = params[:p]
				holiday =Holiday.order('updated_at DESC')
				render json: {status: 'SUCCESS',message: 'Loaded holiday',data: holiday},:include=> :user, status: :ok
			end
			# get '/getUserHolidays/(/:id)
			 def getUserHolidays
					 h = Holiday.where(user_id: params[:id]).order('updated_at DESC')
					 render json: {status: 'SUCCESS',message: 'Loaded ',data: h},status: :ok
			 end
			 # get '/getUserHolidayModel/(/:id)
			 def getUserHolidayModel
					 h = Holiday.where(id: params[:id])
					 render json: {status: 'SUCCESS',message: 'Loaded ',data: h},status: :ok
			 end
	 # post '/AcceptConge/(/:id)'
			 def AcceptHoliday
					 p = params[:p]
					 holiday = Holiday.find(params[:id])
					 user = User.find(params[:user_id])
					 if holiday.update_attributes(holiday_params_Accept)
							 if user.update_attributes(user_params_AcceptConge)
							 holidays = Holiday.where(state:'waitlisted')
						render json: {status: 'SUCCESS',message: 'Updated demand accept',data: holidays},:include=> :user,status: :ok
							 end
					 else
							 render json: {status: 'ERROR',message: 'Demand accept not updated ',data: holiday.errors},status: :unprocessable_entity
					 end
			 end

					private
		 def holiday_params
				 params.permit(:dateStart, :user_id , :dateEnd, :reason)
		 end
			def holiday_params_Reject
				params.permit(:reason,:state)
			end
			def user_params_AcceptConge
            params.permit(:solde)
      end

			def holiday_params_Accept
					params.permit(:state)
			end
	end
