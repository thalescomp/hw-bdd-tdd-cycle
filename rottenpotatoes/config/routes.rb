Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get 'movies/:id/similars_by_director', to: 'movies#similars_by_director', as: :similars_by_director 
end
