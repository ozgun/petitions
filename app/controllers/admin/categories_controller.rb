class Admin::CategoriesController < ApplicationController
  before_filter :require_admin
end
