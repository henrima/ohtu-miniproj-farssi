require 'entry_validator'

class EntriesController < ApplicationController
  before_action :set_entry, only: [:show, :edit, :update, :destroy]


  # GET /entries
  # GET /entries.json
  def index
    @entries = Entry.all
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @fields = get_fields
  end

  def new_thing
    @entry = Entry.new(category:params['category'])
    @fields = get_fields
  end

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    category = params['entry']['category']
    clean_params = EntryValidator.clean_params category, params
    @entry = Entry.new(category:category)
    entry_valid = EntryValidator.validate @entry, clean_params

    respond_to do |format|
      if entry_valid and @entry.save and create_fields(clean_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
        @fields = get_fields
        format.html { render :new_thing }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @entry }
      else
        format.html { render :edit }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy
    respond_to do |format|
      format.html { redirect_to entries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def create_fields(params)
      params.each do |field, content|
        field = Field.new(content:content, name:field, entry_id:@entry.id)
        if !field.save
          # TODO: remove fields which were saved + entry
          return false
        end
      end
      return true
    end

    def get_fields 
      EntryValidator.field_db
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_entry
      @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      #asd
      #params.require(:entry).permit(:category)
    end
end
