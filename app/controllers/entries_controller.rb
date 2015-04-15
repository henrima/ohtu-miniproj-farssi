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

  def newarticle
    @entry = Entry.new(category:"ARTICLE")
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
      if @entry.save
        look_what_category_post_is_and_create_fields
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @entry }
      else
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
      
      fields = get_fields

      correct_fields = fields[@entry.category]
      correct_fields.each do |f|
        # tsekkaa onko ko. fieldi required
        # jos on required, mutta field on tyhjä, palauta false
        # tsekkaa ylempänä että jos on false niin entryn tallennus perutaan
        field = Field.new(content:params[f]['content'], name:f, entry_id:@entry.id)
        field.save
      end
    end

    def get_fields 
      return {
        'ARTICLE' => {
                      'required' => ['author', 'title', 'journal', 'year', 'volume'],
                      'optional' => ['number', 'pages', 'month', 'note', 'key']
                      },
        'BOOK' =>    {
                      'required' => ['author/editor', 'title', 'publisher', 'year'],
                      'optional' => ['volume/number', 'series', 'address', 'edition', 'month', 'note', 'key']
                      },
        'BOOKLET' => {
                      'required' => ['title'], 
                      'optional' => ['author', 'howpublished', 'address', 'month', 'year', 'note', 'key']
                      },
        'CONFERENCE' => {
                      'required' => ['author', 'title', 'booktitle', 'year'], 
                      'optional' => ['editor', 'volume/number', 'series', 'pages', 'address', 'month', 'organization', 'publisher', 'note', 'key']
                      },
        'INBOOK' => {
                      'required' => ['author/editor', 'title', 'chapter/pages', 'publisher', 'year'],
                      'optional' => ['volume/number', 'series', 'type', 'address', 'edition', 'month', 'note', 'key']
                      },
        'INBOOK' => {
                      'required' => ['author/editor', 'title', 'chapter/pages', 'publisher', 'year'],
                      'optional' => ['volume/number', 'series', 'type', 'address', 'edition', 'month', 'note', 'key']
                      },
        'INPROCEEDINGS' => {
                      'required' => ['author', 'title', 'booktitle', 'year'], 
                      'optional' => ['editor', 'volume/number', 'series', 'pages', 'address', 'month', 'organization', 'publisher', 'note', 'key']
                      },
        'MANUAL' => {
                      'required' => ['title'],
                      'optional' => ['author', 'organization', 'address', 'edition', 'month', 'year', 'note', 'key']
                      },
        'MASTERSTHESIS' => {
                      'required' => ['author', 'title', 'school', 'year'],
                      'optional' => ['type', 'address', 'month', 'note', 'key']
                      },
        'MISC' => {
                      'required' => ['none'],
                      'optional' => ['author', 'title', 'howpublished', 'month', 'year', 'note', 'key']
                      },
        'PHDTHESIS' => {
                      'required' => ['author', 'title', 'school', 'year'],
                      'optional' => ['type', 'address', 'month', 'note', 'key']
                      },
        'PROCEEDINGS' => {
                      'required' => ['title', 'year'],
                      'optional' => ['editor', 'volume/number', 'series', 'address', 'month', 'publisher', 'organization', 'note', 'key']
                      },
        'TECHREPORT' => {
                      'required' => ['author', 'title', 'institution', 'year'],
                      'optional' => ['type', 'number', 'address', 'month', 'note', 'key']
                      },
        'UNPUBLISHED' => {
                      'required' => ['author', 'title', 'note'],
                      'optional' => ['month', 'year', 'key']
                      },

      }
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
