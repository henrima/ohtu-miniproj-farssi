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
    @entry = Entry.new(category:params['entry']['category'])

    respond_to do |format|
      if @entry.save and look_what_category_post_is_and_create_fields
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
    @fields = get_fields
        format.html { render :new }
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

    def look_what_category_post_is_and_create_fields
      answer = true
      fields = get_fields

      required_fields = fields[@entry.category]['required']
      required_fields.each do |f|
        # tsekkaa onko ko. fieldi required
        # jos on required, mutta field on tyhjä, palauta false
        # tsekkaa ylempänä että jos on false niin entryn tallennus perutaan
        # params => { 'author' =>  'pekka' }
        parami = params[f]['content']
        if parami.nil? or parami == ''
          answer = false
        end
        field = Field.new(content:parami, name:f, entry_id:@entry.id)
        field.save
      end
      optional_fields = fields[@entry.category]['optional']
      optional_fields.each do |f|
        field = Field.new(content:params[f]['content'], name:f, entry_id:@entry.id)
        field.save
      end
      if !answer
        @entry.destroy
      end
      return answer
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
