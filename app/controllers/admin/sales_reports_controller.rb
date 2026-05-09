class Admin::SalesReportsController < Admin::BaseController
  def show
    @year = (params[:year] || Date.current.year).to_i
    @month = (params[:month] || Date.current.month).to_i
    @report = MonthlySalesQuery.call(year: @year, month: @month)
  end
end
