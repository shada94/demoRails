Rails.application.routes.draw do
	devise_for :users

	post "holiday/saveHoliday", to: 'holiday#create'
	get "holiday/getUserHolidays/(/:id)", to: 'holiday#getUserHolidays'
	get "holiday/getUserHolidayModel/(/:id)", to: 'holiday#getUserHolidayModel'
	get "holiday/getAllHolidays/", to: 'holiday#getAllHolidays'
	post "/holiday/AcceptHoliday/(/:id)", to: 'holiday#AcceptHoliday'


	root 'application#index'
		get '/GetLoggedUserInfo', to: 'application#GetLoggedUserInfo'

end
