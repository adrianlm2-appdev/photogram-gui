class PhotosController < ApplicationController
  def index

    matching_photos = Photo.all 

    @list_of_photos = matching_photos.order({ :created_at => :desc })
    render({ :template => "photo_templates/index.html.erb" })
  end 

  def show
    url_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => url_id})
    @the_photo = matching_photos.first
    render(:template => "photo_templates/show.html.erb")
  end 

  def delete
    the_id = params.fetch("path_id")
    matching_photos = Photo.where({ :id => the_id })
    the_photo = matching_photos.at(0)
    the_photo.destroy

  #render(:template => "photo_templates/delete.html.erb")
  redirect_to("/photos")
  end

  def create
  #parameters: {"input_image"=>"a", "input_caption"=>"b", "input_owner_id"=>"c"}

  input_image = params.fetch("input_image")
  input_caption = params.fetch("input_caption")
  input_owner_id = params.fetch("input_owner_id")

  a_new_photo = Photo.new

  a_new_photo.image = input_image
  a_new_photo.caption = input_caption
  a_new_photo.owner_id = input_owner_id

  a_new_photo.save

  #render(:template => "photo_templates/create.html.erb")
  redirect_to("/photos/" + a_new_photo.id.to_s)
  end 

  def update
#Parameters: {"input_image"=>"https://robohash.org/dolorehicincidunt.png?size=300x300&set=set1", "input_caption"=>"hi", "modify_id"=>"777"}

  the_id = params.fetch("modify_id")
  matching_photos = Photo.where({ :id => the_id })
  the_photo = matching_photos.at(0)

  input_image = params.fetch("input_image")
  input_caption = params.fetch("input_caption")

  the_photo.image = input_image
  the_photo.caption = input_caption

  the_photo.save

  redirect_to("/photos/" + the_photo.id.to_s)

  #render(:template => "photo_templates/update.html.erb")
  end 

  def comment
#parameters: {"input_photo_id"=>"777", "input_author_id"=>"", "input_body"=>"", "controller"=>"photos", "action"=>"comment"}

the_id = params.fetch("input_photo_id")
the_commenter = params.fetch("input_author_id")
the_body = params.fetch("input_body")

matching_photos = Photo.where({ :id => the_id })
the_photo = matching_photos.at(0)

new_comment = Comment.new 

new_comment.author_id = the_commenter
new_comment.photo_id = the_id
new_comment.body = the_body

new_comment.save

redirect_to("/photos/" + the_photo.id.to_s)
  end
end 