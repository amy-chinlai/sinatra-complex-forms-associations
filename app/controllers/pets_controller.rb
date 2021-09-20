class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(:name => params[:pet_name])
    if params[:pet][:owner_id].present?
      @pet.owner = Owner.find_by_id(params[:pet][:owner_id])
    else
      @pet.owner = Owner.create(:name => params[:pet][:owner_name])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet_name]
    # binding.pry
    if params[:owner][:name].present?
      @pet.owner = Owner.create(:name => params[:owner][:name])
    else
      @pet.owner = Owner.find(params[:pet][:owner_id])
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end


end