# $Id$

require 'test/unit'
require 'rubygems'
require 'action_controller'
require 'action_controller/test_process'

require 'init.rb'

class TestController < ActionController::Base
  def show
    @title = 'hello'
    render :template => "#{params[:id]}.red", :layout => false
  end
end

TestController.view_paths = [ File.dirname(__FILE__) + '/fixtures/' ]
ActionController::Routing::Routes.reload rescue nil

class RedClothTemplateTest < Test::Unit::TestCase
  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @controller = TestController.new
  end

  def test_textile
    get :show, :id => 'textile'
    assert_equal "<h1>hello</h1>", @response.body
  end

  def test_erb
    get :show, :id => 'erb'
    assert_equal "<p>2</p>", @response.body
  end
end
