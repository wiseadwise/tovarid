class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml

  before_filter :authenticate, :except => [:view]
  USERS = { "admin" => "goodgolly" }
  def authenticate
    authenticate_or_request_with_http_digest("Application") do |name|
      USERS[name]
    end
  end

  def list
    @products = Product.all
  end

  def view
    id = params[:id].to_i
    @product = Product.find_by_id(id)
  end

  def new_code
    product = Product.find(params[:id])
    code = product.id
    @cell_sizes = 1..10 
    @code_sizes = 3..10
    if params[:cell_size]
      @cell_size = params[:cell_size].to_i
    else
      params[:cell_size] = 3
      @cell_size = 3
    end
    if params[:code_size]
      @code_size = params[:code_size].to_i
    else
      params[:code_size] = 3
      @code_size = 3
    end
    @qr = RQRCode::QRCode.new("http://tovarid.com/p/v/#{code}",:size => @code_size) 
  end

  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end

end
