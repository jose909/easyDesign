class OmniauthCallbacksController < ApplicationController

	def facebook
		auth = request.env["omniauth.auth"]

		data = {
			nombre: auth.info.first_name,
			apellido: auth.info.last_name,
			username: auth.info_nickname,
			email: auth.info.email,
			uid: auth.id,
			provider: auth.provider
		}

		@usuario = Usuario.find_or_create_by_omniauth(data)
		
		if @usuario.persisted?
			sign_in_and_redirect @usuario, event: :authentication
		else
			session[:omniauth_errors] = @usuario.errors.full_messages.to_sentence unless @usuario.save
			
			session[:omniauth_data] = data

			redirect_to new_usuario_registration_url
		end
	end
  
end
