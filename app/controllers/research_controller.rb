
class ResearchController < ApplicationController
  def show
    Amazon::Ecs.configure do |options|
      options[:response_group] = 'Large'
      options[:AWS_access_key_id] = '0XQXXC6YV2C85DX1BF02'
      options[:AWS_secret_key] = 'fwLOn0Y/IUXEM8Hk49o7QJV+ryOscbhXRb6CmA5l'
      options[:associate_tag] = 'bookjetty-20'
    end
    #p params["search"]
    #p "dquery aws"
    if params["search"]
      @res = search params["search"]
      render action: "index"
    end
  end

  def index

  end

  def edit
   

  end

  def new

    @asin = params[:asin]

    @item = Nokogiri::XML(
        open("tmp/#{@asin}.xml").read
    )

    @item.remove_namespaces!

    @title ||= @item.xpath( "//Title[1]").first.to_s.sub!(/<Title>/, '').sub(/<\/Title>/, '')
    #p 'title'
    #p @title
    #p @item

  end

  def search(srchstr)
    

    FileUtils.rm_rf(Dir.glob("tmp/*.xml"))
    #options provided on method call will merge with the default options
    @res = Amazon::Ecs.item_search('ruby', {:response_group => 'Medium', :sort => 'salesrank'})

    # search amazon uk
    #@res = Amazon::Ecs.item_search('ruby', :country => 'uk')

    # search all items, default search index is Books
    @res = Amazon::Ecs.item_search(srchstr, :search_index => 'All')

    #@res = Amazon::Ecs.item_search('GC23089', :search_index => 'All')

    #@res = Amazon::Ecs.item_search('685387306008', {:type => 'UPC', :search_index => 'All'})

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
    @res.items.each_with_index do |item|
      # retrieve string value using XML path
      #session[item.get('ASIN')] = item.to_s
      f = File.new("tmp/#{item.get('ASIN')}.xml", File::CREAT|File::TRUNC|File::RDWR)
      f.write(item.to_s)
      f.close
      item.get('ASIN')
      #p item.get_element('ItemAttributes')
      #p 'item'
      #p item
      #p 'sku'
      #p item.get_element('ItemAttributes').get('SKU')
      #p item.get_element('ItemAttributes').get('Model')
      #p item
    end
    @res
  end

end