class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]

  # GET /todo_items
  # GET /todo_items.json
  def index
    @todo_items = TodoItem.all
  
    
    # Collect completed tasks
    # block starts ============================
    complete = []
    @todo_items.each do |item|
      if item[:complete] == true
        complete << item 
      end
    end
    # block ends ============================

    @completed_items = complete.count
    @all_items = @todo_items.count

    # Define percentage of completed tasks
    # block starts ============================
    if @all_items > 0
      percentage = (@completed_items).to_f/(@all_items).to_f * 100
      @progress = "#{percentage}%"
    end
    # block ends ============================


    # Define high priority items. Priority are items that are due today.

    priority = []
    @todo_items.each do |item|
      today = Date.today.to_s
      if item[:due].to_s == today
        priority << item
      end
    end

      @todays_tasks = priority.map(&:task)


      tomorrow_array = []
      @todo_items.each do |item|
      tomorrow = Date.tomorrow.to_s
      if item[:due].to_s == tomorrow
        tomorrow_array << item
      end
    end

    @tomorrows_tasks = tomorrow_array.map(&:task)

  end
  # Method ends ============================

  def today
    @todays_tasks
  end


  def tomorrow
   @tomorrows_tasks
  end



  # GET /todo_items/1
  # GET /todo_items/1.json
  def show
  end

  # GET /todo_items/new
  def new
    @todo_item = TodoItem.new

  end

  # GET /todo_items/1/edit
  def edit
  end

  # POST /todo_items
  # POST /todo_items.json
  def create
    @todo_item = TodoItem.new(todo_item_params)

    respond_to do |format|
      if @todo_item.save
        format.html { redirect_to :root, notice: 'Your new task was successfully created.' }
        format.json { render :show, status: :created, location: @todo_item }
      else
        format.html { render :new }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todo_items/1
  # PATCH/PUT /todo_items/1.json
  def update
    respond_to do |format|
      if @todo_item.update(todo_item_params)
        format.html { redirect_to @todo_item, notice: 'Todo item was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo_item }
      else
        format.html { render :edit }
        format.json { render json: @todo_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todo_items/1
  # DELETE /todo_items/1.json
  def destroy
    @todo_item.destroy
    respond_to do |format|
      format.html { redirect_to todo_items_url, notice: 'Todo item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_item_params
      params.require(:todo_item).permit(:task, :description, :complete, :due)
    end
end
