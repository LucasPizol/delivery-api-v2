class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show update destroy ]
  before_action -> { authorization([ "user" ]) }, except: %i[ index show ]


  # GET /companies
  def index
    @companies = Company.all

    render json: @companies
  end

  # GET /companies/1
  def show
    render json: @company
  end

  # PATCH/PUT /companies/1
  def update
    company = Company.find(@current_user[:company_id])

    if company.update(company_params)
      render json: company
    else
      render json: company.errors, status: :unprocessable_entity
    end
  end

  # DELETE /companies/1
  def destroy
    company = Company.find(@current_user[:company_id])
    company.destroy!
  end

  private
  def company_params
    params.require(:company).permit(:name, :document, :phone)
  end
end
