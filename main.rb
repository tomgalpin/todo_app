require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :host => 'localhost',
  :username => 'tomgalpin',
  :password => '',
  :database => 'todos_app',
  :encoding => 'utf8'
)

require_relative "todo"

get "/" do
  @todos = Todo.all
  erb :index
end

get "/new_todo" do
  erb :new_todo
end

post "/new_todo" do
  @todo = Todo.new(:name => params[:todo_item], :description => params[:todo_description], :owner => params[:todo_owner])

  if @todo.save
    redirect "/"
  else
    erb :new_todo
  end
end

# This route shows the edit form.
get "/edit_todo/:todo_id" do
  @todo = Todo.find_by_id(params[:todo_id])
  erb :edit_todo
end

# This route processes the submitted form.
post "/save_todo/:todo_id" do
  @todo = Todo.find_by_id(params[:todo_id])

  if @todo.update_attributes(:name => params[:todo_item], :description => params[:todo_description], :owner => params[:todo_owner])
    redirect "/"
  else
    erb :edit_todo
  end
end

post "/toggle_todo/:todo_id" do
  @todo = Todo.find_by_id(params[:todo_id])
  if @todo.status true
    if @todo.save
      redirect "/"
    else
      erb :index
    end
  end
end



















