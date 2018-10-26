class MealsController < ApplicationController
    require 'net/http'
    require 'uri'
    require 'json'
    require 'pp'
    require 'mechanize'

    def select
    end

    def self_search
        @meal = Meal.new
        @categories = recipe_categories['result']['large']
    end

    def out_search
        @meal = Meal.new
        @categories = recipe_categories['result']['large']
    end

    

    def recipe_categories
        agent = Mechanize.new
        res = agent.get('https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?format=json&categoryType=large&applicationId=1025646104690209174')
        results = JSON.parse(res.body.force_encoding('UTF-8'))
        return results
    end

    def submit
        redirect_to("/")
    end
end
