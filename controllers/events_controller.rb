class App
  # your routes go here

  get '/' do
    redirect "/events"
  end

  get '/events' do
    events = Event.all
    erb :'events/index', locals: { events: events}
  end

  get '/events/new' do
    events = Event.all
    erb :'events/new', locals: { events: events}
  end

  get '/events/:id' do
    event = Event.find(params[:id])
    erb :'events/show', locals: { event: event }
  end

  get '/events/:id/edit' do
    event = Event.find(params[:id])
    erb :'events/edit', locals: { event:event}
  end

  post '/events' do
    event = Event.new(params)
    event.save!
    events = Event.all

    erb :'events/index', locals: { events: events }
  end

  put '/events/:id' do
    event = Event.find(params[:id])
    event.update_attributes(title: params[:title], description: params[:description], starts_at: params[:starts_at], ends_at: params[:ends_at])

    redirect "events/#{event.id}"
  end

  delete '/events/:id' do
    event = Event.find(params[:id])
    event.destroy

    redirect "/events"
  end
end
