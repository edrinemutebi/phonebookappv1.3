class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]

  def index
    # if params[:q].present?
    #   @people = search
    # else
      @people = Person.all
    # end
  end

  def tbirthdays
    @today_people = find_people_with_birthday_today
  end
  
  # def search
  #   @people = Person.where("name LIKE ? OR phone LIKE ? OR birthday = ?", "%#{params[:q]}%", "%#{params[:q]}%", params[:q])
  #   render :index
  # end

  # def search
  #   render :index
  # end
  
  def birthdays
    @today_people = find_people_with_birthday_today
  end

  def show
    @person = Person.find(params[:id])
  end
  


  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to person_url(@person), notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to person_url(@person), notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  
  def set_person
    if params[:id] == "search"
      @person = Person.find_by(name: params[:q])
      if @person.nil?
        # handle the case where no person was found for the search query
      end
    else
      @person = Person.find(params[:id])
    end
  end
  


 
  

  def person_params
    params.require(:person).permit(:name, :phone, :email, :gender, :birthday)
  end

  def find_people_with_birthday_today
    Person.where("strftime('%m', birthday) = ? AND strftime('%d', birthday) = ?", Date.today.strftime('%m'), Date.today.strftime('%d'))
  end
  
end
