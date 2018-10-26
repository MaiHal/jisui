class MealsController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'
    require 'pp'
    require 'mechanize'

    @@keyword = ''
    @@restaurant = nil
    @@price = nil

    def select
        @restaurant = @@restaurant
        @price = @@price
        
    end

    def self_search
        @meal = Meal.new
        @categories = recipe_categories['result']['large']
    end

    def out_search
        @keyword = @@keyword
        if !@keyword.nil?
            @restaurants = restaurant_search(@keyword)
        end
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
        @@keyword = params[:keyword]
        redirect_to("/meal/self_search")
    end

    def confirm
        @@restaurant = params[:name]
        @@price = params[:price]
        puts @@restaurant
        redirect_to("/meal/select")
    end
end
