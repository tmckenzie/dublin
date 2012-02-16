class SuppliersController < ApplicationController
  # GET /suppliers
  # GET /suppliers.json
  def index
    @suppliers = Supplier.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suppliers }
    end
  end

  # GET /suppliers/1
  # GET /suppliers/1.json
  def show

    p "display suppliers"
    @supplier = Supplier.find(params[:id])
    #AWS_ACCESS_KEY_ID = '0XQXXC6YV2C85DX1BF02'
    #    AWS_SECRET_KEY = 'fwLOn0Y/IUXEM8Hk49o7QJV+ryOscbhXRb6CmA5l'
    #
    #raise "Please specify set your AWS_ACCESS_KEY_ID" if AWS_ACCESS_KEY_ID.empty?
    #raise "Please specify set your AWS_SECRET_KEY" if AWS_SECRET_KEY.empty?

    Amazon::Ecs.configure do |options|
      options[:response_group] = 'Large'
      options[:AWS_access_key_id] = '0XQXXC6YV2C85DX1BF02'
      options[:AWS_secret_key] = 'fwLOn0Y/IUXEM8Hk49o7QJV+ryOscbhXRb6CmA5l'
      options[:associate_tag] = 'bookjetty-20'
    end


    #options provided on method call will merge with the default options
    @res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium', :sort => 'salesrank'})

    # search amazon uk
    @res = Amazon::Ecs.item_search('ruby', :country => 'uk')

    # search all items, default search index is Books
    #@res = Amazon::Ecs.item_search('ruby', :search_index => 'All')

    #@res = Amazon::Ecs.item_search('GC23089', :search_index => 'All')

    @res = Amazon::Ecs.item_search('685387306008', {:type => 'UPC', :search_index => 'All' })

 #@res = Amazon::Ecs.item_search()
    # some common response object methods
    @res.is_valid_request? # return true if request is valid
    @res.has_error? # return true if there is an error
    @res.error # return error message if there is any
    @res.total_pages # return total pages
    @res.total_results # return total results
    @res.item_page # return current page no if :item_page option is provided
    @total = @res.items.count
    #p @res.items.count

    # traverse through each item (Amazon::Element)
    @res.items.each do |item|
      # retrieve string value using XML path
      item.get('ASIN')
     #p item.get_element('ItemAttributes')
     # p 'item'
     # p item
     # p 'sku'
     # p item.get_element('ItemAttributes').get('SKU')
      #p item.get_element('ItemAttributes').get('Model')
      #p item
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @supplier }
    end
  end

  # GET /suppliers/new
  # GET /suppliers/new.json
  def new
    @supplier = Supplier.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @supplier }
    end
  end

  # GET /suppliers/1/edit
  def edit
    @supplier = Supplier.find(params[:id])
  end

  # POST /suppliers
  # POST /suppliers.json
  def create
    @supplier = Supplier.new(params[:supplier])

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to @supplier, notice: 'Supplier was successfully created.' }
        format.json { render json: @supplier, status: :created, location: @supplier }
      else
        format.html { render action: "new" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suppliers/1
  # PUT /suppliers/1.json
  def update
    @supplier = Supplier.find(params[:id])

    respond_to do |format|
      if @supplier.update_attributes(params[:supplier])
        format.html { redirect_to @supplier, notice: 'Supplier was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @supplier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suppliers/1
  # DELETE /suppliers/1.json
  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy

    respond_to do |format|
      format.html { redirect_to suppliers_url }
      format.json { head :ok }
    end
  end
end
