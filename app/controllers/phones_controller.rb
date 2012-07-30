class PhonesController < ApplicationController

  def index
    @phones = Phone.all
  end

  def create
    @phone = Phone.new(params[:phone])
    @phone.save

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @phone = Phone.find(params[:id])
    @phone.destroy if @phone

    respond_to do |format|
      format.js
    end
  end

  def edit
    @phone = Phone.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def show
    @phone = Phone.find(params[:id])

    respond_to do |format|
      format.js
    end
  end

  def update
    @phone = Phone.find(params[:id])
    @phone.update_attributes(params[:phone])

    respond_to do |format|
      format.js
    end
  end

  def download
    send_data(Phone.to_text, filename: "phonebook.txt")
  end

  def upload
    phonebook = params[:upload][:phonebook] if params[:upload]
    if phonebook && phonebook.content_type == 'text/plain'
      Phone.from_text(phonebook.tempfile)
    end

    redirect_to root_path
  end
end