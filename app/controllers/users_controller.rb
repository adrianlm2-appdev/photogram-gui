class UsersController < ApplicationController

  def index

    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc})

    render({ :template => "user_templates/index.html.erb" })
  end 

  def show 

  input_username = params.fetch("path_username")

  matching_usernames = User.where({ :username => input_username  })

  @the_user = matching_usernames.first

  render({ :template => "user_templates/show.html.erb" })
  end


  def create
    #parameters: {"input_image"=>"a", "input_caption"=>"b", "input_owner_id"=>"c"}
  
    input_user = params.fetch("input_username")

    a_new_user = User.new
    a_new_user.username = input_user
    a_new_user.save
  
    #render(:template => "photo_templates/create.html.erb")
    redirect_to("/users/" + a_new_user.id.to_s)
    end 
  
    def update 
      input_user = params.fetch("input_username")

      a_new_user = User.new
      a_new_user.username = input_user
      a_new_user.save
    
      #render(:template => "photo_templates/create.html.erb")
      redirect_to("/users/" + a_new_user.id.to_s)
    end 
end
