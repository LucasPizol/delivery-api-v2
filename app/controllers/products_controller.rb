class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy ]
  skip_before_action :authorization, only: %i[show load_by_company]

  # GET /products/1
  def show
    render json: @product
  end

  def load_by_company
    products = Product.where(company_id: params[:company_id])

    render json: products
  end

  # POST /products
  def create
    copy_product_params = product_params.dup

    if product_params[:image].nil?
      return render json: { message: "image is required" }, status: :bad_request
    end

    image = product_params[:image]

    extension = File.extname(image.original_filename)
    now = Time.now.strftime("%d%m%Y")

    url = AwsService.new.insert(image, "products/#{copy_params[:name].parameterize}/#{image.original_filename.gsub(extension, "").parameterize}-#{now}#{extension}")
    copy_product_params[:image] = url
    copy_product_params[:company_id] = @current_user.company_id

    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :quantity, :image)
    end
end
