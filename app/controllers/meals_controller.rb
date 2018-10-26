class MealsController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'
    require 'pp'
    require 'mechanize'

    @@keyword = ''
    @@restaurant = nil
    @@out_price = nil
    @@recipe_title = ''
    @@in_price = nil
    @@recipe_image = ''
    @@cooking_time = ''
    @@compare = nil

    def index
        @meals = Meal.order(id: :desc)
    end

    def select
        @restaurant = @@restaurant
        @price = @@out_price
        @recipe_title = @@recipe_title
        @in_price = @@in_price
        @compare = @@compare
    end

    def self_search
        @meal = Meal.new
        @categories = recipe_categories['result']['large']
        @random = random_categories['result'][2]
        puts @random['recipeTitle']
    end

    def out_search
        @keyword = @@keyword
        if !@keyword.nil?
            @restaurants = restaurant_search(@keyword)
        end
    end

    def recipe_detail
        @recipe_title = @@recipe_title 
        @in_price = @@in_price
        @recipe_image = @@recipe_image
        @cooking_time = @@cooking_time
    end

    def random_categories
        agent = Mechanize.new
        url = 'https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?format=json&formatVersion=2&categoryId=14-130-135&applicationId=1025646104690209174'
        res = agent.get(url)
        results = JSON.parse(res.body.force_encoding('UTF-8'))
        return results
    end

    def recipe_categories
        agent = Mechanize.new
        res = agent.get('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?format=json&categoryType=large&applicationId=1025646104690209174')
        results = JSON.parse(res.body.force_encoding('UTF-8'))
        return results
    end

    def restaurant_search(keyword)
        agent = Mechanize.new
        url = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?format=json&key=1e1382208c617774&keyword='+keyword 
        res = agent.get(url)
        results = JSON.parse(res.body.force_encoding('UTF-8'))
        return results['results']['shop']
    end

    def out_submit
        @@keyword = params[:keyword]
        redirect_to("/meal/out_search")
    end

    def in_submit
        @@recipe_title = params[:title]
        @@in_price = params[:cost]
        @@recipe_image = params[:image]
        @@cooking_time = params[:time]
        redirect_to("/meal/menu/detail")
    end

    def confirm
        @@restaurant = params[:name]
        @@out_price = params[:price]
        redirect_to("/meal/select")
    end

    def in_confirm
        redirect_to("/meal/select")
    end

    def compare
        @@compare = params[:compare]
        redirect_to("/meal/select")
    end

    def create
        @meal = Meal.new(
            menu: params[:title],
            out_price: params[:out_price],
            in_price: params[:in_price],
            meal_date: params[:meal_date]
        )
        if @meal.save
            redirect_to("/meal/history")
        else
            render("meal/select")
        end
    end

    def destroy
        @meal = Meal.find_by(id: params[:id])
        puts @meal
        if @meal.destroy
            redirect_to("/meal/history")
        else
            redirect_to("/meal/history")
        end
    end      
end
