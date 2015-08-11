require 'recipes/meal_plan_generator'

class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:main]

  def main
    if current_user
      plan_meal = PlanMeal.find_by(meal_date: Date.today)
      if plan_meal
        @meal = Meal.new(plan_meal.meal_id, plan_meal.meal_date)
        render 'today_meal'
      else
        redirect_to '/recipes'
      end
    else
      redirect_to '/recipes'
    end
  end

  def index
    @plans = Plan.all
  end

  def show
  end

  def groceries

  end

  # GET /plans/new
  def new
    start_date = Date.today
    end_date = start_date + 6.days
    @plan = MealPlanGenerator.create(current_user.id, start_date, end_date)
    save_plan(@plan)
    @recipes = Recipe.for(current_user.id)
  end

  def save_plan(plan)
    plan.save
    plan.meals.each_with_index do |meal, index|
      meal_date = plan.start_date + index.days
      PlanMeal.find_or_create_by(plan_id: plan.id, meal_id: meal.id, meal_date: meal_date)
      meal.recipes.each do |recipe|
        MealRecipe.find_or_create_by(meal_id: meal.id, recipe_id: recipe.id, user_id: current_user.id)
      end
    end
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:start_date, :end_date)
    end
end
