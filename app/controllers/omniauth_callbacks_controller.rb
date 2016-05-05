class OmniauthCallbacksController < ApplicationController

	def facebook
      auth = request.env["omniauth.auth"]
      data = {
       nombre: auth.info.first_name,
       apellido: auth.info.last_name,
       username: auth.info_nickname,
       email: auth.info.email,
       provider: auth.provider,
       uid: auth.uid,
       
     }
 
     # LLama al metodo del modelo Usuario
     @usuario = Usuario.find_or_create_by_omniauth(data)
 
     if @usuario.persisted? # Devuelve true si ya esta en la bd
       sign_in_and_redirect @usuario, event: :authentication
     else
       session[:omniauth_errors] = @usuario.errors.full_messages.to_sentence unless @usuario.save
 
       session[:omniauth_data] = data
 
       redirect_to new_usuario_registration_url
     end
   end

	def twitter
     auth = request.env["omniauth.auth"]
     data = {
			       nombre: auth.info.name,
			       apellido: "",
			       username: auth.info.nickname,
			       email: "",
			       uid: auth.uid,
			      provider: auth.provider
     }
 
     # LLama al metodo del modelo Usuario
     @usuario = Usuario.find_or_create_by_omniauth(data)
 
     if @usuario.persisted? # Devuelve true si ya esta en la bd
       sign_in_and_redirect @usuario, event: :authentication
     else
       session[:omniauth_errors] = @usuario.errors.full_messages.to_sentence unless @usuario.save
 
       session[:omniauth_data] = data
 
       redirect_to new_usuario_registration_url
      end
  end
end
