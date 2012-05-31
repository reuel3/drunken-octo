class AccountsController < ApplicationController
  
  include Databasedotcom::Rails::Controller

  def index
    @accounts = Merchandise__c.all
    
    config = YAML.load_file(File.join(::Rails.root, 'config', 'databasedotcom.yml'))
    puts "-------------------------------------------------------------------------------------"
    puts config["username"]
    puts config["password"]
    puts "======================================================================================"
  end

  def new
    config = YAML.load_file(File.join(::Rails.root, 'config', 'databasedotcom.yml'))
    client = Databasedotcom::Client.new(config)          
    client.authenticate :username => config[:username], :password => config[:password]
    puts "--------------------------------------------------------------------------------"
    puts client.materialize("Merchandise__c")
    puts "================================================================================"

    parentId = client.query("select ParentId from account where name like 'First Account'")
    
    @account = Merchandise__c.new
  end

  def search
    config = YAML.load_file(File.join(::Rails.root, 'config', 'databasedotcom.yml'))
    client = Databasedotcom::Client.new(config)          
    client.authenticate :username => config[:username], :password => config[:password]
    @accounts = client.query("select id, name from merchandise where name like 'jet%'")
  end

  def create
    Merchandise__c.create Merchandise__c.coerce_params(params[:account])
    redirect_to accounts_path
  end

  def show
    @account = Merchandise__c.find(params[:id])
  end
  
  def edit
  
    @account = Merchandise__c.find(params[:id])
    puts "EDITBEGIN++++++++++++++++++++++++++++++++++++++++++++++++++"
    puts @account
    puts "EDITEND++++++++++++++++++++++++++++++++++++++++++++++++++++"
    
  end

  def update
    @account = Merchandise__c.find(params[:id])
    @account.update_attributes(params[:user])
    render "show"
  end
end
