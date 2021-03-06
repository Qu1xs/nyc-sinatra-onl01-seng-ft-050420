class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end 
  
  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all 
    erb :"/figures/new"
  end 

  post '/figures' do 
    figure = Figure.create(params[:figure])

    unless params[:title][:name].empty?
      figure.titles << Title.find_or_create_by(params[:title])
    end 
    
    unless params[:landmark][:name].empty?
      figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end 

    redirect to "/figures/#{figure.id}"
  end 

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @titles = Title.all 
    @landmarks = Landmark.all 
    erb :"/figures/edit"
  end 

  patch '/figures/:id' do
    unless params[:figure].keys.include?("title_ids") && params[:figure].keys.include?("landmark_ids")
      params[:figure]["title_ids"] = []
      params[:figure]["landmark_ids"] = []
    end 

    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    unless params[:title][:name].empty?
      figure.titles << Title.find_or_create_by(params[:title])
    end 
    
    unless params[:landmark][:name].empty?
      figure.landmarks << Landmark.find_or_create_by(params[:landmark])
    end

    redirect to "/figures/#{@figure.id}"
  end 

end