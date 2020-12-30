class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!

  get "/recipes/new" do #loads new recipe form
    erb :new
  end

  get "/recipes" do #loads index page
    @recipes = Recipe.all
    erb :index
  end

  get "/recipes/:id" do #loads show page
    @recipe = Recipe.find_by_id(params[:id])
    erb :show
  end

  get "/recipes/:id/edit" do #loads edit form
    @recipe = Recipe.find_by_id(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do #updates recipe info and redirects to show page
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save
    redirect to "/recipes/#{@recipe.id}"
  end

  post "/recipes" do #creates a recipe
    @recipe = Recipe.create(params)
    redirect to "recipes/#{@recipe.id}"
  end

  delete "/recipes/:id" do
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.delete
    redirect to "/recipes"
  end

end
